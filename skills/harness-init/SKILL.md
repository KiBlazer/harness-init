---
name: harness-init
description: Initialize a project-level .harness directory for Harness Engineering adoption in any project.
---

# harness-init

## When to use

Use this skill when the user wants to create, standardize, or refresh a project-level `.harness/` directory so other projects can practice Harness Engineering quickly.

Trigger examples:

- "给这个项目创建 harness"
- "初始化 .harness"
- "把 Harness 固化到这个工程"
- "其他工程也要快速创建 harness"
- "make a harness init for this repo"

## Goal

Create a reusable Harness Engineering control layer in the target project without copying installed skill implementations or embedding machine-specific absolute paths.

## Target location

Default target is the current project root:

```text
.harness/
```

If the user gives a target project path, use that path as the project root. If the current working directory is a monorepo parent and the user names a module, initialize the module root instead.

## Required output structure

Create this minimum structure:

```text
.harness/
├── README.md
├── agents/
│   └── project-owner.md
├── rules/
│   ├── engineering-rules.md
│   ├── project-boundaries.md
│   └── verification-rules.md
├── skills/
│   └── skill-routing.md
├── context/
│   ├── project-map.md
│   ├── current-state.md
│   ├── domain-adapters.md
│   └── env-dependencies.md
├── autopilot/
│   ├── policy.md
│   └── report-template.md
├── changes/
│   ├── README.md
│   └── .gitignore
├── mcp/
│   └── README.md
├── scripts/
│   └── README.md
└── templates/
    ├── change-summary.md
    └── verification-report.md
```

## Initialization rules

1. Use project-relative paths inside generated files.
2. Do not write local absolute paths such as `/home/...`, `/Users/...`, or drive-specific paths.
3. Do not copy full installed skill implementations into `.harness/skills/`.
4. Generate `.harness/skills/skill-routing.md` as an index that points to existing skills.
5. Do not overwrite existing `.harness/` files unless the user explicitly asks to refresh or replace them.
6. If files already exist, read them first and merge conservatively.
7. Keep templates generic; project-specific boundaries should be marked as TODOs unless the user provides the domain context.
8. Add `.harness/changes/.gitignore` to ignore local Autopilot run directories by default.
9. Do not add broad allowlist entries for interpreters, shells, `curl`, `java`, `kill`, package runners, or arbitrary scripts.
10. If adding `.claude/settings.json` examples, use exact project-relative script entrypoints only.

## Recommended workflow

1. Identify target project root and project display name.
2. Check whether `.harness/` already exists.
3. Create missing directories and files from the templates in this skill.
4. Customize placeholders:
   - `{{PROJECT_NAME}}`
   - `{{PROJECT_OWNER_FILE}}`
   - `{{PROJECT_ROOT_LABEL}}`
5. Verify no generated reusable file contains machine-specific absolute paths.
6. Verify `.harness/skills/` contains routing only, not copied skill implementations.
7. Run a lightweight structural check:
   - list `.harness/`
   - grep for unresolved critical placeholders
   - validate markdown/files exist
   - run `git diff --check` when inside a git repository
8. Report created files, skipped existing files, and next project-specific customization tasks.

## Autopilot guidance

Generated Autopilot policy should define four buckets:

- Always auto: read-only inspection, local evidence collection, report generation.
- Auto in local/dev: fixed local/dev verification scripts after environment guard checks.
- Auto fix: deterministic local Harness/script/report issues.
- Stop and report: production/shared environment changes, destructive SQL, deployment, unclear business decisions, broad permissions.

## Settings guidance

If the user wants fewer permission prompts, prefer this pattern:

```json
{
  "permissions": {
    "allow": [
      "Bash(.harness/scripts/<fixed-reviewed-script>.sh)"
    ]
  }
}
```

Avoid broad patterns such as:

```text
Bash(python3 *)
Bash(curl *)
Bash(java *)
Bash(kill *)
Bash(bash *)
```

## Verification checklist

Before reporting done, check:

- `.harness/README.md` exists and explains loading order.
- `.harness/agents/project-owner.md` exists.
- `.harness/rules/*` exists.
- `.harness/skills/skill-routing.md` references existing skills without copying them.
- `.harness/autopilot/policy.md` exists.
- `.harness/changes/.gitignore` ignores local Autopilot run directories.
- reusable Harness files contain no machine-specific absolute path.
- `git diff --check` passes when available.

## Final response

Keep the final response concise. Include:

- target project root
- files created or updated
- whether existing files were preserved
- verification performed
- next customization step
