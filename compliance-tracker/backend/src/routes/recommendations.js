// routes/recommendations.js
// Recommends related controls based on completed compliance assessments.
// Uses the related_controls TABLE (source_control_id → target_control_id)
// rather than a column on the controls table.

const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/auth');
const db = require('../database');

// GET /api/recommendations -> related controls the user should work on next
router.get('/', authMiddleware, async (req, res, next) => {
  try {
    // 1. Get all controls the user has marked as "Yes" (compliant)
    const completedRes = await db.query(
      `SELECT cs.control_id, c.control_name, c.control_family
       FROM compliance_status cs
       JOIN controls c ON cs.control_id = c.control_id
       WHERE cs.user_id = $1 AND cs.answer = 'Yes'`,
      [req.user.userId]
    );

    const completedControls = completedRes.rows;
    const completedIds = new Set(completedControls.map(r => r.control_id));

    if (completedIds.size === 0) {
      return res.json({ recommendations: [], completedCount: 0, totalRecommended: 0 });
    }

    // 2. Find all related controls from the related_controls table
    //    where a completed control is the source
    const placeholders = [...completedIds].map((_, i) => '$' + (i + 1)).join(',');
    const relRes = await db.query(
      `SELECT source_control_id, target_control_id
       FROM related_controls
       WHERE source_control_id IN (${placeholders})`,
      [...completedIds]
    );

    // Build sourceMap: target_control_id -> [source_control_ids that link to it]
    const relatedIdSet = new Set();
    const sourceMap = {};

    relRes.rows.forEach(row => {
      const target = row.target_control_id;
      relatedIdSet.add(target);
      if (!sourceMap[target]) sourceMap[target] = [];
      sourceMap[target].push(row.source_control_id);
    });

    // 3. Filter out controls the user has already completed
    const candidateIds = [...relatedIdSet].filter(id => !completedIds.has(id));

    if (candidateIds.length === 0) {
      return res.json({ recommendations: [], completedCount: completedIds.size, totalRecommended: 0 });
    }

    // 4. Fetch details for recommended controls, including the user's current status
    const candPlaceholders = candidateIds.map((_, i) => '$' + (i + 2)).join(',');
    const recRes = await db.query(
      `SELECT c.control_id, c.control_name, c.control_family, c.nist_standard, c.phase,
              cs.answer, cs.rating
       FROM controls c
       LEFT JOIN compliance_status cs ON c.control_id = cs.control_id AND cs.user_id = $1
       WHERE c.control_id IN (${candPlaceholders})
       ORDER BY c.control_family, c.control_id`,
      [req.user.userId, ...candidateIds]
    );

    // 5. Build response with link count (how many completed controls reference it)
    const recommendations = recRes.rows.map(r => ({
      control_id: r.control_id,
      control_name: r.control_name,
      control_family: r.control_family,
      nist_standard: r.nist_standard,
      phase: r.phase,
      current_answer: r.answer || null,
      current_rating: r.rating || null,
      linked_from: sourceMap[r.control_id] || [],
      link_count: (sourceMap[r.control_id] || []).length
    }));

    // Sort by link_count descending (most referenced first), then by family
    recommendations.sort((a, b) => {
      if (b.link_count !== a.link_count) return b.link_count - a.link_count;
      return a.control_id.localeCompare(b.control_id);
    });

    res.json({
      recommendations,
      completedCount: completedIds.size,
      totalRecommended: recommendations.length
    });
  } catch (err) {
    next(err);
  }
});

// GET /api/recommendations/connections/:controlId
// Returns a control's full details + what references it + what it leads to
router.get('/connections/:controlId', authMiddleware, async (req, res, next) => {
  try {
    const controlId = req.params.controlId;

    // 1. Get the control itself with user's current status
    const controlRes = await db.query(
      `SELECT c.control_id, c.control_name, c.control_family, c.nist_standard,
              c.phase,
              cs.answer, cs.rating, cs.evidence
       FROM controls c
       LEFT JOIN compliance_status cs ON c.control_id = cs.control_id AND cs.user_id = $1
       WHERE c.control_id = $2`,
      [req.user.userId, controlId]
    );

    if (controlRes.rows.length === 0) {
      return res.status(404).json({ error: 'Control not found' });
    }

    const control = controlRes.rows[0];

    // 2. "Leads to" — controls this one points to in related_controls table
    const leadsToRes = await db.query(
      `SELECT c.control_id, c.control_name, c.control_family, c.phase,
              cs.answer, cs.rating
       FROM related_controls rc
       JOIN controls c ON rc.target_control_id = c.control_id
       LEFT JOIN compliance_status cs ON c.control_id = cs.control_id AND cs.user_id = $1
       WHERE rc.source_control_id = $2
       ORDER BY c.control_family, c.control_id`,
      [req.user.userId, controlId]
    );

    const leadsTo = leadsToRes.rows.map(r => ({
      control_id: r.control_id,
      control_name: r.control_name,
      control_family: r.control_family,
      phase: r.phase,
      current_answer: r.answer || null,
      current_rating: r.rating || null
    }));

    // 3. "Referenced by" — controls that point TO this one
    const refByRes = await db.query(
      `SELECT c.control_id, c.control_name, c.control_family, c.phase,
              cs.answer, cs.rating
       FROM related_controls rc
       JOIN controls c ON rc.source_control_id = c.control_id
       LEFT JOIN compliance_status cs ON c.control_id = cs.control_id AND cs.user_id = $1
       WHERE rc.target_control_id = $2
       ORDER BY c.control_family, c.control_id`,
      [req.user.userId, controlId]
    );

    const referencedBy = refByRes.rows.map(r => ({
      control_id: r.control_id,
      control_name: r.control_name,
      control_family: r.control_family,
      phase: r.phase,
      current_answer: r.answer || null,
      current_rating: r.rating || null
    }));

    res.json({
      control: {
        control_id: control.control_id,
        control_name: control.control_name,
        control_family: control.control_family,
        nist_standard: control.nist_standard,
        phase: control.phase,
        current_answer: control.answer || null,
        current_rating: control.rating || null,
        evidence: control.evidence || null
      },
      leads_to: leadsTo,
      referenced_by: referencedBy
    });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
