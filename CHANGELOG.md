# Changelog

## 0.2.0 - 2026-05-08

- Added `.claude-plugin/marketplace.json` so the repository can be added as a Claude Code marketplace.
- Documented marketplace installation flow with `/plugin marketplace add` and `/plugin install`.
- Added validation coverage for plugin and marketplace manifests.

## 0.1.0 - 2026-05-08

- Initial `harness-init` Claude Code skill.
- Added `.harness/` templates for rules, context, skill routing, changes, verification, scripts, MCP notes, and Autopilot policy.
- Added `init-harness.sh` CLI.
- Added smoke test for generated structure, path safety, idempotency, and force overwrite behavior.
