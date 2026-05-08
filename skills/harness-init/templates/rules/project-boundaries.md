# Project Boundaries

Use this file to encode project-specific architecture gates.

## TODO: module ownership

Document which modules own:

- HTTP/API entrypoints
- domain services
- data access
- background workers
- scheduled jobs
- message consumers/producers
- shared libraries
- UI surfaces

## TODO: forbidden dependencies

Document dependencies that must not be introduced, such as runtime modules depending on admin modules or UI code depending on internal-only APIs.

## TODO: runtime boundaries

Document environment-specific runtime rules:

- cache prefixes
- message queue instances
- scheduler ownership
- config profiles
- deployment entrypoints

## Boundary rule

When a change crosses a boundary, stop and make the boundary decision explicit before implementation.
