// routes/import.js
// Handles Excel file upload and imports compliance data from
// the Arkansas Cybersecurity Rubric spreadsheet format.

const express = require('express');
const router = express.Router();
const multer = require('multer');
const XLSX = require('xlsx');
const authMiddleware = require('../middleware/auth');
const db = require('../database');

// Configure multer for in-memory file handling (no disk writes)
const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 10 * 1024 * 1024 }, // 10 MB max
  fileFilter: (req, file, cb) => {
    const allowed = [
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'application/vnd.ms-excel'
    ];
    if (allowed.includes(file.mimetype) ||
        file.originalname.match(/\.(xlsx|xls)$/i)) {
      cb(null, true);
    } else {
      cb(new Error('Only Excel files (.xlsx, .xls) are accepted'));
    }
  }
});

// The 20 control-family sheet names used in the rubric
const FAMILY_SHEETS = [
  'AC', 'AT', 'CP', 'IA', 'IR', 'SI',
  'AU', 'CM', 'PL', 'PT', 'SA', 'SC',
  'CA', 'MA', 'MP', 'PE', 'PM', 'PS', 'RA', 'SR'
];

// Valid answer values the app accepts
const VALID_ANSWERS = ['Yes', 'No', 'In-Progress', 'Not-Applicable'];

// Normalize answer text from the spreadsheet to match app values
function normalizeAnswer(raw) {
  if (!raw) return null;
  var s = String(raw).trim();
  // Exact match first
  if (VALID_ANSWERS.includes(s)) return s;
  // Case-insensitive matching
  var lower = s.toLowerCase();
  if (lower === 'yes') return 'Yes';
  if (lower === 'no') return 'No';
  if (lower === 'in-progress' || lower === 'in progress') return 'In-Progress';
  if (lower === 'not-applicable' || lower === 'not applicable' || lower === 'n/a') return 'Not-Applicable';
  return null; // skip unrecognized answers
}

// Normalize rating to integer 1-5
function normalizeRating(raw) {
  if (raw === null || raw === undefined || raw === '') return null;
  var n = Number(raw);
  if (isNaN(n) || n < 1 || n > 5) return null;
  return Math.round(n);
}

// POST /api/import -> upload and process the rubric Excel file
router.post('/', authMiddleware, upload.single('file'), async (req, res, next) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'No file uploaded' });
    }

    // Parse the Excel workbook from the uploaded buffer
    var workbook;
    try {
      workbook = XLSX.read(req.file.buffer, { type: 'buffer' });
    } catch (parseErr) {
      return res.status(400).json({ error: 'Could not parse the Excel file. Make sure it is a valid .xlsx or .xls file.' });
    }

    var imported = 0;
    var skipped = 0;
    var errors = [];
    var details = []; // per-family breakdown

    // Get all valid control IDs from the database
    var controlsRes = await db.query('SELECT control_id FROM controls');
    var validControlIds = new Set(controlsRes.rows.map(function(r) { return r.control_id; }));

    // Process each family sheet
    for (var i = 0; i < FAMILY_SHEETS.length; i++) {
      var sheetName = FAMILY_SHEETS[i];
      var sheet = workbook.Sheets[sheetName];
      var familyImported = 0;
      var familySkipped = 0;

      if (!sheet) {
        details.push({ family: sheetName, imported: 0, skipped: 0, note: 'Sheet not found' });
        continue;
      }

      // Convert sheet to array of arrays
      var rows = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: null });

      // Find the header row (look for "Control ID" in column A)
      var headerIdx = -1;
      for (var r = 0; r < Math.min(rows.length, 15); r++) {
        if (rows[r] && rows[r][0] &&
            String(rows[r][0]).trim().toLowerCase() === 'control id') {
          headerIdx = r;
          break;
        }
      }

      if (headerIdx === -1) {
        details.push({ family: sheetName, imported: 0, skipped: 0, note: 'No header row found' });
        continue;
      }

      // Process data rows (starting after the header)
      for (var r = headerIdx + 1; r < rows.length; r++) {
        var row = rows[r];
        if (!row || !row[0]) continue; // skip empty rows

        var controlId = String(row[0]).trim();
        if (!controlId || controlId.toLowerCase() === 'control id') continue;

        // Column mapping from the rubric:
        // A=Control ID, B=Controls(name), C=Standard, D=Discussion,
        // E=Answers, F=Rating, G=Status, H=Resources, I=Evidence
        var rawAnswer = row[4]; // column E
        var rawRating = row[5]; // column F
        var rawEvidence = row[8]; // column I

        var answer = normalizeAnswer(rawAnswer);
        var rating = normalizeRating(rawRating);
        var evidence = rawEvidence ? String(rawEvidence).trim() : null;

        // Skip rows with no useful data
        if (!answer && !rating && !evidence) {
          familySkipped++;
          continue;
        }

        // Skip if control ID doesn't exist in our database
        if (!validControlIds.has(controlId)) {
          familySkipped++;
          errors.push(controlId + ': not found in database');
          continue;
        }

        // Skip if no valid answer
        if (!answer) {
          familySkipped++;
          continue;
        }

        // Upsert into compliance_status
        try {
          await db.query(
            `INSERT INTO compliance_status (user_id, control_id, answer, rating, evidence, updated_at, updated_by)
             VALUES ($1, $2, $3, $4, $5, NOW(), $1)
             ON CONFLICT (user_id, control_id)
             DO UPDATE SET answer = $3, rating = $4, evidence = $5, updated_at = NOW(), updated_by = $1`,
            [req.user.userId, controlId, answer, rating, evidence]
          );
          familyImported++;
        } catch (dbErr) {
          familySkipped++;
          errors.push(controlId + ': database error');
        }
      }

      imported += familyImported;
      skipped += familySkipped;
      details.push({ family: sheetName, imported: familyImported, skipped: familySkipped });
    }

    res.json({
      success: true,
      imported: imported,
      skipped: skipped,
      total: imported + skipped,
      details: details,
      errors: errors.length > 0 ? errors.slice(0, 20) : undefined // cap error list
    });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
