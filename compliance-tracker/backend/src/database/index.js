// database/index.js
// Single place the app talks to PostgreSQL.
//
// Routes call db.query(sql, params) and never touch the pool directly.
// That gives us two things:
//   1. Parameterised queries everywhere ($1, $2 ...) -> no SQL injection.
//   2. Tests can jest.mock('../database') and return canned rows,
//      so the suite runs without a live database.

const { Pool } = require('pg');

// Support Render's DATABASE_URL (production) or individual env vars (local dev)
const poolConfig = process.env.DATABASE_URL
  ? {
      connectionString: process.env.DATABASE_URL,
      ssl: { rejectUnauthorized: false },
      max: 10,
      idleTimeoutMillis: 30000
    }
  : {
      host: process.env.DB_HOST || 'localhost',
      port: Number(process.env.DB_PORT) || 5432,
      database: process.env.DB_NAME || 'compliance_tracker',
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      max: 10,
      idleTimeoutMillis: 30000
    };

const pool = new Pool(poolConfig);

pool.on('error', (err) => {
  console.error('Unexpected PostgreSQL pool error', err);
});

/**
 * Run a parameterised query.
 * @param {string} text  SQL with $1, $2 placeholders
 * @param {Array}  params values for the placeholders
 * @returns {Promise<import('pg').QueryResult>}
 */
const query = (text, params = []) => pool.query(text, params);

module.exports = { query, pool };
