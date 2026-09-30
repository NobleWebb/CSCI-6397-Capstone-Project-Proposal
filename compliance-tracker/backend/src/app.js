// app.js - builds the Express application.
// This file deliberately does NOT call app.listen(). That happens in server.js.
// Keeping them separate lets the test suite import the app and make requests
// against it without opening a real network port.

require('dotenv').config();
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');

const app = express();

// --- Security middleware ---------------------------------------------------
app.use(helmet()); // sets secure HTTP headers
app.use(cors({
  origin: process.env.FRONTEND_URL || 'http://localhost:3000',
  credentials: true
}));

// Rate limiting protects against brute-force attempts.
// Disabled under test so the suite can fire hundreds of requests quickly.
if (process.env.NODE_ENV !== 'test') {
  app.use(rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100                  // requests per IP per window
  }));
}

// --- Body parsing ----------------------------------------------------------
app.use(express.json({ limit: '10kb' }));

// --- Request logging (quiet during tests) ----------------------------------
if (process.env.NODE_ENV !== 'test') {
  app.use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] ${req.method} ${req.path}`);
    next();
  });
}

// --- Routes ----------------------------------------------------------------
app.get('/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

app.use('/api/auth', require('./routes/auth'));
app.use('/api/controls', require('./routes/controls'));
app.use('/api/compliance', require('./routes/compliance'));
app.use('/api/dashboard', require('./routes/dashboard'));

// 404 for anything not matched above
app.use((req, res) => {
  res.status(404).json({ error: 'Not found' });
});

// --- Error handler ---------------------------------------------------------
// eslint-disable-next-line no-unused-vars
app.use((err, req, res, next) => {
  if (process.env.NODE_ENV !== 'test') console.error('Error:', err);
  res.status(err.status || 500).json({
    error: process.env.NODE_ENV === 'production' ? 'Internal Server Error' : err.message
  });
});

module.exports = app;
