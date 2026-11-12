#!/usr/bin/env node
// seed.js — Initializes the database for production deployments.
// Run once after creating the PostgreSQL database:
//   node src/database/seed.js
//
// This script:
//   1. Creates the schema (tables + indexes)
//   2. Inserts the default demo user
//   3. Loads all 339 NIST controls from add_all_controls.sql
//   4. Loads NIST standard descriptions from update_nist_descriptions.sql
//   5. Loads related-controls graph from add_related_controls.sql
//
// Safe to re-run: uses IF NOT EXISTS and ON CONFLICT where possible.

require('dotenv').config();
const fs = require('fs');
const path = require('path');
const { Pool } = require('pg');
const bcrypt = require('bcryptjs');

const poolConfig = process.env.DATABASE_URL
  ? { connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } }
  : {
      host: process.env.DB_HOST || 'localhost',
      port: Number(process.env.DB_PORT) || 5432,
      database: process.env.DB_NAME || 'compliance_tracker',
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD
    };

const pool = new Pool(poolConfig);

async function run() {
  const client = await pool.connect();
  try {
    console.log('Connected to database.');

    // 1. Create schema
    console.log('1/5  Creating schema...');
    await client.query(`
      CREATE TABLE IF NOT EXISTS users (
        user_id SERIAL PRIMARY KEY,
        email VARCHAR(255) UNIQUE NOT NULL,
        password VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );

      CREATE TABLE IF NOT EXISTS controls (
        control_id VARCHAR(50) PRIMARY KEY,
        control_name VARCHAR(255) NOT NULL,
        control_family VARCHAR(10) NOT NULL,
        nist_standard TEXT NOT NULL DEFAULT '',
        discussion TEXT,
        phase VARCHAR(20),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );

      CREATE TABLE IF NOT EXISTS compliance_status (
        status_id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL,
        control_id VARCHAR(50) NOT NULL,
        answer VARCHAR(50) CHECK (answer IN ('Yes', 'No', 'In-Progress', 'Not-Applicable')),
        rating INTEGER CHECK (rating >= 1 AND rating <= 5),
        evidence TEXT,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_by INTEGER,
        FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
        FOREIGN KEY (control_id) REFERENCES controls(control_id) ON DELETE CASCADE,
        FOREIGN KEY (updated_by) REFERENCES users(user_id),
        UNIQUE (user_id, control_id)
      );

      CREATE TABLE IF NOT EXISTS related_controls (
        id SERIAL PRIMARY KEY,
        source_control_id VARCHAR(50) NOT NULL,
        target_control_id VARCHAR(50) NOT NULL,
        relationship_type VARCHAR(50) DEFAULT 'related',
        FOREIGN KEY (source_control_id) REFERENCES controls(control_id) ON DELETE CASCADE,
        FOREIGN KEY (target_control_id) REFERENCES controls(control_id) ON DELETE CASCADE,
        UNIQUE (source_control_id, target_control_id)
      );

      CREATE INDEX IF NOT EXISTS idx_compliance_user ON compliance_status(user_id);
      CREATE INDEX IF NOT EXISTS idx_compliance_control ON compliance_status(control_id);
      CREATE INDEX IF NOT EXISTS idx_controls_family ON controls(control_family);
      CREATE INDEX IF NOT EXISTS idx_related_source ON related_controls(source_control_id);
      CREATE INDEX IF NOT EXISTS idx_related_target ON related_controls(target_control_id);
    `);

    // Add security columns (safe to re-run — IF NOT EXISTS equivalent via DO block)
    console.log('     Adding security columns...');
    await client.query(`
      DO $$
      BEGIN
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='users' AND column_name='failed_login_attempts') THEN
          ALTER TABLE users ADD COLUMN failed_login_attempts INTEGER DEFAULT 0;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='users' AND column_name='locked_until') THEN
          ALTER TABLE users ADD COLUMN locked_until TIMESTAMP;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='users' AND column_name='name') THEN
          ALTER TABLE users ADD COLUMN name VARCHAR(255);
        END IF;
      END
      $$;
    `);

    // 2. Insert default demo user (password: "password")
    console.log('2/5  Creating demo user...');
    const hash = await bcrypt.hash('password', 10);
    await client.query(
      `INSERT INTO users (email, password) VALUES ($1, $2)
       ON CONFLICT (email) DO NOTHING`,
      ['noble@archfordcoop.com', hash]
    );

    // 3. Load all NIST controls
    const backendRoot = path.resolve(__dirname, '..', '..');
    const controlsFile = path.join(backendRoot, 'add_all_controls.sql');
    if (fs.existsSync(controlsFile)) {
      console.log('3/5  Loading 339 NIST controls...');
      const sql = fs.readFileSync(controlsFile, 'utf8');
      await client.query(sql);
    } else {
      console.log('3/5  SKIP — add_all_controls.sql not found');
    }

    // 4. Load NIST descriptions
    const descFile = path.join(backendRoot, 'update_nist_descriptions.sql');
    if (fs.existsSync(descFile)) {
      console.log('4/5  Loading NIST standard descriptions...');
      const sql = fs.readFileSync(descFile, 'utf8');
      await client.query(sql);
    } else {
      console.log('4/5  SKIP — update_nist_descriptions.sql not found');
    }

    // 5. Load related controls
    const relatedFile = path.join(backendRoot, 'add_related_controls.sql');
    if (fs.existsSync(relatedFile)) {
      console.log('5/5  Loading related-controls graph...');
      const sql = fs.readFileSync(relatedFile, 'utf8');
      await client.query(sql);
    } else {
      console.log('5/5  SKIP — add_related_controls.sql not found');
    }

    console.log('Done! Database is ready.');
  } catch (err) {
    console.error('Seed failed:', err.message);
    process.exit(1);
  } finally {
    client.release();
    await pool.end();
  }
}

run();
