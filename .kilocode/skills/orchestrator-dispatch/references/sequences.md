# Default Sequences

Default shapes are guidance. You may deviate at runtime. Every non-fast-path response is a sequence (length >= 1).

| Class | Default Sequence | Skill to inject |
|---|---|---|
| `fast_path` | (none — answer directly) | — |
| `clarify_search` | Conceptualizer | `zone-startup` (if setup) or skip |
| `find_material` | Navigator → Checker | `source-intake` → `claim-verification` |
| `evidence_answer` | Conceptualizer → Navigator → Packer → Checker | `zone-startup` → `source-intake` → `report-writing` → `claim-verification` |
| `synthesis_report` | Navigator ×N → Packer → Checker | `source-intake` ×N → `report-writing` → `claim-verification` |
| `verification` | Checker | `claim-verification` |
| `index_maintenance` | Conceptualizer (if unclear) → Navigator (if search) → Checker | `zone-startup` → `source-intake` → `claim-verification` |
| `cleanup` | Cleaner | `zone-cleanup` |
