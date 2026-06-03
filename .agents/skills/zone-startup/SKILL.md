---
name: zone-startup
description: Initialize a new LLM Zone from a raw corpus
---

## Purpose

Translate a protected Root Vault into a searchable, header-indexed LLM Zone with a shared dictionary, navigation maps, and validated retrieval.

## Prerequisites

- User has run `bash .bin/onboard.sh` (setup draft exists)
- `01_llm_zone/raw/` contains text-like source copies from the Root Vault
- `INFORMATIONS.md` and `ZONE_CONFIGURATION.md` exist (filled by onboard or orchestrator)

## Steps

1. Read `INFORMATIONS.md` and `ZONE_CONFIGURATION.md`. Confirm `setup_status: cli_started` is present.
2. Read `01_llm_zone/01_metadata/HEADER_TEMPLATE.md` for header schema.
3. Survey `raw/` — count files, identify source types, note any binary-only entries.
4. Build the master dictionary in `01_llm_zone/00_dictionary.md`:
   - Extract canonical names, aliases, uncertain terms, machine artifacts from every raw copy.
   - Multilingual: keywords appear in the language found; list all variants as aliases.
5. Generate YAML headers for every raw copy using `HEADER_TEMPLATE.md`.
6. Create navigation maps in `01_llm_zone/maps/`:
   - Each map addresses a distinct retrieval concern (structure, entities, concepts, unresolved items).
   - Use Obsidian wikilinks (`[[raw/...|display]]`) for all file references.
   - Follow `MAP_TEMPLATE.md` for structure.
7. Build concept maps from themes appearing in 3+ raw copies.
8. Update `01_llm_zone/00_zone_index.md` with maps, dictionary, and coverage status.
9. Run validation: grep a dictionary keyword and confirm it reaches a raw copy header/body.
10. Replace `setup_status: cli_started` with `setup_status: zone_started` in `INFORMATIONS.md` and `ZONE_CONFIGURATION.md`.

## Rules

- Root Vault is read-only — never edit, rename, or delete source files.
- Binary files (PDFs, images, audio, video) get `.pointer.md` records in `raw/`, not copied content.
- Dictionary is the source of truth for canonical terms across all headers.
- YAML frontmatter holds retrieval-critical terms; body holds interpretation.
- Machine artifacts are findable noise until verified — never promote without source support.
- Use Obsidian wikilinks for all internal references.

## See also

- `source-intake` — for adding files after initial startup
- `orchestrator-dispatch` — for the routing logic that invokes this workflow
