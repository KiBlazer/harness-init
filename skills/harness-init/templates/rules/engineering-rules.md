# Engineering Rules

## Change discipline

- Make the smallest sufficient change.
- Avoid unrelated refactor, rename, formatting churn, or dependency changes.
- Do not invent missing APIs, classes, tables, configs, or external services.
- Keep changes aligned with existing project layering and ownership.
- Delete confidently unused code instead of adding compatibility shims.

## Cross-layer consistency

When a change affects data contracts, keep all touched surfaces aligned:

- backend model/DTO/entity/mapper/service/controller
- frontend type/form/table/API usage
- SQL/migration/seed data
- scripts/jobs/integration adapters
- tests and verification commands

## Delivery record

For non-trivial work, record:

- request and scope
- affected modules
- decisions and tradeoffs
- verification performed
- skipped verification and why
- residual risk
