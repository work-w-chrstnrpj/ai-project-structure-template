# Documentation Index

This folder is the canonical project intent, architecture, contracts, and operating record.

## Documentation Structure & Statuses

Each document tracks its state with a standardized status header:
- `Status: NOT_STARTED` — placeholder only, not yet filled.
- `Status: IN_PROGRESS` — partially drafted, actively being updated.
- `Status: COMPLETE` — fully specified and aligned with implementation.
- `Status: NOT_APPLICABLE` — explicitly not needed for this project (e.g., no database).

### Core Required Documents
Fill these first for every project:
1. `tdd/tdd.md` — Technical design document, architecture constraints, runtime behavior.
2. `product-specification/product-specification.md` — Product goals, workflows, acceptance criteria.
3. `project-structure/project-structure.md` — Source directory layout and module ownership.

### Conditional Documents
Fill these when the project architecture requires them:
4. `api/api-specification.md` — required if the project exposes or consumes APIs.
5. `database/data-model.md` — required if the project persists data.
6. `testing/test-specification.md` — testing strategy, test layers, and verification commands.
7. `deployment/deployment.md` — deployment targets, CI/CD, environments, runtime config.

### Reference Documents
8. Diagrams, development plans, guidelines, and command references as needed.

Keep documentation concise, current, and tied to source truth. Context tools will warn on unfulfilled core documents and block tasks only when a requested workflow requires missing conditional docs.
