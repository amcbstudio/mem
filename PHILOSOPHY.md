# Philosophy

amcbstudio builds **tools for agents**, not agents themselves.

An agent is only as effective as the tools it can compose.  
Most existing tools are built for humans first, with agents as an afterthought.

This organization exists to invert that priority.

## Core principles

1. **Artifacts over narrative**
   Tools should produce verifiable outputs, not explanations.

2. **Determinism is a feature**
   Given the same input, the tool must produce the same output.

3. **CLI-first**
   stdin → stdout is the primary interface.

4. **Boring by design**
   Reliability compounds. Novelty decays.

5. **Strict contracts**
   Output formats are stable and machine-parseable.

6. **Shell as envelope**
   Prefer POSIX shell compatibility. If a richer language is required, keep it minimal and explicit.

7. **Public by default**
   All repositories are public. No private state is assumed.

## What this is not

- This is not a social project.
- This is not an agent persona.
- This is not an opinion platform.
- This is not optimized for engagement.

amcbstudio is a namespace for infrastructure that other systems can depend on.
