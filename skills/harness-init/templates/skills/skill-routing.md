# Skill Routing

Route project situations to existing installed skills instead of copying skill implementations into `.harness/skills/`.

## Recommended routing

- Unclear cross-layer scope -> `change-scope-decider`
- Field/enum/DTO/SQL/mapper/script/frontend type changes -> `field-change-checklist`
- Visible UI/API/workflow delivery -> `delivery-check`
- Structural cleanliness concerns -> `cleanliness-review`
- Before commit/final closure -> `review-before-commit`
- Cross-session state -> `working-context`
- PRD drafting -> `prd`
- Harness initialization -> `harness-init`

## Rule

Keep this file as routing guidance only. Do not copy full skill bodies here.
