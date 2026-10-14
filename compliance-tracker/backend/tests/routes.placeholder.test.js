// Tests for placeholder route handlers (auth, controls, dashboard).
// These routes return stub messages until they are fully implemented.
// Testing them now ensures function coverage and confirms the wiring works.
jest.mock('../src/database', () => ({ query: jest.fn() }));

const request = require('supertest');
const jwt = require('jsonwebtoken');
const app = require('../src/app');

const token = jwt.sign(
  { userId: 1, email: 'noble@archfordcoop.com' },
  process.env.JWT_SECRET,
  { expiresIn: '1h' }
);

const auth = (req) => req.set('Authorization', `Bearer ${token}`);

describe('auth routes (placeholders)', () => {
  test('POST /api/auth/register returns a placeholder response', async () => {
    const res = await request(app)
      .post('/api/auth/register')
      .send({ email: 'test@example.com', password: 'password123' });
    expect(res.status).toBeLessThan(500);
  });

  test('POST /api/auth/login returns a placeholder response', async () => {
    const res = await request(app)
      .post('/api/auth/login')
      .send({ email: 'test@example.com', password: 'password123' });
    expect(res.status).toBeLessThan(500);
  });
});

describe('controls routes (placeholders)', () => {
  test('GET /api/controls returns a placeholder response', async () => {
    const res = await request(app).get('/api/controls');
    expect(res.status).toBe(200);
    expect(res.body.message).toContain('Get all controls');
  });

  test('GET /api/controls/:id returns a placeholder response', async () => {
    const res = await request(app).get('/api/controls/AC-1');
    expect(res.status).toBe(200);
    expect(res.body.message).toContain('Get control by ID');
  });

  test('PUT /api/controls/:id returns a placeholder response', async () => {
    const res = await auth(
      request(app).put('/api/controls/AC-1').send({ name: 'Updated' })
    );
    expect(res.status).toBe(200);
    expect(res.body.message).toContain('Update control');
  });
});

describe('dashboard routes (placeholders)', () => {
  test('GET /api/dashboard/summary returns a placeholder response', async () => {
    const res = await auth(request(app).get('/api/dashboard/summary'));
    expect(res.status).toBe(200);
    expect(res.body.message).toContain('Dashboard summary');
  });

  test('GET /api/dashboard/family-stats returns a placeholder response', async () => {
    const res = await auth(request(app).get('/api/dashboard/family-stats'));
    expect(res.status).toBe(200);
    expect(res.body.message).toContain('Family statistics');
  });
});
