const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const db = require('../database');

// --- In-memory login rate-limiter (per IP) ---
const loginAttempts = new Map(); // key: IP, value: { count, firstAttempt }
const LOGIN_WINDOW_MS = 15 * 60 * 1000; // 15 minutes
const MAX_LOGIN_PER_IP = 15; // max login attempts per IP per window

function checkLoginRateLimit(ip) {
  const now = Date.now();
  const record = loginAttempts.get(ip);
  if (!record || now - record.firstAttempt > LOGIN_WINDOW_MS) {
    loginAttempts.set(ip, { count: 1, firstAttempt: now });
    return true;
  }
  record.count++;
  return record.count <= MAX_LOGIN_PER_IP;
}

// --- Account lockout settings ---
const MAX_FAILED_ATTEMPTS = 5;
const LOCKOUT_DURATION_MS = 15 * 60 * 1000; // 15 minutes

// --- Validation helpers ---
function validateEmail(email) {
  // RFC 5322 simplified — covers nearly all real-world addresses
  const re = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;
  return re.test(email) && email.length <= 255;
}

function validatePassword(password) {
  const errors = [];
  if (password.length < 8) errors.push('at least 8 characters');
  if (!/[A-Z]/.test(password)) errors.push('one uppercase letter');
  if (!/[a-z]/.test(password)) errors.push('one lowercase letter');
  if (!/[0-9]/.test(password)) errors.push('one number');
  if (!/[!@#$%^&*()_+\-=[\]{};':"\\|,.<>/?`~]/.test(password)) errors.push('one special character');
  return errors;
}

// ============================================================
// POST /api/auth/register — create a new account
// ============================================================
router.post('/register', async (req, res) => {
  try {
    const { email, password, confirmPassword, name } = req.body;

    // --- Basic presence checks ---
    if (!email || !password || !confirmPassword) {
      return res.status(400).json({ error: 'Email, password, and password confirmation are required' });
    }

    // --- Email validation ---
    if (!validateEmail(email)) {
      return res.status(400).json({ error: 'Please enter a valid email address' });
    }

    // --- Password strength ---
    const pwErrors = validatePassword(password);
    if (pwErrors.length > 0) {
      return res.status(400).json({
        error: 'Password does not meet requirements',
        requirements: pwErrors
      });
    }

    // --- Confirm match ---
    if (password !== confirmPassword) {
      return res.status(400).json({ error: 'Passwords do not match' });
    }

    // --- Check if email already taken ---
    const existing = await db.query(
      'SELECT user_id FROM users WHERE LOWER(email) = LOWER($1)',
      [email.trim()]
    );
    if (existing.rows.length > 0) {
      return res.status(409).json({ error: 'An account with this email already exists' });
    }

    // --- Hash & insert ---
    const hash = await bcrypt.hash(password, 12); // 12 salt rounds for production
    const result = await db.query(
      `INSERT INTO users (email, password, name)
       VALUES ($1, $2, $3)
       RETURNING user_id, email, name`,
      [email.trim().toLowerCase(), hash, (name || '').trim() || null]
    );

    const user = result.rows[0];

    // Issue JWT immediately so user is logged in after registration
    const tokenPayload = { userId: user.user_id, email: user.email };
    const jwtToken = jwt.sign(tokenPayload, process.env.JWT_SECRET, {
      expiresIn: process.env.JWT_EXPIRE || '24h'
    });

    res.status(201).json({
      message: 'Account created successfully',
      token: jwtToken,
      user: { userId: user.user_id, email: user.email, name: user.name }
    });
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ error: 'Registration failed. Please try again.' });
  }
});

// ============================================================
// POST /api/auth/login — authenticate user and return JWT
// ============================================================
router.post('/login', async (req, res) => {
  try {
    const ip = req.ip || req.connection.remoteAddress || 'unknown';

    // --- Per-IP rate limiting ---
    if (!checkLoginRateLimit(ip)) {
      return res.status(429).json({
        error: 'Too many login attempts. Please wait 15 minutes before trying again.'
      });
    }

    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password are required' });
    }

    if (!validateEmail(email)) {
      return res.status(400).json({ error: 'Please enter a valid email address' });
    }

    // --- Look up user ---
    const result = await db.query(
      'SELECT user_id, email, password, failed_login_attempts, locked_until FROM users WHERE LOWER(email) = LOWER($1)',
      [email.trim()]
    );

    if (result.rows.length === 0) {
      // Don't reveal whether the email exists
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    const user = result.rows[0];

    // --- Check account lockout ---
    if (user.locked_until && new Date(user.locked_until) > new Date()) {
      const minutesLeft = Math.ceil((new Date(user.locked_until) - new Date()) / 60000);
      return res.status(423).json({
        error: `Account is locked due to too many failed attempts. Try again in ${minutesLeft} minute${minutesLeft !== 1 ? 's' : ''}.`,
        lockedUntil: user.locked_until
      });
    }

    // --- Verify password with bcrypt ---
    const validPassword = await bcrypt.compare(password, user.password);

    if (!validPassword) {
      // Increment failed attempts
      const newAttempts = (user.failed_login_attempts || 0) + 1;
      const updates = { attempts: newAttempts, lockUntil: null };

      if (newAttempts >= MAX_FAILED_ATTEMPTS) {
        // Lock the account
        updates.lockUntil = new Date(Date.now() + LOCKOUT_DURATION_MS).toISOString();
        await db.query(
          'UPDATE users SET failed_login_attempts = $1, locked_until = $2 WHERE user_id = $3',
          [newAttempts, updates.lockUntil, user.user_id]
        );
        return res.status(423).json({
          error: `Account locked after ${MAX_FAILED_ATTEMPTS} failed attempts. Try again in 15 minutes.`,
          lockedUntil: updates.lockUntil
        });
      } else {
        await db.query(
          'UPDATE users SET failed_login_attempts = $1 WHERE user_id = $2',
          [newAttempts, user.user_id]
        );
        const remaining = MAX_FAILED_ATTEMPTS - newAttempts;
        return res.status(401).json({
          error: `Invalid email or password. ${remaining} attempt${remaining !== 1 ? 's' : ''} remaining before account lockout.`
        });
      }
    }

    // --- Successful login — reset failed attempts ---
    if (user.failed_login_attempts > 0 || user.locked_until) {
      await db.query(
        'UPDATE users SET failed_login_attempts = 0, locked_until = NULL WHERE user_id = $1',
        [user.user_id]
      );
    }

    const tokenPayload = { userId: user.user_id, email: user.email };
    const jwtToken = jwt.sign(tokenPayload, process.env.JWT_SECRET, {
      expiresIn: process.env.JWT_EXPIRE || '24h'
    });

    res.json({
      message: 'Login successful',
      token: jwtToken,
      user: { userId: user.user_id, email: user.email }
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Login failed. Please try again.' });
  }
});

module.exports = router;
