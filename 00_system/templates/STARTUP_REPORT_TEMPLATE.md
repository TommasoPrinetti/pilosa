---
type: startup_report_template
role: startup_output_template
purpose: [guide the final setup report after the Zone is started]
scope: [startup completion only]
connects_to:
  - 00_system/instructions/STARTUP.md
  - 05_agent_reports/
created: 2026-05-26
updated: 2026-06-02
---

# Startup Report Template

Use this structure for the final response after `Read AGENTS.md and start the Zone`.

## Outcome
[One or two sentences: setup translated, Root Vault verified, raw copies created, dictionary built, headers and folder indexes generated.]

## Startup Checklist
- [done / blocked] Setup draft inspected
- [done / blocked] Root Vault verified
- [done / blocked] Blueprint/config translated
- [done / blocked] Translation audit completed
- [done / blocked] Raw copies created in [[raw/]]
- [done / blocked] Master dictionary built in [[dictionary]]
- [done / blocked] YAML headers generated for all raw copies
- [done / blocked] Folder index.md files generated under [[raw/]]
- [done / blocked] Concept indexes created from repeated themes
- [done / blocked] Zone index updated
- [done / blocked] Smoke test completed

## Changes
- [file changed or created]

## Validation
- [path checks, placeholder scans, raw copy coverage, dictionary size, grep/Checker smoke test, external policy decision]

## Unresolved Items
- [non-blocking ambiguities, missing metadata, unsupported files, or `none`]

## Next Steps
Offer 3 to 5 concrete next actions. Prefer actions grounded in the mapped Root Vault:
- answer a source-grounded research question using [specific raw copy],
- build a concept index for [recurring theme],
- deepen the dictionary with more detailed entity extraction,
- run a Checker verification pass on raw copy headers,
- add more sources to the Root Vault and re-run intake.
