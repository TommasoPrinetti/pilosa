---
type: backsearch_protocol
agent: Cicero
created: [date]
updated: [date]
---

# Back-search Protocol

## When to back-search
Before finalizing any answer that depends on a factual claim:
1. Check the Realm indexes for the evidence fragment
2. If the researcher needs precision, return to the Root Vault file linked by the index
3. Read the full surrounding context before reporting

For L2 (serendipitous) clues, back-search is **MANDATORY** before reporting. See the L2 Back-search section below.

## Steps for standard back-search (L1 evidence)

### 1. Identify the target
From the evidence fragment or concept index, find the Root Vault path:
```
/root_vault/folder_NNN/[type]/[file]
```

### 2. Read the source
Read the full source file to verify the quote in context. Pay attention to:
- What came before and after the fragment
- Speaker metadata (participant ID, folder context)
- Researcher annotations if present
- Whether the fragment is a "conceptual hook" (minimal, tagged for discovery) or a fully verified claim

### 3. Assess confidence
| Confidence | Criteria |
|---|---|
| High | Direct verbatim quote, clear context, single interpretation |
| Medium | Paraphrase, partial context, or multiple possible readings |
| Low | Fragment is suggestive but ambiguous — flag for researcher review |

### 4. Report
Return the verified evidence with:
- The full verified quote
- Source path
- Confidence
- Any contextual nuance discovered during back-search
- Evidence type (primary / processed / interpretive) and evidence level (L1 / L2)

## L2 Back-search (serendipitous evidence)

### When to use
For any L2 (serendipitous) clue found through metaphor mapping, cross-modal adjacency, weak signal accumulation, negative space search, or marginalia analysis (see `SERENDIPITY_PROTOCOL.md`).

### Mandatory steps
1. **Verify the source** — read the full Root Vault file to confirm the fragment exists in context
2. **Check adjacent modalities** — if the clue came from audio transcription, check scans and researcher notes from the same folder
3. **Assess accumulation** — how many fragments support this clue?
4. **Reassess confidence** — after back-search, update confidence:
   - If the clue survives verification: keep as L2
   - If the clue survives AND is confirmed by 2+ modalities: may upgrade to L1 (note the upgrade)
   - If the clue is not found in context: discard or flag as error
5. **Note back-search status** — report: `Back-search status: [pending / partial / verified]`

### L2 reporting
Every L2 back-search result must include:
```
## Back-search status: [pending / partial / verified]
## Verification notes: [what was checked, what was found]
## Confidence after back-search: [low / medium / high]
## Upgrade to L1?: [yes / no — if yes, why]
```

### Conceptual hooks
Fragments marked as "conceptual hooks" (minimal pointers meant to trigger discovery, not full evidence) require:
- **Less aggressive back-search** for initial discovery
- **More aggressive back-search** before reporting as L1 evidence

## Special cases
- **Cross-modal back-search**: If the fragment came from audio transcription, consider also checking the original audio file and any researcher notes for the same folder.
- **Contradiction check**: When back-searching for supporting evidence, actively look for counter-examples in adjacent files. Record contradictions in the concept index's Contradictions section.
- **Weak signal**: If the source is handwritten, scanned, or OCR-generated, flag potential transcription errors.
