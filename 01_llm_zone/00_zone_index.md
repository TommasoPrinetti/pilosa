---
type: zone_index
role: zone_master_index
purpose: [map the whole LLM Zone and point to the main retrieval layers]
scope: [all of 01_llm_zone]
connects_to:
  - 00_dictionary.md
  - 01_metadata/HEADER_TEMPLATE.md
evidence_type: processed
evidence_level: L1
created: YYYY-MM-DD
updated: YYYY-MM-DD
---

# LLM Zone — Master Index

## Structure

```
01_llm_zone/
  00_zone_index.md              This file
  00_dictionary.md               Shared term vocabulary for coherent headers
  maps/                          Central navigation maps with Obsidian wikilinks into raw/
   raw/                           Active working corpus: text-like raw copies and source pointer records
   01_metadata/                   Shared header guidance
   maps/MAP_TEMPLATE.md           Structure guide for navigation maps
```

## Central Maps

Startup creates navigation maps under `01_llm_zone/maps/` to cover all files in [[raw/]]. The set of maps is determined by the corpus; see [[maps/MAP_TEMPLATE]] for structure guidance.

## Source Coverage

| Source type | Count | Last updated |
|---|---|---|
| — | 0 | — |

## Pointer Record Coverage

| Media type | Pointer records | Processing status |
|---|---:|---|
| image | 0 | pointer_only_pending |
| video | 0 | pointer_only_pending |
| audio | 0 | pointer_only_pending |
| pdf | 0 | pointer_only_pending |
| unknown | 0 | pointer_only_pending |

## Dictionary Status

| Category | Count | Last updated |
|---|---|---|
| Canonical names | 0 | — |
| Canonical places | 0 | — |
| Canonical organizations | 0 | — |
| Canonical concepts | 0 | — |
| Domain terms | 0 | — |

## Active Concept Maps

Concept maps are stored in [[maps/]] alongside other navigation maps.

| Concept | Raw copies | Tags | Map quality | Last updated |
|---|---|---|---|---|
| — | — | — | — | — |

## Non-Text Files in Root Vault

Files that cannot be copied (PDFs, images, audio, video) are noted here as pointer-only.

| File type | Count | Notes |
|---|---|---|
| — | 0 | — |

## Source Intake

See `03_logs/source_intake_log.md` for new Root Vault batches and retained external sources.

## Vault Overview

- Total raw copies: 0
- Total non-text files (pointer-only): 0
- Dictionary status: not built
- Mapping status: not started
