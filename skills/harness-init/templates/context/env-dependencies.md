# Environment Dependencies

Document external dependencies that affect local/dev/test/prod verification.

## Database

TODO: tables, migrations, seed data, sharding/partitioning assumptions.

## Cache

TODO: Redis/cache prefix, compatibility, cleanup rules.

## Messaging

TODO: broker hosts by environment, exchanges, queues, routing keys, DLQ behavior.

## Jobs and schedulers

TODO: scheduler ownership, lock requirements, multi-node behavior.

## External APIs

TODO: endpoints, credentials handling, rate limits, sandbox vs production.

## Config and rollout

TODO: config profiles, config-center keys, deployment prerequisites.

## Secret rule

Do not store secrets in `.harness/`.
