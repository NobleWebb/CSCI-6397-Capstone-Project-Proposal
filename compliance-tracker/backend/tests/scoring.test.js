const { calculateScore, scoreByFamily, ANSWERS } = require('../src/services/scoring');

// Small helper so test cases read like the rubric
const rec = (answer, rating, control_family = 'AC') => ({ answer, rating, control_family });

describe('calculateScore', () => {
  test('returns zeros for an empty list', () => {
    expect(calculateScore([])).toEqual({
      total: 0, applicable: 0, notApplicable: 0,
      yes: 0, no: 0, inProgress: 0,
      compliancePercent: 0, averageMaturity: null
    });
  });

  test('defaults to an empty list when called with no argument', () => {
    expect(calculateScore().total).toBe(0);
  });

  test('all Yes answers = 100%', () => {
    const result = calculateScore([rec('Yes', 5), rec('Yes', 4)]);
    expect(result.compliancePercent).toBe(100);
    expect(result.yes).toBe(2);
    expect(result.applicable).toBe(2);
  });

  test('all No answers = 0%', () => {
    const result = calculateScore([rec('No', 1), rec('No', 2)]);
    expect(result.compliancePercent).toBe(0);
    expect(result.no).toBe(2);
  });

  test('In-Progress counts as not compliant', () => {
    // 1 Yes out of 2 applicable = 50%
    const result = calculateScore([rec('Yes', 4), rec('In-Progress', 2)]);
    expect(result.compliancePercent).toBe(50);
    expect(result.inProgress).toBe(1);
  });

  test('Not-Applicable controls are excluded from the denominator', () => {
    // 1 Yes, 1 No, 2 N/A -> 1 of 2 applicable = 50%, not 25%
    const result = calculateScore([
      rec('Yes', 5), rec('No', 1), rec('Not-Applicable'), rec('Not-Applicable')
    ]);
    expect(result.total).toBe(4);
    expect(result.applicable).toBe(2);
    expect(result.notApplicable).toBe(2);
    expect(result.compliancePercent).toBe(50);
  });

  test('all Not-Applicable gives 0% rather than dividing by zero', () => {
    const result = calculateScore([rec('Not-Applicable'), rec('Not-Applicable')]);
    expect(result.applicable).toBe(0);
    expect(result.compliancePercent).toBe(0);
    expect(result.averageMaturity).toBeNull();
  });

  test('rounds compliance percent to one decimal place', () => {
    // 2 of 3 = 66.666...
    const result = calculateScore([rec('Yes', 3), rec('Yes', 3), rec('No', 3)]);
    expect(result.compliancePercent).toBe(66.7);
  });

  test('average maturity uses applicable controls with a rating', () => {
    const result = calculateScore([
      rec('Yes', 5), rec('No', 1), rec('In-Progress', 3),
      rec('Not-Applicable', 5) // ignored even though it has a rating
    ]);
    expect(result.averageMaturity).toBe(3); // (5 + 1 + 3) / 3
  });

  test('records without a rating do not affect average maturity', () => {
    const result = calculateScore([rec('Yes', 4), rec('Yes', undefined), rec('No', null)]);
    expect(result.averageMaturity).toBe(4);
    expect(result.compliancePercent).toBe(66.7);
  });

  test('rounds average maturity to one decimal place', () => {
    const result = calculateScore([rec('Yes', 5), rec('Yes', 4), rec('Yes', 4)]);
    expect(result.averageMaturity).toBe(4.3); // 13 / 3 = 4.333
  });

  test('throws a helpful error on an invalid answer', () => {
    expect(() => calculateScore([rec('Maybe', 3)])).toThrow(/Invalid answer "Maybe"/);
  });

  test('exports the list of valid answers', () => {
    expect(ANSWERS).toEqual(['Yes', 'No', 'In-Progress', 'Not-Applicable']);
  });
});

describe('scoreByFamily', () => {
  test('returns an empty object for no records', () => {
    expect(scoreByFamily([])).toEqual({});
    expect(scoreByFamily()).toEqual({});
  });

  test('groups records by control_family and scores each group', () => {
    const result = scoreByFamily([
      rec('Yes', 5, 'AC'), rec('No', 2, 'AC'),
      rec('Yes', 4, 'AT'),
      rec('Not-Applicable', undefined, 'CP'), rec('In-Progress', 2, 'CP')
    ]);

    expect(Object.keys(result)).toEqual(['AC', 'AT', 'CP']); // sorted
    expect(result.AC.compliancePercent).toBe(50);
    expect(result.AT.compliancePercent).toBe(100);
    expect(result.CP.compliancePercent).toBe(0);
    expect(result.CP.applicable).toBe(1);
  });

  test('puts records with no family under UNKNOWN', () => {
    const result = scoreByFamily([{ answer: 'Yes', rating: 3 }]);
    expect(result.UNKNOWN.compliancePercent).toBe(100);
  });
});
