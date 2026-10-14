# Cross Team Audit Report — Compliance Tracker

> **DISCLAIMER:** This is a self-audit for personal testing and practice only. This is NOT a cross-team audit of another team's project. It was created to familiarize myself with the audit rubric and identify areas for improvement in my own code before the official cross-team audit.

**Repo:** NobleWebb/CSCI-6397-Capstone-Project-Proposal  
**Target PR:** #1 — Milestone 2: Compliance scoring service  
**Auditor:** Noble Webb (self-audit)  
**Date:** October 14, 2026

---

## 1. Supply Chain & Vulnerability Identification (35%)

### Automated Baseline Scan: `npm audit`

**Result:** 35 vulnerabilities found (5 moderate, 30 high)

| Package | Severity | Issue | Affects |
|---------|----------|-------|---------|
| `braces` (via micromatch) | HIGH | Stack-exhaustion denial of service through deeply nested patterns (GHSA-vfj7-8cjw-p6xm) | jest@29.7.0, nodemon@3.1.14 |
| `sprintf-js` (via argparse → js-yaml) | MODERATE | Denial of service through unbounded precision specifiers (GHSA-hp3w-g68c-fv3c) | babel-plugin-istanbul (test coverage tooling) |

**Analysis:** All 35 vulnerabilities are in **devDependencies** (jest and nodemon dependency trees), not in production dependencies. This means they do not affect the deployed application — only the development environment. No production dependency has a known vulnerability.

### Slopsquatting Check

All production dependencies verified against the official npm registry:

| Package | Version | Registry Status | Notes |
|---------|---------|----------------|-------|
| express | ^4.18.2 | ✅ Legitimate | Well-known web framework |
| express-validator | ^7.0.0 | ✅ Legitimate | Official validation library |
| pg | ^8.11.0 | ✅ Legitimate | Official PostgreSQL client |
| jsonwebtoken | ^9.0.0 | ✅ Legitimate | Standard JWT library |
| bcryptjs | ^2.4.3 | ✅ Legitimate | JavaScript bcrypt implementation |
| cors | ^2.8.5 | ✅ Legitimate | CORS middleware |
| helmet | ^7.1.0 | ✅ Legitimate | Security headers middleware |
| dotenv | ^16.3.1 | ✅ Legitimate | Environment variable loader |
| express-rate-limit | ^7.0.0 | ✅ Legitimate | Rate limiting middleware |

No slopsquatting or typosquatting risks detected. All packages are well-established with millions of weekly downloads.

### Manual Security Review — Code-Level Findings

**Finding 1: JWT secret uses a weak default in `.env.example` (auth.js, line 11)**
- `process.env.JWT_SECRET` is used directly with no check that it's been changed from the example value `"your_jwt_secret_here"`.
- **Risk:** If a developer forgets to change the secret, tokens are signed with a known, guessable value.
- **Recommendation:** Add a startup check in `server.js`:
  ```javascript
  if (!process.env.JWT_SECRET || process.env.JWT_SECRET === 'your_jwt_secret_here') {
    console.error('FATAL: Set a real JWT_SECRET in .env');
    process.exit(1);
  }
  ```

**Finding 2: Sample data in `schema.sql` contains a plaintext password placeholder (line 48)**
- `INSERT INTO users` uses `'hashed_password_here'` as the password value.
- **Risk:** Low in development, but if this seed runs in production, the account has a non-hashed "password" that bcrypt.compare would reject. Not exploitable, but sloppy.
- **Recommendation:** Either use a real bcrypt hash in the seed data or add a comment warning this is dev-only.

**Finding 3: Auth routes are unimplemented stubs (auth.js, lines 5–13)**
- `/api/auth/login` and `/api/auth/register` accept any input and return 200 with no actual authentication logic.
- **Risk:** Currently no access control on registration. Anyone can hit the endpoint. When implemented, password hashing, rate limiting on login attempts, and input sanitization will be needed.
- **Recommendation:** Mark these as blocked/TODO in the project plan and ensure they are never deployed as-is.

**Finding 4: No HTTPS enforcement (app.js)**
- The app has no `trust proxy` setting or redirect-to-HTTPS middleware.
- **Risk:** JWT tokens sent over HTTP can be intercepted. In production, credentials and tokens travel in plaintext.
- **Recommendation:** Add `app.set('trust proxy', 1)` and consider HSTS headers (helmet can enable this).

**Finding 5: CORS allows credentials from a single hardcoded origin (app.js, line 14)**
- `origin: process.env.FRONTEND_URL || 'http://localhost:3000'` — the fallback is HTTP localhost.
- **Risk:** Low for development, but in production the origin should be locked to the actual domain, and the HTTP fallback removed.

**Finding 6: Database password in .env (no vault/secrets manager)**
- Database credentials are stored in a plaintext `.env` file.
- **Risk:** Standard for development, but production should use a secrets manager or environment injection from the hosting platform.
- **Note:** `.env` is in `.gitignore`, so it won't be committed — this is correctly configured.

---

## 2. Test Suite & Logic Verification (25%)

### Coverage Summary
- Statements: 91.48%
- Branches: 75%
- Functions: 85.71%
- Lines: 92.48%

All four metrics exceed the 80% threshold (branches uses the relaxed 70% threshold).

### Test Quality Assessment

**Strengths:**
- **scoring.test.js** is the strongest file — it tests pure logic with meaningful assertions: empty input, Not-Applicable exclusion, rounding, invalid answer errors, per-family grouping, and unknown families. These tests would catch real regressions.
- **compliance.routes.test.js** properly mocks the database and tests happy paths, error paths, validation rejections, and edge cases (optional rating, control not found). The mock reset between tests (`db.query.mockReset()`) prevents leakage.
- **app.test.js** covers the middleware layer: health check, 404 handler, auth rejection (no token and bad token), and malformed JSON error handling.

