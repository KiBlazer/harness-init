# Permission Model

Harness automation should use fixed reviewed entrypoints instead of broad command permissions.

Prefer:

```text
Bash(.harness/scripts/verify-something-dev.sh)
```

Avoid:

```text
Bash(python3 *)
Bash(curl *)
Bash(java *)
Bash(kill *)
Bash(bash *)
```

Local/dev Autopilot scripts should include environment guards and should stop only processes started by the same script run.

Production, shared infrastructure, destructive SQL, deployment, and unclear business decisions should stop and produce `blocker.md` rather than prompting repeatedly during unattended mode.
