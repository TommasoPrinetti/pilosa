# Evidence Fragment Template

Store one fragment per entry. Multiple fragments for the same concept are collected in the concept index.

```
---
type: evidence_fragment
evidence_type: [primary / processed / interpretive]
evidence_level: [L1 / L2]
confidence: [high / medium / low]
tags: [tag1, tag2, tag3]
source: /root_vault/folder_NNN/[subfolder]/[file]
agent: Cicero
created: [date]
updated: [date]
---

## Fragment
[short verbatim quote or precise paraphrase]

## Source
/root_vault/folder_NNN/[subfolder]/[file]

## Context
[1-2 sentences of surrounding context, enough to interpret]

## Evidence type
[primary / processed / interpretive]

## Evidence level
[L1 / L2]

## Tags
[tag1, tag2, tag3]

## Confidence
[high / medium / low]

## Linked concept
[concept index this belongs to]

## Back-search status
[pending / partial / verified — if L2, must be verified before reporting]
```
