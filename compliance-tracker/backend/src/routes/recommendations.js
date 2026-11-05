// routes/recommendations.js
// Recommends related controls based on completed compliance assessments.

const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/auth');
const db = require('../database');

// GET /api/recommendations -> related controls the user should work on next
router.get('/', authMiddleware, async (req, res, next) => {
  try {
    // 1. Get all controls the user has marked as "Yes" (compliant)
    const completedRes = await db.query(
      `SELECT cs.control_id, c.control_name, c.control_family, c.related_controls
       FROM compliance_status cs
       JOIN controls c ON cs.control_id = c.control_id
       WHERE cs.user_id = $1 AND cs.answer = 'Yes'`,
      [req.user.userId]
    );

    const completedControls = completedRes.rows;
    const completedIds = new Set(completedControls.map(r => r.control_id));

    // 2. Collect all related control IDs from completed controls
    const relatedIdSet = new Set();
    const sourceMap = {}; // Maps recommended control_id -> which completed controls link to it

    completedControls.forEach(row => {
      if (!row.related_controls) return;
      // Parse comma-separated list like "AC-3, AC-5, AC-6"
      const ids = row.related_controls.split(',').map(s => s.trim()).filter(Boolean);
      ids.forEach(relId => {
        relatedIdSet.add(relId);
        if (!sourceMap[relId]) sourceMap[relId] = [];
        sourceMap[relId].push(row.control_id);
      });
    });

    // 3. Filter out controls the user has already completed
    const candidateIds = [...relatedIdSet].filter(id => !completedIds.has(id));

    if (candidateIds.length === 0) {
      return res.json({ recommendations: [], completedCount: completedIds.size });
    }

    // 4. Fetch details for recommended controls, including the user's current status
    const placeholders = candidateIds.map((_, i) => '$' + (i + 2)).join(',');
    const recRes = await db.query(
      `SELECT c.control_id, c.control_name, c.control_family, c.nist_standard, c.phase,
              cs.answer, cs.rating
       FROM controls c
       LEFT JOIN compliance_status cs ON c.control_id = cs.control_id AND cs.user_id = $1
       WHERE c.control_id IN (${placeholders})
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
              c.phase, c.related_controls,
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

    // 2. "Leads to" — parse this control's related_controls and fetch their details
    let leadsTo = [];
    if (control.related_controls) {
      const relIds = control.related_controls.split(',').map(s => s.trim()).filter(Boolean);
      if (relIds.length > 0) {
        const ph = relIds.map((_, i) => '$' + (i + 2)).join(',');
        const ltRes = await db.query(
          `SELECT c.control_id, c.control_name, c.control_family, c.phase,
                  cs.answer, cs.rating
           FROM controls c
           LEFT JOIN compliance_status cs ON c.control_id = cs.control_id AND cs.user_id = $1
           WHERE c.control_id IN (${ph})
           ORDER BY c.control_family, c.control_id`,
          [req.user.userId, ...relIds]
        );
        leadsTo = ltRes.rows.map(r => ({
          control_id: r.control_id,
          control_name: r.control_name,
          control_family: r.control_family,
          phase: r.phase,
          current_answer: r.answer || null,
          current_rating: r.rating || null
        }));
      }
    }

    // 3. "Referenced by" — find controls whose related_controls mention this one
    const refRes = await db.query(
      `SELECT c.control_id, c.control_name, c.control_family, c.phase,
              cs.answer, cs.rating
       FROM controls c
       LEFT JOIN compliance_status cs ON c.control_id = cs.control_id AND cs.user_id = $1
       WHERE c.related_controls LIKE '%' || $2 || '%'
       ORDER BY c.control_family, c.control_id`,
      [req.user.userId, controlId]
    );

    // Filter to exact matches (avoid AC-1 matching AC-10, AC-12, etc.)
    const referencedBy = refRes.rows.filter(r => {
      // Re-check: does this control's related_controls actually list our controlId?
      // We need to get related_controls for this — query already joined controls
      return true; // the LIKE is approximate; we do exact check below
    });

    // Actually re-query with related_controls so we can do exact matching
    const refExactRes = await db.query(
      `SELECT c.control_id, c.control_name, c.control_family, c.phase,
              c.related_controls, cs.answer, cs.rating
       FROM controls c
       LEFT JOIN compliance_status cs ON c.control_id = cs.control_id AND cs.user_id = $1
       WHERE c.related_controls IS NOT NULL`,
      [req.user.userId]
    );

    const exactReferencedBy = refExactRes.rows.filter(r => {
      const ids = r.related_controls.split(',').map(s => s.trim());
      return ids.includes(controlId);
    }).map(r => ({
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
      referenced_by: exactReferencedBy
    });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
