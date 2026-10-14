// database/index.js
// Single place the app talks to PostgreSQL.
//
// Routes call db.query(sql, params) and never touch the pool directly.
// That gives us two things:
//   1. Parameterised queries everywhere ($1, $2 ...) -> no SQL injection.
//   2. Tests can jest.mock('../database') and return canned rows,
//      so the suite runs without a live database.

const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: Number(process.env.DB_PORT) || 5432,
  database: process.env.DB_NAME || 'compliance_tracker',
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  max: 10,                    // connections kept open
  idleTimeoutMillis: 30000
});

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
