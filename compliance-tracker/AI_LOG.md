# AI Usage Log — Compliance Tracker

Running record of how AI tools were used on this project, what they got right,
what they got wrong, and what I changed. Feeds both the **AI Friction Log**
(due Oct 18 with the MVP demo) and the **AI Audit Log** (final submission).

Tool used: Claude (Anthropic) via the Claude desktop app.

Format for each entry:
- **What I asked for**
- **What the AI produced**
- **What I changed or rejected, and why**
- **Friction** (anything slow, wrong, or confusing)

---

## 2026-09-11 — Project proposal
- Asked Claude to help interpret the capstone assignment and brainstorm project ideas useful for my job at ArchFord Coop.
- Compared two candidate ideas; chose the compliance tracker because I already maintain the Arkansas Cybersecurity Rubric checklist at work.
- Claude drafted the proposal document; I edited the scope and AI-tools sections to simplify them.
- Friction: initial drafts were wordier than the instructor wanted; had to ask twice to simplify.

## 2026-09-18 — Repo setup and skeleton
- Asked how to get a project into GitHub with no prior git experience.
- Claude offered command-line and web-upload paths; I used the web upload.
- Friction: the generated skeleton was not downloadable at first; Claude had to zip it before I could get it.

## 2026-09-29 — Database design
- Asked what the database was for and whether it was required; Claude explained with a concrete example (storing controls and each answer so a percentage can be calculated).
- Claude produced a three-table PostgreSQL schema (users, controls, compliance_status) and an ER diagram.
- I chose the layout after reviewing options.

## 2026-09-30 — Milestone 2 planning and Day 1 build
- Shared the full deadline list. Claude flagged that Milestone 2 (Oct 4) is the immediate priority and that the Final Submission date (Nov 8) appears before Milestone 3 (Nov 15) — need to confirm with instructor.
- Chose the core feature: compliance status + score endpoint.
- Chose the scoring formula: compliance % = Yes ÷ (controls − Not-Applicable); maturity reported as an average rating.
- Claude split `server.js` into `app.js` + `server.js` so supertest can import the app, added `src/database/index.js`, added a `UNIQUE (user_id, control_id)` constraint the original schema was missing, wrote `src/services/scoring.js` and its tests.
- Friction: Claude's cloud workspace could not reach the npm registry, so it could not run Jest itself. It verified the scoring logic with plain Node assertions instead; the Jest suite and coverage number still need to be confirmed on my machine.
- Friction: I don't have PostgreSQL installed yet; that's scheduled for Friday.

<!-- Add new entries above this line, newest at the bottom of the file. -->
