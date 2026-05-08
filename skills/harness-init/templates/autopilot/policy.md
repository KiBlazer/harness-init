# Harness Autopilot Policy

This policy defines what project Harness workflows may do unattended after the user has approved the policy and fixed script entrypoints.

## Goal

Autopilot mode should close known local/dev verification loops without repeated human prompts. It must stay inside reviewed boundaries and produce evidence when it passes, fixes an issue, or stops.

## Execution states

- `PASS`: verification completed, evidence was collected, and services started by the run were stopped.
- `FIXED_AND_PASS`: an allowed local/dev issue was fixed and verification was rerun successfully.
- `BLOCKED`: the run hit a stop boundary, retained evidence, and wrote a blocker report.

## Always auto

Allowed unattended actions:

- read repository files and Harness rules/context
- inspect git state with read-only commands
- search code, logs, and generated evidence
- run local compile/test/lint commands documented by `.harness/rules/verification-rules.md`
- generate Harness reports under `.harness/changes/`

## Auto in local/dev

Allowed only after the script verifies local/dev configuration:

- start local services required for verification
- stop only the PID started by the same script run
- publish test messages only to approved dev targets
- use project-approved test-data namespaces
- write verification evidence under `.harness/changes/<date>-*/verification/`
- retry fixed verification steps a bounded number of times

## Auto fix

Allowed fixes when limited to local/dev verification code or Harness files:

- correct wrong local relative paths in Harness scripts
- recreate missing Harness evidence directories
- regenerate missing reports from available evidence
- fix deterministic shell script syntax errors
- rerun failed local verification after an allowed script fix

## Stop and report

Stop and write `blocker.md` when any of the following occurs:

- target environment is not clearly local/dev
- production/shared infrastructure would be changed
- destructive SQL, DDL, or data cleanup is required
- a process must be stopped but was not started by the current script run
- test data does not use an approved test namespace
- git push, merge, reset, force-push, or branch deletion would be required
- business semantics are unclear
- secrets would need to be printed, copied, or stored in Harness files

## Allowlist principle

Allowlist fixed reviewed script entrypoints, not broad interpreters or clients.

```text
Bash(.harness/scripts/<fixed-reviewed-script>.sh)
```
