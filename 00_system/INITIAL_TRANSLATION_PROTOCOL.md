# Initial Translation Protocol — Cicero Bootstrap Pass

## Purpose
This is the first pass that bootstraps the LLM Realm from a fresh Root Vault. Follow this protocol step by step when the Realm is empty and the Root Vault contains raw data folders.

## Prerequisites
- Root Vault exists with at least one folder of raw material
- User Blueprint has been created (`02_user_realm/USER_BLUEPRINT.md`)
- `01_llm_realm/00_realm_index.md` exists (even if empty)

## Bootstrap order

### Phase 1: Survey
1. List all folders in the Root Vault
2. For each folder, note which modalities are present (photos, scans, OCR markdowns, audio, transcriptions, video, researcher notes)
3. Record the survey in `01_llm_realm/00_realm_index.md` under "Mapping status"

### Phase 2: Map each folder
4. For each Root Vault folder, create a map using `02_exercise_maps/EXERCISE_MAP_TEMPLATE.md`
5. Document: file types, counts, key themes, notable fragments

### Phase 3: Extract fragments
6. For each folder, read all machine-readable files (markdown OCR, transcriptions, researcher notes)
7. Extract short verbatim quotes that seem relevant to the User Blueprint
8. Create one fragment file per quote using `04_evidence_fragments/EVIDENCE_FRAGMENT_TEMPLATE.md`

### Phase 4: Build concept indexes
9. Group fragments by thematic concept
10. Create one concept index per concept using `03_concept_indexes/CONCEPT_INDEX_TEMPLATE.md`
11. Link each fragment to its concept index

### Phase 5: Create metadata
12. For each Root Vault folder, create a metadata entry using `01_metadata/METADATA_TEMPLATE.md`
13. Record: participant IDs, dates, modalities present, transcription confidence, file provenance

### Phase 6: Finalize
14. Update `00_realm_index.md` with all new maps, indexes, and metadata
15. Write a completion report to `05_agent_reports/`

## Verification checklist
- [ ] Every Root Vault folder has a map
- [ ] Every map links to at least one concept index
- [ ] Every fragment has a source path back to Root Vault
- [ ] Every concept index has back-search instructions
- [ ] Metadata exists for each folder
- [ ] Realm Index tracks all of the above

## Notes
- The initial pass creates the "almost static" map. Fragments will evolve later.
- Do not skip metadata — it is what makes the Realm queryable beyond keyword search.
- If a folder has no machine-readable content yet, flag it in the map but do not block.
