# Scripts Placeholder

This folder is intended for project automation scripts.

Use scripts for repeatable development, verification, setup, maintenance, data processing, release, or operational tasks.

## Available Scripts

| Script | Purpose |
| --- | --- |
| `sync-ai-adapters.ps1` | Preferred target-aware sync for Claude, Codex, Cursor, Copilot, OpenCode, Aider, Cline, Kilo, Windsurf, Antigravity, and OpenHands adapters from canonical `.agents/` sources. |
| `generate-ai-adapters.ps1` | Compatibility wrapper that runs `sync-ai-adapters.ps1 -Target all`. |
| `validate-ai-template.ps1` | Validate canonical role metadata, skill frontmatter, generated adapter formatting, and absence of removed granular skills. Exits nonzero on failure. |

## Validation

Run validation after canonical changes or adapter regeneration:

```powershell
pwsh scripts/validate-ai-template.ps1
```

The validation script checks:

1. Canonical role metadata is parseable (`- **Name:**`, `- **Role:**`, `- **Description:**` at line starts).
2. Role files have adequate line count (not compressed).
3. Every `.agents/skills/*/SKILL.md` has valid multiline YAML frontmatter with `name:` and `description:`.
4. Removed granular skill folders are not present.
5. Generated adapter files in `.claude/`, `.cursor/`, `.github/`, `.opencode/`, `.windsurf/` use multiline frontmatter (no `--- name:` on one line).
6. Generated agent/rule files contain source-of-truth notices pointing back to `.agents/`.
7. OpenCode overlay files (coach, mentor) deny edit permission.
8. `AGENTS.md` has adequate line count and heading structure.
9. Script files have adequate line count (not compressed).

## Suggested Sections To Fill

- Script purpose.
- Required inputs.
- Expected outputs.
- Safe usage examples.
- Failure modes.
- Whether the script can change production, secrets, data, or tracked files.

Do not add destructive scripts without clear safeguards and documentation.
