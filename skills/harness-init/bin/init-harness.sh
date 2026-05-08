#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF_USAGE'
Usage: init-harness.sh [--project-root PATH] [--project-name NAME] [--force]

Creates a project-level .harness directory from the harness-init skill templates.

Options:
  --project-root PATH   Target project root. Defaults to current directory.
  --project-name NAME   Display name used in generated README. Defaults to target directory name.
  --force               Overwrite existing generated files.
EOF_USAGE
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$SKILL_DIR/templates"
PROJECT_ROOT="$(pwd)"
PROJECT_NAME=""
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project-root)
      PROJECT_ROOT="$2"
      shift 2
      ;;
    --project-name)
      PROJECT_NAME="$2"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

PROJECT_ROOT="$(cd "$PROJECT_ROOT" && pwd)"
if [[ -z "$PROJECT_NAME" ]]; then
  PROJECT_NAME="$(basename "$PROJECT_ROOT")"
fi

TARGET="$PROJECT_ROOT/.harness"
mkdir -p "$TARGET"

copy_template() {
  local rel="$1"
  local src="$TEMPLATE_DIR/$rel"
  local dst="$TARGET/$rel"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && "$FORCE" != "1" ]]; then
    printf 'SKIP %s\n' ".harness/$rel"
    return 0
  fi
  sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g; s/{{PROJECT_OWNER_FILE}}/project-owner.md/g; s/{{PROJECT_ROOT_LABEL}}/<project-root>/g" "$src" > "$dst"
  printf 'WRITE %s\n' ".harness/$rel"
}

while IFS= read -r -d '' file; do
  rel="${file#"$TEMPLATE_DIR/"}"
  copy_template "$rel"
done < <(find "$TEMPLATE_DIR" -type f -print0 | sort -z)

if grep -R -nE '(/home/|/Users/|[A-Za-z]:\\)' "$TARGET" >/tmp/harness-init-paths.$$ 2>/dev/null; then
  cat /tmp/harness-init-paths.$$ >&2
  rm -f /tmp/harness-init-paths.$$
  echo "Generated Harness contains machine-specific absolute paths." >&2
  exit 3
fi
rm -f /tmp/harness-init-paths.$$

printf 'DONE %s\n' "$TARGET"
