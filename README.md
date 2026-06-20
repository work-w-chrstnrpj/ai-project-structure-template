# Project Template

This folder is a reusable, project-agnostic structure for starting a new software project with clear documentation, AI-agent guidance, quality practices, and implementation placeholders.

It is intentionally technology-agnostic. Replace bracketed placeholders such as `[Project Name]`, `[Domain]`, `[Runtime]`, `[Data Store]`, and `[External Integration]` with details from the target project.

## How To Use This Template

1. Start with `wiki/tdd/tdd.md` and describe the technical design, constraints, and implementation intent.
2. Fill `wiki/product-specification/product-specification.md` with the product goals, user needs, and acceptance criteria.
3. Update `wiki/project-structure/project-structure.md` so the folder map matches the project you are building.
4. Fill only the wiki pages that apply. Delete or archive sections that are not relevant to the project.
5. Adapt `application/`, `service/`, `shared/`, and `tests/` to the actual architecture and programming language.
6. Update `AGENTS.md`, `.agents/roles/`, `.agents/skills/`, and `.agents/workflows/` with project-specific paths only after the project structure is known.
7. Run `scripts/generate-ai-adapters.ps1` after role or skill changes so Claude, Codex, Cursor, GitHub Copilot, and OpenCode can discover tool-specific adapters.

## Fill First

| File | Purpose |
| --- | --- |
| `wiki/tdd/tdd.md` | Technical design and implementation intent. |
| `wiki/product-specification/product-specification.md` | Product goals, user workflows, and acceptance criteria. |
| `wiki/project-structure/project-structure.md` | Source layout, ownership boundaries, and dependency rules. |
| `AGENTS.md` | Agent operating rules for this project. |

## Optional Folders

| Folder | Use When |
| --- | --- |
| `.claude/` | The project uses Claude-compatible agent adapters. |
| `.codex/` | The project uses Codex custom agent adapters. |
| `.cursor/` | The project uses Cursor rules. |
| `.opencode/` | The project uses OpenCode-compatible agent and skill adapters. |
| `.github/` | The project uses repository automation, Copilot agents, Copilot skills, or issue and pull-request templates. |
| `service/` | The project has a backend, worker, service, API, job, or integration layer. |

## AI Tool Adapters

Canonical role prompts live in `.agents/roles/`; canonical skills live in `.agents/skills/`. Tool-specific folders are generated adapters, not the source of truth:

- Claude: `.claude/agents/*.md` and `.claude/skills/<skill>/SKILL.md`
- Codex: `.codex/agents/*.toml`; skills are read from `.agents/skills/`
- Cursor: `.cursor/rules/*.mdc` and `.cursor/skills/<skill>/SKILL.md`
- GitHub Copilot: `.github/agents/*.agent.md` and `.github/skills/<skill>/SKILL.md`
- OpenCode: `.opencode/agents/*.md` and `.opencode/skills/<skill>/SKILL.md`
- Google Antigravity: UI-managed agents; workspace skills use `.agents/skills/<skill>/SKILL.md`

## What This Template Does Not Include

This template does not include generated artifacts, build outputs, dependencies, runtime logs, local databases, binaries, screenshots, spreadsheets, or project-specific source code. Add those only when a real project requires them.
