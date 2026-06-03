---
type: informations
agent: setup_cli
role: project_scope
purpose: [define the research project scope, questions, corpus, evidence standards, and direction]
scope: [entire research project]
connects_to:
  - AGENTS.md
  - 00_system/instructions/ZONE_CONFIGURATION.md
  - 00_system/instructions/STARTUP.md
  - 03_logs/user_requests.md
created: YYYY-MM-DD
updated: YYYY-MM-DD
setup_status: not_started
---

# INFORMATIONS

## Project
- Title: [project name]
- Description: not provided during fast setup; infer from the raw corpus during startup

## Project Artifacts
- none provided during fast setup

## Sources
- Root Vault path: [path]
- Main source types: [inferred during startup from the Root Vault]
- Expected incoming sources: [inferred during startup]

## Research Vocabulary
- Key actors / institutions / places: [inferred during startup]
- Key concepts: [inferred during startup]
- Sensitizing concepts, not evidence: [inferred during startup]
- Theoretical frames, not forced labels: [inferred during startup]

## Method And Evidence
- Methods: [inferred during startup]
- Claims require source paths.
- L2 clues require Checker verification before reporting.
- External sources must stay labeled external unless moved into the Root Vault.
- External source policy: no (default; ask only if external access is needed)

## Outputs
- Start with central maps in 01_llm_zone/maps/ and evidence-grounded answers unless the researcher requests another output.

## Blind Spots
- [identified during startup]

## Researcher Preferences
[stated or inferred during startup]

- CLI: [inferred or provided during setup]

## Notes
- Editable during initial setup only.
