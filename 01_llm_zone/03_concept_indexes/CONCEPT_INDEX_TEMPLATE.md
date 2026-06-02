# Concept Index Template

Use when several raw copies share a concept.

```md
---
type: concept_index
role: concept_retrieval_layer
purpose: [group raw copies that share one recurring idea]
scope: [one concept family]
connects_to:
  - 01_llm_zone/00_zone_index.md
  - 01_llm_zone/raw/
  - 05_agent_reports/
sub_agent: Navigator
created: [date]
updated: [date]
evidence_type: processed
evidence_level: L1
tags: [tag1, tag2]
negative_case_status: none_found | partial | present | needs_search
---

# [[Concept Name]]

## Definition
[short working definition]

## Codes
- [code]

## Category
[[Category]]

## Evidence
| Raw copy | Why it matters | Confidence |
|---|---|---|
| `/raw/[path]/[file]` | [short note] | high / medium / low |

## Negative Cases
| Raw copy | Counter-pattern | Checker status |
|---|---|---|
| `/raw/[path]/[file]` | [what it weakens] | pending / partial / verified |

## Comparison
- Similar: [[concept]]
- Contrasting: [[concept]]
- Code changes: [reinforced / weakened / renamed / split / merged]

## Checker Verification
[what to verify before using this concept in an answer or draft]
```

Omit empty sections only when they do not apply. Do not leave `Negative Cases` blank; use `negative_case_status`.
