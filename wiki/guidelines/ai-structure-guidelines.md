# AI Structure Guidelines

This file is intended to document how AI agents, roles, skills, workflows, and context tools should be organized for this project.

## Suggested Sections

- Canonical roles.
- Skill naming rules.
- Workflow naming rules.
- When to create a new skill.
- When to update an existing skill.
- Context routing rules.
- Wiki update rules.
- Verification expectations.

Keep reusable guidance in `.agents/`. Keep project-specific paths and decisions in `AGENTS.md`, `.ai/`, and `wiki/`.

## Tool Adapter Pattern

Keep the reusable source of truth in `.agents/roles/` and `.agents/skills/`. Tool-specific folders exist so each AI tool can discover the same intent in its native format.

Run `scripts/generate-ai-adapters.ps1` after changing a canonical role or skill.

| Tool | Agent Adapter | Skill Adapter |
| --- | --- | --- |
| Claude Code | `.claude/agents/<agent>.md` | `.claude/skills/<skill>/SKILL.md` |
| Codex | `.codex/agents/<agent>.toml` | `.agents/skills/<skill>/SKILL.md` |
| Cursor | `.cursor/rules/<agent>.mdc` | `.cursor/skills/<skill>/SKILL.md` |
| GitHub Copilot | `.github/agents/<agent>.agent.md` | `.github/skills/<skill>/SKILL.md` |
| OpenCode | `.opencode/agents/<agent>.md` | `.opencode/skills/<skill>/SKILL.md` |
| Google Antigravity | UI-managed agent instructions | `.agents/skills/<skill>/SKILL.md` |
