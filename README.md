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

