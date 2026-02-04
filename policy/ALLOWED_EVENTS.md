# Allowed Events

This document lists the event types that are expected in `events.jsonl`.

These are not enforcement rules in code (yet). They are guidance for humans and agents.

## Core types

- `commit` — a git commit (captured by hooks)
- `merge` — a git merge (captured by hooks)
- `note` — a free-form note or observation
- `decision` — a recorded decision with rationale
- `run` — an automated agent run or tool invocation
- `drift` — a schema drift observation or follow-up note

## Custom types

Projects may add additional types if needed. Keep type names short, lowercase, and stable.
