# Scripts Placeholder

This folder is intended for project automation scripts.

Use scripts for repeatable development, verification, setup, maintenance, data processing, release, or operational tasks.

## Available Scripts

| Script | Purpose |
| --- | --- |
| `sync-ai-adapters.ps1` | Preferred target-aware sync for Claude, Codex, Cursor, Copilot, OpenCode, Aider, Cline, Kilo, Windsurf, Antigravity, and OpenHands adapters from canonical `.agents/` sources. |
| `generate-ai-adapters.ps1` | Compatibility wrapper that runs `sync-ai-adapters.ps1 -Target all`. |

## Suggested Sections To Fill

- Script purpose.
- Required inputs.
- Expected outputs.
- Safe usage examples.
- Failure modes.
- Whether the script can change production, secrets, data, or tracked files.

Do not add destructive scripts without clear safeguards and documentation.
