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

## Agent hook guidance

When `mem` is used behind an agent hook or wrapper, prefer keeping the event `type` small and stable, then attach lifecycle detail as fields.

Recommended pattern:

- use `run` for session/tool lifecycle events
- use `note` for prompt submissions or short recovered context
- keep tool-specific names in fields such as `tool`, `hook`, `phase`, `action`, `status`

Examples:

- `{"type":"run","tool":"copilot","phase":"session_start"}`
- `{"type":"note","tool":"copilot","phase":"prompt_submit","topic":"refactor parser"}`
- `{"type":"run","tool":"copilot","phase":"tool_pre","action":"shell"}`
- `{"type":"run","tool":"copilot","phase":"tool_post","action":"shell","status":"success"}`
- `{"type":"run","tool":"codex","phase":"session_stop"}`

## Custom types

Projects may add additional types if needed. Keep type names short, lowercase, and stable.
