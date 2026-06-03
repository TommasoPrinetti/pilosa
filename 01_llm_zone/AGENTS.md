# 01_llm_zone — Indexed Research Corpus

Active working directory for all source-grounded work: raw copies, dictionary, navigation maps, headers, and the master index.

## Sub-agent ownership

- **Navigator** owns search, indexing, map creation, and raw copy intake.
- **Checker** must verify dictionary updates, map changes, and header corrections.
- **Packer** may reference raw/ content as evidence in reports.
- **Cleaner** never modifies files here; may propose map or dictionary archival.

## Operations

- `raw/` files are **protected source copies** — body content is read-only during normal operations. YAML header metadata may be updated when the dictionary or navigation maps change.
- **Dictionary edits**: always invoke Checker after any addition, removal, or alias change. The dictionary is the source of truth for canonical terms across all raw copy headers.
- **New maps**: follow `MAP_TEMPLATE.md` for structure and `HEADER_TEMPLATE.md` for frontmatter. Use Obsidian wikilinks (`[[raw/...|display]]`) for all file references.
- **Zone index**: keep in sync with `maps/` and `00_dictionary.md`. Rebuild after batch changes.
- Root Vault is the immutable original — `raw/` is the active working copy.

## Conventions

- Dictionary entries use canonical forms with aliases for grep-friendliness.
- Raw copy headers match `HEADER_TEMPLATE.md` schema.
- Navigation maps use free-text `role` field (no enum; describe the retrieval concern).
- This directory is created and initially populated by the startup workflow ([[STARTUP]]). Subsequent maintenance is done by Navigator + Checker.

## See also

- [[AGENTS]] — orchestrator playbook (dispatch rules)
- [[STARTUP]] — how the zone is first created
- [[00_dictionary]] — canonical vocabulary
- [[01_metadata/HEADER_TEMPLATE]] — header schema
- [[MAP_TEMPLATE]] — map structure guide
