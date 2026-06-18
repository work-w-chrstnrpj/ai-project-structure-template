# Project Template

This folder is a reusable, project-agnostic structure for starting a new software project with clear documentation, AI-agent guidance, quality practices, and implementation placeholders.

It is intentionally technology-agnostic. Replace bracketed placeholders such as `[Project Name]`, `[Domain]`, `[Runtime]`, `[Data Store]`, and `[External Integration]` with details from the target project.

## How To Use This Template

1. Start with `docs/tdd/tdd.md` and describe the technical design, constraints, and implementation intent.
2. Fill `docs/product-specification/product-specification.md` with the product goals, user needs, and acceptance criteria.
3. Update `docs/project-structure/project-structure.md` so the folder map matches the project you are building.
4. Fill only the docs that apply. Delete or archive sections that are not relevant to the project.
5. Adapt `application/`, `service/`, `shared/`, and `tests/` to the actual architecture and programming language.
6. Update `AGENTS.md`, `.agents/roles/`, `.agents/skills/`, and `.agents/workflows/` with project-specific paths only after the project structure is known.

## Fill First

| File | Purpose |
| --- | --- |
| `docs/tdd/tdd.md` | Technical design and implementation intent. |
| `docs/product-specification/product-specification.md` | Product goals, user workflows, and acceptance criteria. |
| `docs/project-structure/project-structure.md` | Source layout, ownership boundaries, and dependency rules. |
| `AGENTS.md` | Agent operating rules for this project. |

## Optional Folders

| Folder | Use When |
| --- | --- |
| `.claude/` | The project uses Claude-compatible agent adapters. |
| `.cursor/` | The project uses Cursor rules. |
| `.clinerules/` | The project uses Cline rules. |
| `.github/` | The project uses repository automation or issue and pull-request templates. |
| `service/` | The project has a backend, worker, service, API, job, or integration layer. |

## What This Template Does Not Include

This template does not include generated artifacts, build outputs, dependencies, runtime logs, local databases, binaries, screenshots, spreadsheets, or project-specific source code. Add those only when a real project requires them.
