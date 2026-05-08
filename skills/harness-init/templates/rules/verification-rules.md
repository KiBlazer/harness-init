# Verification Rules

Verification must match the affected change type. If a check cannot be run, record why and describe residual risk.

## Backend

Run backend commands from the project root using project-relative paths.

```bash
# TODO: replace with project backend compile/test command
```

## Frontend

Run frontend verification from the relevant frontend project directory.

```bash
# TODO: replace with project frontend build/typecheck/lint command
```

## Scripts

Compile or dry-run changed scripts when possible.

```bash
# TODO: replace with script verification command
```

## Residue search

For renamed fields, enums, config keys, APIs, or SQL artifacts, search across changed surfaces:

```bash
rg -n "keyword" .
```

## Environment checks

For deployment-sensitive changes, explicitly check or document assumptions for:

- database tables and migrations
- cache/key prefix behavior
- message queues and consumers
- scheduler/lock behavior
- external APIs and credentials
- deployment/config management

## Verification record fields

Each verification report should include:

- command
- working directory
- result
- important output summary
- skipped checks and reasons
- residual risk
