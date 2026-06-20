---
name: plan-code-change
description: Plan a code change without editing files. Use when the user asks to plan, scope, design, estimate, or inspect before implementation.
---

# Plan Code Change

## Workflow

1. Read `AGENTS.md`.
2. Read `.ai/context-routing.md`.
3. Pick the smallest relevant map from `.ai/maps/`.
4. Use `.ai/index`, `rg`, Graphify, or Understand Anything to identify candidate files and dependencies.
5. Read exact source files, nearby tests, contracts, and docs before proposing implementation details.
6. Identify product, API, database, security, documentation, and testing constraints.
7. Produce a focused implementation plan.

## Boundaries

- Do not edit files.
- Do not stage, commit, push, deploy, or run migrations.
- Do not treat generated maps, graphs, summaries, or indexes as implementation truth.

## Output

- Relevant files or docs inspected.
- Work completed or plan produced.
- Tests or verification run or recommended.
- Docs updated or skipped with reason.
- Remaining risks, assumptions, and handoffs.
