#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLI="$ROOT/skills/harness-init/bin/init-harness.sh"
PLUGIN_MANIFEST="$ROOT/.claude-plugin/plugin.json"
MARKETPLACE_MANIFEST="$ROOT/.claude-plugin/marketplace.json"

bash -n "$CLI"
jq -e '.name == "harness-init" and .version and .description and .repository and .license == "MIT"' "$PLUGIN_MANIFEST" >/dev/null
jq -e '.name == "kiblazer-harness-tools" and (.plugins | length == 1) and .plugins[0].name == "harness-init" and .plugins[0].source == "./"' "$MARKETPLACE_MANIFEST" >/dev/null
test -f "$ROOT/skills/harness-init/SKILL.md"
if command -v claude >/dev/null 2>&1; then
  claude plugin validate "$PLUGIN_MANIFEST" >/dev/null
  claude plugin validate "$MARKETPLACE_MANIFEST" >/dev/null
else
  printf 'claude CLI not found; skipping Claude plugin validate\n'
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

(cd "$ROOT" && skills/harness-init/bin/init-harness.sh --project-root "$tmpdir" --project-name demo-project > "$tmpdir/init.out")

required_files=(
  ".harness/README.md"
  ".harness/agents/project-owner.md"
  ".harness/rules/engineering-rules.md"
  ".harness/rules/project-boundaries.md"
  ".harness/rules/verification-rules.md"
  ".harness/skills/skill-routing.md"
  ".harness/context/project-map.md"
  ".harness/context/current-state.md"
  ".harness/context/domain-adapters.md"
  ".harness/context/env-dependencies.md"
  ".harness/autopilot/policy.md"
  ".harness/autopilot/report-template.md"
  ".harness/changes/README.md"
  ".harness/changes/.gitignore"
  ".harness/mcp/README.md"
  ".harness/scripts/README.md"
  ".harness/templates/change-summary.md"
  ".harness/templates/verification-report.md"
)

for file in "${required_files[@]}"; do
  test -f "$tmpdir/$file"
done

grep -q "demo-project Harness" "$tmpdir/.harness/README.md"

if grep -R -nE '(/home/|/Users/|[A-Za-z]:\\)' "$tmpdir/.harness"; then
  echo "Generated Harness contains machine-specific absolute paths." >&2
  exit 1
fi

printf 'custom content\n' > "$tmpdir/.harness/README.md"
"$CLI" --project-root "$tmpdir" --project-name demo-project > "$tmpdir/init-second.out"
grep -qx 'custom content' "$tmpdir/.harness/README.md"
grep -q 'SKIP .harness/README.md' "$tmpdir/init-second.out"

"$CLI" --project-root "$tmpdir" --project-name demo-project --force > "$tmpdir/init-force.out"
grep -q "demo-project Harness" "$tmpdir/.harness/README.md"
grep -q 'WRITE .harness/README.md' "$tmpdir/init-force.out"

inside_tmpdir="$(mktemp -d)"
"$CLI" --project-root "$inside_tmpdir" --project-name direct-project >/dev/null
(
  cd "$inside_tmpdir"
  "$CLI" --project-name inside-project --force > init-inside.out
)
grep -q "inside-project Harness" "$inside_tmpdir/.harness/README.md"
rm -rf "$inside_tmpdir"

printf 'harness-init tests passed\n'
