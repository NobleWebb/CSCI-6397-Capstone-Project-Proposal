// routes/compliance.js
// Compliance status endpoints - the core feature for Milestone 2.

const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/auth');
const db = require('../database');
const { calculateScore, scoreByFamily } = require('../services/scoring');
const { validateControlUpdate, validateRequest } = require('../utils/validators');

// GET /api/compliance/score -> overall compliance % and maturity average
// Must be defined before /:controlId so "score" isn't treated as a controlId
router.get('/score', authMiddleware, async (req, res, next) => {
  try {
    const result = await db.query(
      `SELECT cs.control_id, cs.answer, cs.rating, c.control_family
       FROM compliance_status cs
       JOIN controls c ON cs.control_id = c.control_id
       WHERE cs.user_id = $1`,
      [req.user.userId]
    );

    const overall = calculateScore(result.rows);
    const byFamily = scoreByFamily(result.rows);

    res.json({ overall, byFamily });
  } catch (err) {
    next(err);
  }
});

// GET /api/compliance -> all of this user's compliance records
router.get('/', authMiddleware, async (req, res, next) => {
  try {
    const result = await db.query(
      `SELECT cs.status_id, cs.control_id, c.control_name, c.control_family,
              c.nist_standard, c.phase, cs.answer, cs.rating, cs.evidence, cs.updated_at
       FROM compliance_status cs
       JOIN controls c ON cs.control_id = c.control_id
       WHERE cs.user_id = $1
       ORDER BY cs.control_id`,
      [req.user.userId]
    );

    res.json(result.rows);
  } catch (err) {
    next(err);
  }
});

// PUT /api/compliance/:controlId -> save an answer + rating for one control
router.put('/:controlId', authMiddleware, validateControlUpdate, validateRequest, async (req, res, next) => {
  try {
    const { controlId } = req.params;
    const { answer, rating, evidence } = req.body;

    // Verify the control exists
    const controlCheck = await db.query(
      'SELECT control_id FROM controls WHERE control_id = $1',
      [controlId]
    );

    if (controlCheck.rows.length === 0) {
      return res.status(404).json({ error: 'Control not found' });
    }

    // Upsert: insert or update using the UNIQUE(user_id, control_id) constraint
    const result = await db.query(
      `INSERT INTO compliance_status (user_id, control_id, answer, rating, evidence, updated_at, updated_by)
       VALUES ($1, $2, $3, $4, $5, NOW(), $1)
       ON CONFLICT (user_id, control_id)
       DO UPDATE SET answer = $3, rating = $4, evidence = $5, updated_at = NOW(), updated_by = $1
       RETURNING *`,
      [req.user.userId, controlId, answer, rating || null, evidence || null]
    );

    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

module.exports = router;
