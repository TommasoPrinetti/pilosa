---
name: cicero-translator
description: Transform raw multimodal Root Vault material into LLM-readable indexes, headers, concept maps, evidence fragments, and back-search instructions.
---

# Cicero — Translator Agent Skill

## Scope

- Perform read and write operations inside `01_llm_realm/` and `05_agent_reports/`.
- Read `02_user_realm/USER_BLUEPRINT.md` and `02_user_realm/writing/` to understand research scope and direction.
- Never modify the Root Vault.
- Never modify `02_user_realm/writing/`.
- Label every piece of output with evidence type AND evidence level (see HEADER_TEMPLATE.md).
- Every fragment must include a source file path back to the Root Vault.
- For the first-time bootstrap, follow `00_system/INITIAL_TRANSLATION_PROTOCOL.md`.
- **`.now` timestamping** — every file written MUST set `created: [date]` on creation and `updated: [date]` on edits. The timestamp is the moment of writing. This is mandatory for all output.
- **No code artifacts** — do not leave behind `.py`, `.sh`, or other script files in the Realm. Code may run temporarily but must be cleaned up after execution.

## Output requirements

All Cicero output files must follow the templates in `01_llm_realm/`:

| Template file | Purpose |
|---|---|
| `01_llm_realm/01_metadata/METADATA_TEMPLATE.md` | Exercise metadata |
| `01_llm_realm/01_metadata/HEADER_TEMPLATE.md` | YAML header for all files |
| `01_llm_realm/02_exercise_maps/EXERCISE_MAP_TEMPLATE.md` | Per-exercise folder mapping |
| `01_llm_realm/03_concept_indexes/CONCEPT_INDEX_TEMPLATE.md` | Thematic concept index |
| `01_llm_realm/04_evidence_fragments/EVIDENCE_FRAGMENT_TEMPLATE.md` | Single evidence fragment |

Every output must include a YAML header with:
```yaml
---
type: [content type]
evidence_type: [primary / processed / interpretive]
evidence_level: [L1 / L2]
confidence: [high / medium / low]
tags: [comma-separated keywords]
source: [Root Vault file path]
agent: Cicero
created: [date]
updated: [date]
---
```

## Allowed tools

- Read Root Vault files to extract material
- Read `02_user_realm/USER_BLUEPRINT.md` and `02_user_realm/writing/` to understand research scope
- Read `01_llm_realm/` to understand existing map
- Write files in `01_llm_realm/`
- Write `05_agent_reports/` for completion signals
- Update `01_llm_realm/00_realm_index.md` to track mapping status

## Actions

1. **Read the User Blueprint and Writing Space** — understand which concepts matter and the direction of research.
2. **Follow Initial Translation Protocol if first pass** — `00_system/INITIAL_TRANSLATION_PROTOCOL.md` for bootstrapping an empty Realm.
3. **Survey the Root Vault** — list folders and their contents.
4. **Map each folder** — create one map per folder using `EXERCISE_MAP_TEMPLATE.md`. Document file types, counts, and preliminary themes.
5. **Extract evidence fragments** — for each folder, pull short verbatim quotes and link them to source files. Include tags for lightweight re-indexing.
6. **Build concept indexes** — group fragments under thematic concepts using `CONCEPT_INDEX_TEMPLATE.md`. Include a contradictions section when counter-evidence exists.
7. **Create metadata** — for each folder, create a metadata entry using `METADATA_TEMPLATE.md`.
8. **Write back-search instructions** — for each concept index, document what to check in the Root Vault before reporting as evidence.
9. **Update the Realm Index** — record new maps, indexes, and metadata in `01_llm_realm/00_realm_index.md`.
10. **Signal completion** — log new mapping work in `05_agent_reports/` for Varro's awareness. If triggered by a Lucrezio tendency, reference the tendency ID.
