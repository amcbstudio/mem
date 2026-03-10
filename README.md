# mem

`mem` is a deterministic, CLI-first memory sidecar for dev workflows.

It records interactions (commits, agent runs, decisions) as append-only JSONL events and maintains compacted artifacts (`state.json` + `MEMORY.md`) so humans and agents can recover context quickly and deterministically.

## What mem is

- A local, append-only event log
- Deterministic compaction into a small state summary
- A set of POSIX `/bin/sh` tools with machine-legible outputs

## What mem is not

- Not a database
- Not a background daemon
- Not an AI service or RAG system
- Not a remote sync tool

## Quickstart

1. Clone with submodules:

```
git clone --recurse-submodules https://github.com/amcbstudio/mem.git
```

2. Install hooks in a target repo:

```
/path/to/mem/hooks/install.sh
```

3. Initialize and use:

```
mem init
mem add note k=v
mem sync
mem show
```

## Hooks and adapters

`mem` should be treated as the durable memory layer, not as a tool-specific hook system.

- The hooks bundled in this repository are native git hooks (`post-commit`, `post-merge`).
- Agent runtimes with lifecycle hooks can use `mem` as a sidecar by appending events at prompt, tool, and session boundaries.
- GitHub Copilot's coding-agent hooks are a strong fit because they expose session, prompt, tool, and stop events.
- Tools without native hooks can still integrate through wrappers, MCP tools, or other adapter layers, but that is less stable than first-class lifecycle hooks.

Recommended pattern:

1. Hook or adapter captures a lifecycle event.
2. Adapter maps that event into a small, stable `mem add TYPE ...` call.
3. `mem sync` compacts the append-only log into deterministic state artifacts.

Example mappings:

- `SessionStart` -> `mem add run phase=session_start tool=copilot`
- `UserPromptSubmit` -> `mem add note phase=prompt_submit tool=copilot`
- `PreToolUse` -> `mem add run phase=tool_pre tool=copilot action=...`
- `PostToolUse` -> `mem add run phase=tool_post tool=copilot action=... status=...`
- `Stop` -> `mem add run phase=session_stop tool=copilot`

For Codex and similar tools, the same model applies, but integration may need to come from project docs, MCP memory tools, or external wrappers until a native hook surface exists.

## Data model

- `.amcb/memory/events.jsonl` is append-only.
- `.amcb/memory/state.json` and `.amcb/memory/MEMORY.md` are derived and deterministic.
- Schema drift is tracked in `.amcb/memory/schema.fields.jsonl` and `.amcb/memory/drift.jsonl`.

## Storage location

By default, mem writes to:

```
.amcb/memory/
  events.jsonl
  schema.fields.jsonl
  drift.jsonl
  state.json
  MEMORY.md
  tmp/
```

## Dependencies

- POSIX `/bin/sh`
- `jq`
- `kv`, `jsonl`, and `jd` (included as git submodules)

## Non-goals

- No AI calls
- No network access at runtime
- No background daemons
- No remote sync
- No dependency on any single agent vendor's hook API
