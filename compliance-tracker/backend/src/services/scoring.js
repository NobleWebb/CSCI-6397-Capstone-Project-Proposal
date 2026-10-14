// services/scoring.js
// Pure compliance-scoring logic. No database, no HTTP - just math on arrays.
//
// Scoring rules (agreed for the Arkansas Cybersecurity Rubric):
//   compliancePercent = Yes answers / applicable controls * 100
//     - "applicable" means every control except those marked Not-Applicable
//     - In-Progress and No both count as NOT compliant
//   averageMaturity   = mean of `rating` (1-5) across applicable controls
//                       that have a rating
//
// A "status record" looks like a row from compliance_status joined to controls:
//   { control_id, control_family, answer, rating }

const ANSWERS = ['Yes', 'No', 'In-Progress', 'Not-Applicable'];

/** Round to one decimal place (e.g. 66.666 -> 66.7). */
const round1 = (n) => Math.round(n * 10) / 10;

/**
 * Compute the overall compliance summary for a set of status records.
 *
 * @param {Array<{answer:string, rating?:number}>} records
 * @returns {{
 *   total:number, applicable:number, notApplicable:number,
 *   yes:number, no:number, inProgress:number,
 *   compliancePercent:number, averageMaturity:number|null
 * }}
 */
function calculateScore(records = []) {
  const counts = { yes: 0, no: 0, inProgress: 0, notApplicable: 0 };
  let ratingSum = 0;
  let ratingCount = 0;

  for (const r of records) {
    switch (r.answer) {
      case 'Yes': counts.yes += 1; break;
      case 'No': counts.no += 1; break;
      case 'In-Progress': counts.inProgress += 1; break;
      case 'Not-Applicable': counts.notApplicable += 1; break;
      default:
        throw new Error(`Invalid answer "${r.answer}". Expected one of: ${ANSWERS.join(', ')}`);
    }

    // Maturity only counts for applicable controls with a numeric rating
    if (r.answer !== 'Not-Applicable' && Number.isInteger(r.rating)) {
      ratingSum += r.rating;
      ratingCount += 1;
    }
  }

  const total = records.length;
  const applicable = total - counts.notApplicable;

  return {
    total,
    applicable,
    notApplicable: counts.notApplicable,
    yes: counts.yes,
    no: counts.no,
    inProgress: counts.inProgress,
    compliancePercent: applicable === 0 ? 0 : round1((counts.yes / applicable) * 100),
    averageMaturity: ratingCount === 0 ? null : round1(ratingSum / ratingCount)
  };
}

/**
 * Break the score down by control family (AC, AT, CP, ...).
 * Returns an object keyed by family, each value shaped like calculateScore().
 *
 * @param {Array<{control_family:string, answer:string, rating?:number}>} records
 */
function scoreByFamily(records = []) {
  const grouped = {};
  for (const r of records) {
    const fam = r.control_family || 'UNKNOWN';
    if (!grouped[fam]) grouped[fam] = [];
    grouped[fam].push(r);
  }

  const result = {};
  for (const fam of Object.keys(grouped).sort()) {
    result[fam] = calculateScore(grouped[fam]);
  }
  return result;
}

module.exports = { calculateScore, scoreByFamily, ANSWERS };
