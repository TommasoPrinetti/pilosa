---
type: map_template
role: map_structure_guide
purpose: [guide agents in writing the seven central navigation maps]
scope: 01_llm_zone/maps/
connects_to:
  - 01_llm_zone/01_metadata/HEADER_TEMPLATE.md
  - 00_system/instructions/STARTUP.md
created: 2026-06-03
updated: 2026-06-03
---

# Map Template

Every map file in `01_llm_zone/maps/` must include the navigation_map header and use Obsidian wikilinks for all internal references.

## Header Schema

```yaml
---
type: navigation_map
role: [descriptive role, e.g. folder_map, concept_map, entity_map]
purpose: [guide future LLM retrieval into the raw corpus]
scope: 01_llm_zone/raw/
connects_to:
  - 01_llm_zone/raw/
  - 01_llm_zone/00_dictionary.md
  - 01_llm_zone/maps/00_map_overview.md
map_quality: machine_generated | checked | human_reviewed
description_depth: retrieval_oriented
wikilink_policy: obsidian_wikilinks_required
generated_by: startup_agent
generated_at: YYYY-MM-DD
processing_status: machine_generated | checked | human_reviewed
created: YYYY-MM-DD
updated: YYYY-MM-DD
---
```

## Wikilink Rules

- Every raw copy or pointer record reference must use an Obsidian wikilink: `[[raw/interviews/interview_01__txt|interview_01.txt]]`
- Every map-to-map reference must use a wikilink: `[[folder_map]]`
- Only absolute Root Vault source paths in provenance lines use bare paths.

## Entry Guidance

Each map entry for a raw copy or pointer record should include:

- wikilink to the copy or record,
- original Root Vault source path when available,
- retrieval summary (3–6 sentences for normal files, 2–4 paragraphs for large/dense files),
- key topics, entities, and concepts present,
- useful search terms,
- metadata caveats,
- map quality / review status.
