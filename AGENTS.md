# Project Agent Rules

Source of intent: `docs/tdd/tdd.md`. Source files remain the final implementation truth.

Agents working in this repository must keep implementation and documentation changes aligned with the project goal:

```text
[State the project goal here.]
```

## Project Overview

Describe `[Project Name]`, the target audience, the main user workflows, and the highest-level system responsibilities. Keep this section specific enough for agents to avoid inventing behavior.

## Detected Tech Stack

Fill this after the project chooses its tools.

- Application/runtime: `[Runtime or framework]`
- Service/API layer: `[Runtime, framework, or not applicable]`
- Data store: `[Data Store or not applicable]`
- Testing: `[Test tools]`
- Deployment: `[Deployment target]`

## Repository Map

Update this map whenever the project structure changes.

- `application/`: user-facing application, client, command surface, or primary runtime.
- `service/`: backend service, API, worker, job, integration, or process layer.
- `shared/`: shared contracts, utilities, constants, types, schemas, or design assets.
- `tests/`: cross-cutting manual and automated tests.
- `docs/`: project intent, contracts, architecture, operations, and quality documentation.
- `.agents/`: reusable AI roles, skills, workflows, and tool policies.
- `.ai/`: context routing, maps, prompt recipes, and generated-index guidance.

## Core Operating Rules

- Prefer project docs as the source of product intent.
- Prefer exact source files as the source of implementation truth.
- Use maps, indexes, graphs, and summaries only for discovery.
- Read exact files before changing them.
- Make small, reviewable edits that follow the project structure.
- Run relevant verification before claiming success.
- Ask for approval before destructive, high-risk, production, secret, or migration operations.

## Documentation Rules

- Keep `docs/tdd/tdd.md` canonical for technical intent.
- Update API, data, diagram, testing, deployment, and project-structure docs when behavior or architecture changes.
- If work is tracked in `docs/development-plan/development-plan.md`, update the matching status.
- Do not add project-specific requirements to reusable template files unless the project has adopted them.

## Security Rules

- Do not commit secrets, tokens, private keys, credentials, or production configuration.
- Do not log sensitive input, provider responses, credentials, or private user data.
- Validate input at trust boundaries.
- Prefer least privilege for accounts, tokens, services, and automation.

## Git And PR Rules

- Check `git status` before major edits.
- Do not revert user changes unless explicitly asked.
- Keep commits scoped and explain verification in PR notes.
- Avoid force push, reset, clean, or destructive history operations without explicit approval.

## AI Role Usage Guide

Portable role prompts live in `.agents/roles/`.

- System Architect: architecture, module boundaries, dataflow, and technical risk.
- Product & Planning Manager: requirements, acceptance criteria, task breakdown, dependencies, and progress coordination.
- Frontend UI/UX Developer: UI, routing, state, accessibility, client behavior, and frontend tests.
- Backend & Database Engineer: APIs, services, validation, auth, persistence, integrations, jobs, queues, and data ingestion.
- DevOps Engineer: CI/CD, deployment, runtime config, automation operations, monitoring, and releases.
- Security Engineer: secrets, auth, authorization, dependency risk, unsafe inputs, logging, and sensitive workflows.
- SQA Engineer: test plans, manual cases, automated tests, regressions, acceptance verification, and bug reports.
- Technical Documentation Specialist: README, API docs, setup, onboarding, operations, workflow, integration, and changelog docs.

## Skill Usage Guide

Reusable skills live in `.agents/skills/`. Choose the smallest skill that matches the task, then read exact source files before editing.

## Verification Commands

Replace these placeholders with the project commands.

- `[lint command]`: static style and quality checks.
- `[typecheck command]`: type or compile checks, if applicable.
- `[test command]`: automated test suite.
- `[build command]`: production build, package, or release artifact check.
- `[e2e command]`: end-to-end or system verification, if applicable.
