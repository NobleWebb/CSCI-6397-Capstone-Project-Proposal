# Backend - Compliance Tracker API

Node.js + Express REST API

## Setup

1. Install dependencies:
```bash
npm install
```

2. Create .env file from template:
```bash
cp .env.example .env
```

3. Update .env with your PostgreSQL credentials

4. Run migrations:
```bash
npm run migrate
```

5. Start development server:
```bash
npm run dev
```

API runs on http://localhost:3001

## API Endpoints

### Authentication
- POST /api/auth/register - Register user
- POST /api/auth/login - Login user
- POST /api/auth/refresh - Refresh JWT token

### Controls
- GET /api/controls - List all controls
- GET /api/controls/:id - Get control details
- PUT /api/controls/:id - Update control status
- GET /api/controls/family/:family - Get controls by family

### Dashboard
- GET /api/dashboard/summary - Compliance summary
- GET /api/dashboard/family-stats - Stats by control family

### Reports
- GET /api/reports/compliance - Generate compliance report
- GET /api/reports/audit - Generate audit report

## Security Features

- JWT authentication on all endpoints
- Input validation using express-validator
- Helmet.js for HTTP security headers
- Rate limiting to prevent brute force
- Prepared statements to prevent SQL injection
- CORS configured for frontend origin
- Bcrypt password hashing
