// Runs before every test file. Sets a predictable environment so tests never
// depend on the developer's real .env values.
process.env.NODE_ENV = 'test';
process.env.JWT_SECRET = 'test-secret-do-not-use-in-production';
process.env.JWT_EXPIRE = '1h';
