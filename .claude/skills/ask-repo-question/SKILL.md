---
name: ask-repo-question
description: Answer repository questions without editing files. Use when the user asks how the codebase works, where behavior lives, what a change would affect, or wants explanation only.
---

# Ask Repo Question

## Workflow

1. Read `AGENTS.md` when project guardrails matter.
2. Use `.ai/context-routing.md` when the question needs repo navigation.
3. Pick the smallest relevant map from `.ai/maps/` when helpful.
4. Use `.ai/index`, `rg`, Graphify, or Understand Anything to locate likely files.
5. Read exact files before making factual claims.
6. Answer directly with file references when useful.

## Boundaries

- Do not edit files.
- Do not treat generated context as source truth.
- Do not speculate when exact files can answer the question.

## Output

- Relevant files or docs inspected.
- Work completed or plan produced.
- Tests or verification run or recommended.
- Docs updated or skipped with reason.
- Remaining risks, assumptions, and handoffs.
