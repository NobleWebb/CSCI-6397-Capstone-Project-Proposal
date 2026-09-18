# Frontend - Compliance Tracker UI

React + TypeScript application

## Setup

1. Install dependencies:
```bash
npm install
```

2. Create .env file:
```bash
cp .env.example .env
```

3. Start development server:
```bash
npm start
```

App runs on http://localhost:3000

## Features

- Dashboard with compliance status
- Control browser and search
- Control detail pages with edit capability
- Maturity rating tracker
- Compliance reports
- User authentication

## Security Features

- Secure token storage (HTTP-only cookies via backend)
- XSS protection via React's built-in escaping
- CSRF token handling for state changes
- Secure HTTPS in production
- No sensitive data in localStorage
