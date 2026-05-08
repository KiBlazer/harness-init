# Autopilot Policy

Autopilot mode is for known local/dev verification loops after policy and script entrypoints have been reviewed.

A good Autopilot script should:

- verify it is running against local/dev configuration
- use project-relative paths
- generate `harness-*` or otherwise approved test data
- collect logs and environment snapshots
- write a verification report
- clean up only resources it created
- stop and write `blocker.md` when it reaches a risky boundary

Autopilot run outcomes should be one of:

- `PASS`
- `FIXED_AND_PASS`
- `BLOCKED`
