# AI Project Structure Template

_Token-efficient, portable AI agent architecture and preset generator for modern software development._

A standardized AI development framework designed to work seamlessly across **Cursor**, **Antigravity**, **Claude Code**, **Codex**, and **OpenCode**. It provides canonical role definitions, reusable workflow skills, on-demand capability playbooks, and automated adapter generation so AI agents can collaborate consistently across any tool without wasting tokens.

---

## Key Features

1. **Portable AI Layer (`.agents/`)**: One canonical source of truth for roles, skills, overlays, workflows, and tool policies.
2. **5 Major Provider Presets**:
   - **Cursor**: Scoped `.cursor/rules/*.mdc` (no context-bloating wildcards) and `.cursor/skills/`.
   - **Antigravity**: Direct canonical integration via `AGENTS.md` and `.agents/skills/`.
   - **Claude Code**: Tailored `.claude/agents/*.md`, `CLAUDE.md`, and `.claude/skills/`.
   - **Codex**: Compact `.codex/agents/*.toml` agent definitions for Codex agentic development.
   - **OpenCode**: Subagents in `.opencode/agents/*.md`, skills, and non-destructive `opencode.json` configuration merging.
3. **Capability Profiles**:
   - `fullstack`: Software Engineer, Frontend, Backend, System Architect, SQA, Docs.
   - `general`: General Software Engineer + System Architect with core planning/coding/review skills.
   - `qa`: SQA Engineer + test authoring, manual/automated execution, investigation, and RCA.
   - `architecture`: System Architect + Security Engineer for boundaries, dataflow, and planning.
   - `docs`: Technical Documentation Specialist + documentation update workflows.
   - `all`: Full suite of 9 roles, 13+ skills, overlays, and SDLC workflows.
4. **Token-Efficient Design**:
   - Decomposes monolithic roles into compact core prompts (~70 lines) with on-demand reference playbooks (`.agents/roles/playbooks/`).
   - Removes greedy `globs: '**/*'` from on-demand Cursor rules to prevent context saturation.
   - Built-in token measurement utility (`create-preset measure`).
5. **Context Validation & Safe Sync**:
   - Normalized `docs/` paths with explicit status tracking (`[NOT_STARTED | IN_PROGRESS | COMPLETE | NOT_APPLICABLE]`).
   - Context linter that warns on missing info and blocks only when a specific requested task requires that context.
   - Non-destructive sync that preserves user customizations and configs.

---

## Quick Start

### 1. Prerequisites
- **Node.js 18+** (zero third-party npm dependencies required).

### 2. Generate a Preset for Your Preferred Tool
Run the preset generator directly:

```bash
# Generate fullstack preset for Cursor into the current directory
node bin/create-preset.mjs cursor --profile fullstack

# Generate QA preset for Claude Code
node bin/create-preset.mjs claude --profile qa

# Generate Codex preset into another project directory
node bin/create-preset.mjs codex --profile all --into ../my-new-project

# Dry run preview
node bin/create-preset.mjs opencode --profile fullstack --dry-run
```

### 3. Sync Adapters
When you update canonical roles, skills, or workflows in `.agents/`, refresh all tool adapters:

```bash
node bin/create-preset.mjs sync --target all
# or via npm script:
npm run sync
```

### 4. Validate Template & Context
Check that all roles, skills, routing paths, and required documentation fields are valid:

```bash
node bin/create-preset.mjs validate
# or check if context is ready for a specific task:
node bin/create-preset.mjs validate --task database
```

### 5. Measure Token Consumption
Inspect startup token overhead and verify token savings across providers and profiles:

```bash
node bin/create-preset.mjs measure
```

---

## Repository Structure

| Directory | Purpose |
|---|---|
| `bin/` | Native Node.js CLI executable (`create-preset` / `ai-preset`) |
| `lib/` | Preset generators, profile definitions, validator, and token measurement engine |
| `docs/` | Canonical project intent, architecture, data model, API spec, testing, and deployment |
| `.agents/` | Canonical AI roles, skills, overlays, playbooks, workflows, and tool policies |
| `.ai/` | Context routing, discovery maps, and prompt recipes |
| `application/` | User-facing client, frontend, command surface, or primary runtime |
| `service/` | Backend service, API, worker, job, or integration layer |
| `shared/` | Shared contracts, types, schemas, utilities, or constants |
| `tests/` | Cross-cutting manual, automated, and template regression tests |

---

## Canonical AI Roles

- **Software Engineer**: General coding, fullstack implementation, end-to-end features, refactoring, and integration.
- **System Architect**: Architecture, module boundaries, dataflow, and technical risk.
- **Product & Planning Manager**: Requirements, acceptance criteria, task breakdown, dependencies, and coordination.
- **Frontend UI/UX Developer**: UI, styling, client state, routing, accessibility, and client tests.
- **Backend & Database Engineer**: APIs, services, persistence, schema migrations, batch jobs, and integrations.
- **DevOps Engineer**: CI/CD, deployment targets, containers, monitoring, runtime config, and releases.
- **Security Engineer**: Auth, authorization, secrets, dependency risk, input sanitization, and sensitive flows.
- **SQA Engineer**: Test plans, manual test cases, automated tests, regressions, and bug reports.
- **Technical Documentation Specialist**: README, API documentation, setup, onboarding, operations, and changelogs.

---

## Documentation & Context Workflow

1. Start with `AGENTS.md` to define project goal, tech stack, and verification commands.
2. Fill core intent in `docs/tdd/tdd.md` and `docs/project-structure/project-structure.md`.
3. Track document readiness with status headers:
   - `Status: NOT_STARTED`
   - `Status: IN_PROGRESS`
   - `Status: COMPLETE`
   - `Status: NOT_APPLICABLE`
4. Use `.ai/context-routing.md` and `.ai/maps/` for compact discovery before inspecting source files.

---

## License

MIT — see `LICENSE`.
