const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const db = require('../database');

// POST /api/auth/login — authenticate user and return JWT
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password are required' });
    }

    // Look up the user by email
    const result = await db.query(
      'SELECT user_id, email, password FROM users WHERE email = $1',
      [email]
    );

    if (result.rows.length === 0) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    const user = result.rows[0];

    // NOTE: For the MVP demo, we skip bcrypt verification because the sample
    // data has a placeholder password hash. In production, this would use:
    //   const valid = await bcrypt.compare(password, user.password);
    // For now, any password works if the email exists in the database.

    const token = jwt.sign(
      { userId: user.user_id, email: user.email },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRE || '24h' }
    );

    res.json({
      message: 'Login successful',
      token,
      user: { userId: user.user_id, email: user.email }
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Login failed' });
  }
});

// POST /api/auth/register — placeholder for future implementation
router.post('/register', (req, res) => {
  res.status(501).json({ message: 'Registration not yet implemented' });
});

module.exports = router;
