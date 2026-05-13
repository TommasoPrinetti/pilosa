# Header Template

Every data point (folder map, fragment, index, metadata, note) should have a header block at the top. Use YAML frontmatter in markdown files.

## Standard header fields

```yaml
---
id: [unique identifier]
type: [folder_map | concept_index | evidence_fragment | metadata | backsearch_protocol | research_need | mailbox_note | agent_report]
source: /root_vault/folder_NNN/[subfolder]/[file]
evidence_type: [primary | processed | interpretive]
evidence_level: [L1 | L2]
confidence: [high | medium | low]
tags: [tag1, tag2, tag3]
created: [date]
updated: [date]
agent: [Cicero | Varro | Lucrezio | Tacito]
---
```

## Example
```yaml
---
id: frag_004_003
type: evidence_fragment
source: /root_vault/folder_004/transcription_003.md
evidence_type: primary
evidence_level: L1
confidence: high
tags: [speed, quality, repair]
created: 2025-05-13
updated: 2025-05-13
agent: Cicero
---
```

## Rules
- All Cicero-produced files MUST include a header with all fields
- All other agents SHOULD include a header with at minimum: `type`, `evidence_type`, `evidence_level`, `agent`, `created`, `updated`
- **`.now` rule** — `created` is set once at file creation. `updated` is set to the current date on every edit. Both use the system date at the moment of writing.
- `tags` is the primary mechanism for lightweight re-indexing.
