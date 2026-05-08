# Examples

Generate an example Harness into a temporary directory:

```bash
tmpdir=$(mktemp -d)
skills/harness-init/bin/init-harness.sh --project-root "$tmpdir" --project-name demo-project
find "$tmpdir/.harness" -maxdepth 3 -type f | sort
rm -rf "$tmpdir"
```

The generated `.harness/` should be customized with project-specific boundaries, verification commands, environment dependencies, and reviewed Autopilot scripts.
