// Tests for the compliance route handlers.
// The database module is mocked so these run with no PostgreSQL present.
jest.mock('../src/database', () => ({ query: jest.fn() }));

const request = require('supertest');
const jwt = require('jsonwebtoken');
const app = require('../src/app');
const db = require('../src/database');

// Create a valid token for our test user
const testUser = { userId: 1, email: 'noble@archfordcoop.com' };
const token = jwt.sign(testUser, process.env.JWT_SECRET, { expiresIn: '1h' });

// Helper: set auth header on a supertest request
const auth = (req) => req.set('Authorization', `Bearer ${token}`);

// Reset mocks before each test so they don't leak between tests
beforeEach(() => {
  db.query.mockReset();
});

// ---------------------------------------------------------------------------
// GET /api/compliance — list all compliance records for the user
// ---------------------------------------------------------------------------
describe('GET /api/compliance', () => {
  const sampleRows = [
    {
      status_id: 1, control_id: 'AC-1', control_name: 'Policy & Procedures',
      control_family: 'AC', nist_standard: 'Develop access control policy...',
      answer: 'Yes', rating: 4, evidence: 'Policy doc in shared drive',
      updated_at: '2026-09-30T00:00:00.000Z'
    },
    {
      status_id: 2, control_id: 'AC-2', control_name: 'Account Management',
      control_family: 'AC', nist_standard: 'Define account types...',
      answer: 'In-Progress', rating: 2, evidence: 'Initial implementation',
      updated_at: '2026-09-30T00:00:00.000Z'
    }
  ];

  test('returns all compliance records for the authenticated user', async () => {
    db.query.mockResolvedValue({ rows: sampleRows });

    const res = await auth(request(app).get('/api/compliance'));

    expect(res.status).toBe(200);
    expect(res.body).toHaveLength(2);
    expect(res.body[0].control_id).toBe('AC-1');
    expect(res.body[1].control_id).toBe('AC-2');
    // Verify the query used the authenticated user's ID
    expect(db.query).toHaveBeenCalledWith(
      expect.stringContaining('WHERE cs.user_id = $1'),
      [testUser.userId]
    );
  });

  test('returns an empty array when the user has no records', async () => {
    db.query.mockResolvedValue({ rows: [] });

    const res = await auth(request(app).get('/api/compliance'));

    expect(res.status).toBe(200);
    expect(res.body).toEqual([]);
  });

  test('returns 500 when the database throws', async () => {
    db.query.mockRejectedValue(new Error('connection failed'));

    const res = await auth(request(app).get('/api/compliance'));

    expect(res.status).toBe(500);
    expect(res.body.error).toBeDefined();
  });
});

// ---------------------------------------------------------------------------
// GET /api/compliance/score — compliance percentage and maturity
// ---------------------------------------------------------------------------
describe('GET /api/compliance/score', () => {
  test('returns the overall score and per-family breakdown', async () => {
    db.query.mockResolvedValue({
      rows: [
        { control_id: 'AC-1', answer: 'Yes', rating: 4, control_family: 'AC' },
        { control_id: 'AC-2', answer: 'No', rating: 2, control_family: 'AC' },
        { control_id: 'AT-1', answer: 'Yes', rating: 3, control_family: 'AT' }
      ]
    });

    const res = await auth(request(app).get('/api/compliance/score'));

    expect(res.status).toBe(200);
    // 2 out of 3 Yes = 66.7%
    expect(res.body.overall.compliancePercent).toBe(66.7);
    expect(res.body.overall.yes).toBe(2);
    expect(res.body.overall.total).toBe(3);
    expect(res.body.overall.averageMaturity).toBe(3);
    // Per-family breakdown
    expect(res.body.byFamily.AC.compliancePercent).toBe(50);
    expect(res.body.byFamily.AT.compliancePercent).toBe(100);
  });

  test('returns zeros when user has no compliance records', async () => {
    db.query.mockResolvedValue({ rows: [] });

    const res = await auth(request(app).get('/api/compliance/score'));

    expect(res.status).toBe(200);
    expect(res.body.overall.compliancePercent).toBe(0);
    expect(res.body.overall.total).toBe(0);
    expect(res.body.byFamily).toEqual({});
  });

  test('handles Not-Applicable controls correctly in the score', async () => {
    db.query.mockResolvedValue({
      rows: [
        { control_id: 'AC-1', answer: 'Yes', rating: 5, control_family: 'AC' },
        { control_id: 'CP-1', answer: 'Not-Applicable', rating: null, control_family: 'CP' }
      ]
    });

    const res = await auth(request(app).get('/api/compliance/score'));

    expect(res.status).toBe(200);
    // 1 Yes out of 1 applicable = 100%, not 50%
    expect(res.body.overall.compliancePercent).toBe(100);
    expect(res.body.overall.applicable).toBe(1);
    expect(res.body.overall.notApplicable).toBe(1);
  });

  test('returns 500 when the database throws', async () => {
    db.query.mockRejectedValue(new Error('connection failed'));

    const res = await auth(request(app).get('/api/compliance/score'));

    expect(res.status).toBe(500);
  });
});