**Weaknesses:**

- **routes.placeholder.test.js has weak assertions (lines 23, 29):** The auth route tests use `expect(res.status).toBeLessThan(500)`, which would pass even if the endpoint returned 404 or 403. These assertions don't verify the actual response. A better assertion would check for the specific status (200) and the expected response body.
  ```javascript
  // Weak (current):
  expect(res.status).toBeLessThan(500);
  
  // Stronger:
  expect(res.status).toBe(200);
  expect(res.body.message).toContain('Login endpoint');
  ```

- **No test for SQL injection resistance:** While the code uses parameterized queries (`$1`, `$2`), no test verifies that malicious input in `controlId` (e.g., `'; DROP TABLE controls; --`) is handled safely. The parameterization prevents it, but a test would prove it.

- **No test for rate limiting:** The rate limiter is disabled in test mode (`NODE_ENV !== 'test'`), so its behavior is never verified.

- **No test for expired JWT tokens:** The auth middleware is tested with no token and an invalid token, but not with an expired token (which is a different jwt.verify error path).

- **No integration tests with a real database:** All database calls are mocked. While this is acceptable for unit tests, there are no integration tests that verify the actual SQL queries work against a PostgreSQL instance. Typos in SQL or wrong column names would not be caught.

### Hallucinated/Dead Test Check
No hallucinated tests found. All tests target real endpoints that exist in the codebase. The mock patterns (`jest.mock('../src/database')`) correctly match the actual module paths.

---

## 3. Automated vs. Human Tool Analysis (20%)

### What `npm audit` Found
- 35 vulnerabilities, all in devDependency trees (jest, nodemon)
- No production dependency vulnerabilities

### What `npm audit` Missed (Human Review Found)
1. **Weak JWT secret validation** — npm audit checks for known CVEs in packages, not for insecure configuration patterns in your own code. The missing startup check for a real JWT_SECRET is a logic/configuration flaw, not a package vulnerability.
2. **Unimplemented auth endpoints accepting all input** — Automated tools don't flag stub routes that return 200 for any request. A human reviewer sees that `/api/auth/login` doesn't actually verify passwords and could be mistaken for a working endpoint.
3. **No HTTPS enforcement** — This is an architectural decision, not a package flaw. npm audit has no opinion on whether your app enforces TLS.
4. **Plaintext password placeholder in seed data** — Static analysis tools generally don't scan SQL seed files for credential hygiene.
5. **Test assertions that are too loose** — No automated tool evaluates whether `toBeLessThan(500)` is a meaningful assertion for a test. A human reviewer recognizes it would pass on 404s and 403s too.

### Why Human Context Was Necessary
The automated scan correctly identified that the dependency tree has known vulnerabilities, but all of them are in development tooling (jest/nodemon). A developer who only ran `npm audit` might panic and waste time upgrading jest when the production app is actually clean. Human review reframes the automated output: the real security risks are in the application code itself (weak secrets, stub auth endpoints), not in the packages.

---

## 4. Actionable PR Feedback & Professionalism (20%)

### PR Review Comments

**Comment 1 — auth.js (lines 5–8): Stub login returns 200 for any input**
> The login endpoint currently returns a success response regardless of input. While it's marked as TODO, this is risky if deployed accidentally. Consider returning 501 (Not Implemented) instead of 200 so clients know the feature isn't ready.
> ```suggestion
> router.post('/login', (req, res) => {
>   res.status(501).json({ message: 'Login endpoint - not yet implemented' });
> });
> ```

**Comment 2 — compliance.js (PUT handler): No evidence sanitization**
> The `evidence` field accepts any string and stores it directly. While parameterized queries prevent SQL injection, there's no length limit or content validation on evidence text. A user could submit megabytes of text.
> ```suggestion
> // Add to validators.js validateControlUpdate array:
> body('evidence').optional({ nullable: true }).isString().isLength({ max: 2000 })
> ```

**Comment 3 — app.js (line 13): JSON body limit could be more restrictive**
> `express.json({ limit: '10kb' })` is good — it prevents large payload attacks. Nice defensive coding.

**Comment 4 — scoring.js: Well-structured pure functions**
> Separating the scoring logic from the route handlers into pure functions is excellent design. It makes the code testable without mocking HTTP or database layers. The `calculateScore` and `scoreByFamily` functions are clean, well-documented, and handle edge cases (empty input, Not-Applicable exclusion).

**Comment 5 — tests/setup.js: Hardcoded test secret**
> The test setup uses `'test-secret-do-not-use-in-production'` as the JWT secret. This is fine for testing, but add a comment or assertion in the production startup to ensure this value is never used in production.

---

## Summary Scores (Self-Assessment)

| Category | Weight | Self-Score | Notes |
|----------|--------|------------|-------|
| Supply Chain & Vulnerability Identification | 35% | 85% | All packages verified, vulnerabilities found and contextualized, code-level security issues identified |
| Test Suite & Logic Verification | 25% | 80% | Coverage is strong, identified weak assertions and missing edge case tests |
| Automated vs. Human Tool Analysis | 20% | 85% | Clear comparison of what automation found vs. missed, explained why human review matters |
| Actionable PR Feedback & Professionalism | 20% | 85% | Constructive comments with code suggestions, balanced positive and critical feedback |

**Overall estimated score: ~84% (Satisfactory–Excellent range)**
