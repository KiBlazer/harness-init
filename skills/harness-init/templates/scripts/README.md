# Harness Scripts

Put reviewed project-local automation entrypoints here.

## Rules

- Prefer fixed scripts with narrow purpose.
- Include environment guardrails in scripts before mutating local/dev state.
- Stop only processes started by the same script run.
- Use project-relative paths.
- Do not store secrets in scripts.
- Do not use this directory for broad arbitrary command wrappers.

## Permission pattern

If a script is approved for unattended local/dev use, allowlist the exact project-relative entrypoint:

```text
Bash(.harness/scripts/<script-name>.sh)
```
