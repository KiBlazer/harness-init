# Change Audit Trails

Use this directory for per-change Harness records.

Recommended structure:

```text
.harness/changes/YYYYMMDD-short-change-name/
├── summary.md
├── request/
│   ├── spec.md
│   └── tasks.md
├── implementation/
│   └── notes.md
├── review/
│   └── review-v1.md
├── verification/
│   └── verification-report.md
└── rollout/
    └── rollout-notes.md
```

Simple tasks may use only `summary.md` and `verification/verification-report.md`.

Rollout-sensitive tasks should include rollout notes and residual risk.
