# Compliance Tracker & Audit Management System

CSCI 6397 Capstone Project - Noble Webb

## Project Overview

A secure web-based application for tracking compliance against NIST 800-53B standards using the Arkansas Cybersecurity Rubric.

## Security First

This project prioritizes security from the ground up:
- Environment variables for all sensitive configuration
- JWT-based authentication
- PostgreSQL with prepared statements (SQL injection prevention)
- HTTPS/TLS enforcement in production
- Input validation and sanitization
- CORS properly configured
- Rate limiting on API endpoints
- Password hashing with bcrypt
- No secrets committed to repository

## Project Structure

```
compliance-tracker/
├── backend/          # Node.js/Express API
├── frontend/         # React application
├── docs/            # Documentation
└── .gitignore       # Security: prevents secrets from being committed
```

## Getting Started

See `backend/README.md` and `frontend/README.md` for setup instructions.

## Security Guidelines

- **NEVER** commit .env files
- **NEVER** hardcode API keys, passwords, or database credentials
- Use `.env.example` as a template
- All environment variables must be set at deployment time
- Review `SECURITY.md` for full security practices

## Development

See individual README files in `backend/` and `frontend/` directories.
