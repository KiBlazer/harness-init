# Official Marketplace Submission Checklist

Use this checklist before submitting `harness-init` to an official or curated Claude Code plugin marketplace.

## Package readiness

- [ ] `.claude-plugin/plugin.json` exists and validates with `claude plugin validate`.
- [ ] `.claude-plugin/marketplace.json` exists and validates with `claude plugin validate`.
- [ ] Plugin name is stable: `harness-init`.
- [ ] Marketplace name is stable: `kiblazer-harness-tools`.
- [ ] Version is bumped whenever plugin behavior or metadata changes.
- [ ] `CHANGELOG.md` includes the released version.
- [ ] `LICENSE` is present and compatible with public reuse.
- [ ] README installation commands are tested against a clean clone.

## Skill quality

- [ ] `skills/harness-init/SKILL.md` clearly explains when to use the skill.
- [ ] The skill creates project-relative Harness files only.
- [ ] The skill does not instruct users to allow broad shell, interpreter, or network permissions.
- [ ] The skill does not copy full implementations of unrelated skills into generated `.harness/skills/`.
- [ ] Generated templates are generic and do not include Synapse-specific or machine-specific details.

## Security and privacy

- [ ] No secrets, tokens, host-specific credentials, or private URLs are present.
- [ ] No machine-specific absolute paths are present in generated templates.
- [ ] Generated Autopilot policy clearly separates local/dev automation from production/shared-environment actions.
- [ ] Generated scripts directory contains guidance only unless scripts are intentionally reviewed and included.
- [ ] Local Autopilot evidence is gitignored by default.

## Verification

- [ ] `tests/test-init-harness.sh` passes locally.
- [ ] GitHub Actions CI passes on `main`.
- [ ] Clean-clone verification passes:

```bash
tmpdir=$(mktemp -d)
git clone git@github.com:KiBlazer/harness-init.git "$tmpdir/repo"
cd "$tmpdir/repo"
tests/test-init-harness.sh
claude plugin validate .claude-plugin/plugin.json
claude plugin validate .claude-plugin/marketplace.json
```

- [ ] Marketplace add/install flow passes:

```text
/plugin marketplace add KiBlazer/harness-init
/plugin install harness-init@kiblazer-harness-tools
/harness-init:harness-init create a Harness for the current project
```

## Documentation

- [ ] README explains plugin installation, standalone skill installation, and direct CLI usage.
- [ ] README explains safety model and permission model.
- [ ] `docs/harness-engineering.md` explains the concept.
- [ ] `docs/permission-model.md` explains why fixed reviewed entrypoints are preferred.
- [ ] `docs/autopilot-policy.md` explains PASS, FIXED_AND_PASS, and BLOCKED outcomes.

## Submission notes

When submitting, include:

- repository URL: `https://github.com/KiBlazer/harness-init`
- plugin name: `harness-init`
- short description: `Initialize project-level .harness directories for Harness Engineering workflows.`
- intended audience: engineering teams using Claude Code across multiple projects
- safety summary: no broad permissions, no secrets, project-relative templates, local/dev Autopilot policy only
- verification summary: smoke tests, marketplace validation, clean-clone install verification, CI
