# Portable AI Agent Structure

This directory contains canonical reusable AI development assets that can move between projects.

- `roles/`: the canonical 8 subagents from the reusable agent model.
- `skills/`: repeatable workflow skills and granular capability skills.
- `workflows/`: multi-role process docs.
- `tools/`: context, command, MCP, and verification policies.

Start with `AGENTS.md`, choose the smallest role and skill that match the task, then route context through `.ai/context-routing.md`. Portable roles and skills should not contain project source paths; project-specific paths belong in `AGENTS.md`, `wiki/`, `.ai/maps/`, and `.ai/index/`.

Generated adapters for Claude, Codex, Cursor, GitHub Copilot, and OpenCode are produced from these canonical files by `scripts/generate-ai-adapters.ps1`. Do not edit generated adapters first; update `.agents/roles/` or `.agents/skills/`, then regenerate.

Generated maps, graphs, repo maps, embeddings, and snapshots are navigation aids only. Read exact source files before edits and run relevant verification before claiming success.
