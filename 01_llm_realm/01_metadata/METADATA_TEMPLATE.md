# Metadata Template

Create one metadata entry per Root Vault folder.

```
---
type: metadata
evidence_type: processed
evidence_level: L1
agent: Cicero
created: [date]
updated: [date]
---

## Folder: [name]

### Provenance
| Field | Value |
|---|---|
| Root Vault path | /root_vault/folder_NNN/ |
| Date range | [start date] — [end date] |
| Participant IDs | [P01, P02, ...] |
| Researcher | [name] |

### Modalities present
| Type | Count | Format | Transcription confidence |
|---|---|---|---|
| photos | | | N/A |
| scans | | | N/A |
| OCR markdowns | | | high / medium / low |
| audio | | | N/A |
| transcriptions | | | high / medium / low |
| video | | | N/A |
| researcher notes | | | N/A |

### Processing notes
[any notes about quality, missing files, transcription issues, etc.]

### Cicero metadata
| Field | Value |
|---|---|
| Mapped by | Cicero |
| Map file | 02_folder_maps/folder_NNN_map.md |
| Concept indexes | [linked indexes] |
| Fragment count | [number] |
| Last updated | [date] |
```
