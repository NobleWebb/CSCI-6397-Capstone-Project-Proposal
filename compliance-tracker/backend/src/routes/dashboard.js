const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/auth');

// Dashboard routes
router.get('/summary', authMiddleware, (req, res) => {
  res.json({ message: 'Dashboard summary - to be implemented' });
});

router.get('/family-stats', authMiddleware, (req, res) => {
  res.json({ message: 'Family statistics - to be implemented' });
});

module.exports = router;
