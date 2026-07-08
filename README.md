# [Project Name]

_AI-driven project structure template for multi-agent development._

A reusable project template designed to work with Claude, Cursor, Copilot, Codex, OpenCode, Aider, Cline, Kilo, Windsurf, Gemini, and other AI coding tools. Provides canonical role prompts, reusable skill workflows, and adapter generation so agents can collaborate consistently across any tool.

---

## Quick Start

1. **Clone the repository**

   ```bash
   git clone <repo-url> <project-name>
   cd <project-name>
   ```

2. **Install prerequisites**

   - [PowerShell 7+](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell) or Windows PowerShell 5.1.
   - Your chosen runtime, language, and test framework (see `AGENTS.md` → Detected Tech Stack).

3. **Update template placeholders**

   Replace bracketed placeholders in `AGENTS.md`, `wiki/tdd/tdd.md`, product docs, and project-structure docs with project-specific values. Use the `update-docs` skill or edit manually.

   ```bash
   # Example: set the project goal
   # Edit AGENTS.md: [State the project goal here.] -> "Build a todo app"
   ```

4. **Run adapter generation**

   ```powershell
   pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/sync-ai-adapters.ps1 -Target all
   ```

   This creates or refreshes tool-specific agent and skill files in `.claude/`, `.cursor/`, `.github/`, `.opencode/`, and other adapter folders.

5. **Validate the template**

   ```powershell
   pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/validate-ai-template.ps1
   ```

   All checks should pass. If placeholders remain, the validation will still pass — only metadata and structure are checked.

---

## Repository Structure

| Directory | Purpose |
|---|---|
| `application/` | User-facing application, client, or primary runtime |
| `service/` | Backend service, API, worker, or integration layer |
| `shared/` | Shared contracts, utilities, types, or design assets |
| `tests/` | Cross-cutting manual and automated tests |
| `wiki/` | Project intent, contracts, architecture, and operations docs |
| `.agents/` | Canonical AI roles, skills, overlays, workflows, and tool policies |
| `.ai/` | Context routing, maps, prompt recipes, and generated-index guidance |
| `scripts/` | Automation scripts (adapter sync, validation, etc.) |

Generated AI adapter folders (`.claude/`, `.cursor/`, `.github/`, `.opencode/`, etc.) are produced by `scripts/sync-ai-adapters.ps1` and should not be edited directly.

---

## Documentation

- **`AGENTS.md`** — agent operating rules, repository map, tech stack, and verification commands.
- **`wiki/`** — product specification, architecture, data model, API spec, testing, deployment, and development plan.
- **`.ai/`** — context routing, agent maps, and prompt recipes for efficient AI interaction.

---

## License

MIT — see `LICENSE`.
