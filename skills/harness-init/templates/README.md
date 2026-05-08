# {{PROJECT_NAME}} Harness

This directory is the project-level Harness for AI-assisted engineering work in this project.

It complements existing skills, project documentation, and working context instead of replacing them.

## Loading order

For project work, load context in this order:

1. `.harness/README.md`
2. `.harness/agents/project-owner.md`
3. Relevant files in `.harness/rules/`
4. Relevant files in `.harness/context/`
5. Existing skills routed by `.harness/skills/skill-routing.md`
6. Active change record under `.harness/changes/`, when one exists

## Directory roles

- `agents/`: owner-role and orchestration instructions.
- `rules/`: stable engineering and project constraints.
- `skills/`: routing to existing skills, not copied skill implementations.
- `context/`: project maps, domain adapters, current state, and environment assumptions.
- `autopilot/`: unattended execution policy and report conventions.
- `changes/`: per-change audit trails and verification evidence.
- `mcp/`: future external tool integration notes.
- `scripts/`: reviewed project-local automation entrypoints.
- `templates/`: reusable change and verification templates.

## Anti-duplication rule

Do not copy full installed skill implementations into `.harness/skills/`. Keep `.harness/skills/` as routing and project-specific usage guidance only.

## Path rule

Use project-relative paths in Harness files. Do not write machine-specific absolute paths.
