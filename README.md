# harness-init

`harness-init` is a Claude Code skill and small shell CLI for creating a project-level `.harness/` control layer for AI-assisted engineering work.

It helps teams standardize Harness Engineering practices across projects:

- project rules
- project context
- skill routing
- change audit trails
- verification templates
- Autopilot policy for safe unattended local/dev workflows

## What it creates

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

## Install as a Claude Code skill

Copy the skill into a Claude Code skills directory:

```bash
cp -R skills/harness-init /path/to/project/.claude/skills/
```

Or into a shared workspace skills directory if your project uses one:

```bash
cp -R skills/harness-init /path/to/workspace/.agents/skills/
```

Then invoke it in Claude Code:

```text
/harness-init 给当前项目创建 Harness
```

## Use the CLI directly

```bash
skills/harness-init/bin/init-harness.sh \
  --project-root /path/to/project \
  --project-name your-project
```

From inside a project root:

```bash
/path/to/harness-init/skills/harness-init/bin/init-harness.sh --project-name your-project
```

## Options

```text
--project-root PATH   Target project root. Defaults to current directory.
--project-name NAME   Display name used in generated README. Defaults to target directory name.
--force               Overwrite existing generated files.
```

By default, existing files are preserved and reported as `SKIP`.

## Safety model

`harness-init` intentionally avoids broad permissions and machine-specific paths.

Generated Harness files should:

- use project-relative paths
- avoid `/home/...`, `/Users/...`, and drive-specific absolute paths
- route to existing skills instead of copying full skill implementations
- keep local Autopilot run evidence out of git by default
- prefer exact reviewed script allowlists such as `Bash(.harness/scripts/<script>.sh)`

Generated Harness files should not:

- store secrets
- grant broad interpreter permissions
- allow arbitrary `curl`, `python`, `java`, `bash`, or `kill` execution
- treat production/shared environment actions as unattended local/dev work

## Verify

Run the test script:

```bash
tests/test-init-harness.sh
```

The test verifies:

- shell syntax
- expected `.harness/` structure
- project-name replacement
- no machine-specific absolute paths in generated output
- idempotency without `--force`
- overwrite behavior with `--force`

## Repository layout

```text
skills/harness-init/        Claude Code skill package
skills/harness-init/bin/    CLI entrypoint
skills/harness-init/templates/  Generated .harness templates
tests/                      Smoke tests
examples/                   Example generated output notes
docs/                       Concept documentation
```

## License

MIT
