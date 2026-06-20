---
name: execute-code-change
description: Implement a code change end to end. Use when the user asks to execute, implement, fix, modify, update, refactor, or add behavior in the repo.
---

# Execute Code Change

## Workflow

1. Read `AGENTS.md`.
2. Read `.ai/context-routing.md`.
3. Pick the smallest relevant map from `.ai/maps/`.
4. Use `.ai/index`, `rg`, Graphify, or Understand Anything for discovery.
5. Read exact source files, nearby tests, contracts, and docs before editing.
6. Confirm the smallest safe implementation that follows existing patterns.
7. Edit narrowly.
8. Add or update tests when behavior changes.
9. Update docs when API, database, architecture, deployment, project structure, AI workflow, or user-facing behavior changes.
10. Run the smallest relevant verification command.
11. Summarize files, behavior, verification, and remaining risk.

## Boundaries

- Do not bypass project guardrails in `AGENTS.md`.
- Do not expose secrets or sensitive data.
- Do not claim verification passed unless it actually ran.
- Do not edit from generated context alone.

## Output

- Relevant files or docs inspected.
- Work completed or plan produced.
- Tests or verification run or recommended.
- Docs updated or skipped with reason.
- Remaining risks, assumptions, and handoffs.
