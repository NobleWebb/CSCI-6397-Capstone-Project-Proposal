// Smoke tests for the Express app wiring.
// The database module is mocked so these run with no PostgreSQL present.
jest.mock('../src/database', () => ({ query: jest.fn() }));

const request = require('supertest');
const app = require('../src/app');

describe('app', () => {
  test('GET /health returns OK', async () => {
    const res = await request(app).get('/health');
    expect(res.status).toBe(200);
    expect(res.body.status).toBe('OK');
    expect(typeof res.body.timestamp).toBe('string');
  });

  test('unknown routes return 404 JSON', async () => {
    const res = await request(app).get('/does-not-exist');
    expect(res.status).toBe(404);
    expect(res.body).toEqual({ error: 'Not found' });
  });

  test('protected routes reject requests with no token', async () => {
    const res = await request(app).get('/api/compliance');
    expect(res.status).toBe(401);
    expect(res.body.error).toBe('No token provided');
  });

  test('protected routes reject a bad token', async () => {
    const res = await request(app)
      .get('/api/compliance')
      .set('Authorization', 'Bearer not-a-real-token');
    expect(res.status).toBe(401);
    expect(res.body.error).toBe('Invalid token');
  });

  test('malformed JSON body is handled by the error handler', async () => {
    const res = await request(app)
      .put('/api/compliance/AC-1')
      .set('Content-Type', 'application/json')
      .send('{ not json');
    expect(res.status).toBe(400);
    expect(res.body.error).toBeDefined();
  });
});