// ---------------------------------------------------------------------------
// PUT /api/compliance/:controlId — update a single control's status
// ---------------------------------------------------------------------------
describe('PUT /api/compliance/:controlId', () => {
  test('upserts a compliance record and returns it', async () => {
    const upsertedRow = {
      status_id: 1, user_id: 1, control_id: 'AC-1',
      answer: 'Yes', rating: 4, evidence: 'Policy documented'
    };
    // First call: control exists check; second call: upsert
    db.query
      .mockResolvedValueOnce({ rows: [{ control_id: 'AC-1' }] })
      .mockResolvedValueOnce({ rows: [upsertedRow] });

    const res = await auth(
      request(app)
        .put('/api/compliance/AC-1')
        .send({ answer: 'Yes', rating: 4, evidence: 'Policy documented' })
    );

    expect(res.status).toBe(200);
    expect(res.body.control_id).toBe('AC-1');
    expect(res.body.answer).toBe('Yes');
    expect(res.body.rating).toBe(4);
  });

  test('returns 404 when the control does not exist', async () => {
    db.query.mockResolvedValue({ rows: [] });

    const res = await auth(
      request(app)
        .put('/api/compliance/FAKE-99')
        .send({ answer: 'Yes', rating: 3 })
    );

    expect(res.status).toBe(404);
    expect(res.body.error).toBe('Control not found');
  });

  test('returns 400 when answer is invalid', async () => {
    const res = await auth(
      request(app)
        .put('/api/compliance/AC-1')
        .send({ answer: 'Maybe', rating: 3 })
    );

    expect(res.status).toBe(400);
    expect(res.body.errors).toBeDefined();
  });

  test('returns 400 when rating is out of range', async () => {
    const res = await auth(
      request(app)
        .put('/api/compliance/AC-1')
        .send({ answer: 'Yes', rating: 10 })
    );

    expect(res.status).toBe(400);
    expect(res.body.errors).toBeDefined();
  });

  test('accepts a request without a rating (rating is optional)', async () => {
    db.query
      .mockResolvedValueOnce({ rows: [{ control_id: 'AC-1' }] })
      .mockResolvedValueOnce({ rows: [{ status_id: 1, control_id: 'AC-1', answer: 'Not-Applicable', rating: null }] });

    const res = await auth(
      request(app)
        .put('/api/compliance/AC-1')
        .send({ answer: 'Not-Applicable' })
    );

    expect(res.status).toBe(200);
    expect(res.body.answer).toBe('Not-Applicable');
  });

  test('returns 500 when the database throws on upsert', async () => {
    db.query
      .mockResolvedValueOnce({ rows: [{ control_id: 'AC-1' }] })
      .mockRejectedValueOnce(new Error('write failed'));

    const res = await auth(
      request(app)
        .put('/api/compliance/AC-1')
        .send({ answer: 'Yes', rating: 3 })
    );

    expect(res.status).toBe(500);
  });
});
