-- Compliance Tracker Database Schema
-- PostgreSQL SQL

-- Table 1: USERS (for authentication)
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table 2: CONTROLS (NIST controls from Arkansas Cybersecurity Rubric)
CREATE TABLE controls (
  control_id VARCHAR(50) PRIMARY KEY,
  control_name VARCHAR(255) NOT NULL,
  control_family VARCHAR(10) NOT NULL,
  nist_standard TEXT NOT NULL,
  discussion TEXT,
  phase VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table 3: COMPLIANCE_STATUS (tracks compliance for each control per user)
CREATE TABLE compliance_status (
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
  -- One record per user per control. Lets the API "upsert" with ON CONFLICT.
  UNIQUE (user_id, control_id)
);

-- Create indexes for faster queries
CREATE INDEX idx_compliance_user ON compliance_status(user_id);
CREATE INDEX idx_compliance_control ON compliance_status(control_id);
CREATE INDEX idx_controls_family ON controls(control_family);

-- Sample data to test
INSERT INTO users (email, password) VALUES
('noble@archfordcoop.com', 'hashed_password_here');

INSERT INTO controls (control_id, control_name, control_family, nist_standard, phase) VALUES
('AC-1', 'Policy & Procedures', 'AC', 'Develop, document, and disseminate access control policy...', 'Phase 1'),
('AC-2', 'Account Management', 'AC', 'Define and document the types of accounts allowed...', 'Phase 1'),
('AT-1', 'Security Awareness & Training', 'AT', 'Provide security awareness and training to all users...', 'Phase 1'),
('CP-1', 'Contingency Planning', 'CP', 'Develop and maintain contingency plans...', 'Phase 2');

INSERT INTO compliance_status (user_id, control_id, answer, rating, evidence) VALUES
(1, 'AC-1', 'Yes', 4, 'Access control policy document in shared drive'),
(1, 'AC-2', 'In-Progress', 2, 'Initial implementation started'),
(1, 'AT-1', 'Yes', 3, 'Annual training completed'),
(1, 'CP-1', 'No', 1, 'Not yet implemented');
