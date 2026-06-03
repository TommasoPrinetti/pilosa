---
type: dictionary
role: shared_vocabulary
purpose: [ensure coherent terminology across raw copy headers]
scope: [all raw copies in 01_llm_zone/raw/]
created: YYYY-MM-DD
updated: YYYY-MM-DD
---

# Master Dictionary

The dictionary is built during startup by reading all text-based source files. It ensures that every raw copy header uses the same canonical terms. The orchestrator agent consults this file when generating or updating YAML headers.

**Multilingual rule:** Keywords appear in the language they were found in. If a source is in French, French keywords are recorded. If a concept appears in multiple languages, list all language variants as aliases so grep finds any form.

**Noise quarantine rule:** ASR labels, diarization labels, OCR noise, conversion residue, timestamps, and obvious transcription artifacts are findable but not canonical. Put them in `Machine Artifacts` or `Uncertain Terms` until Checker or source context verifies them.

## Canonical Names

Standard form for people, roles, or named entities. Aliases map to one canonical name.

| Canonical form | Language | Aliases | Source files |
|---|---|---|---|
| — | — | — | — |

## Canonical Places

Standard form for geographic locations, sites, or regions.

| Canonical form | Language | Aliases | Source files |
|---|---|---|---|
| — | — | — | — |

## Canonical Organizations

Standard form for institutions, groups, or agencies.

| Canonical form | Language | Aliases | Source files |
|---|---|---|---|
| — | — | — | — |

## Canonical Concepts

Standard form for domain-specific concepts, theories, or frameworks. These map to concept map entries.

| Canonical form | Language | Aliases | Source files |
|---|---|---|---|
| — | — | — | — |

## Explicit Source Terms

Terms visibly present in sources. These may support canonical concepts but are not automatically promoted to them.

| Source term | Language | Related canonical form | Source files |
|---|---|---|---|
| — | — | — | — |

## Inferred Concepts

Concept labels inferred from multiple source terms. Keep these separate from explicit source terms and mark weak support as `needs_review`.

| Inferred concept | Evidence terms | Confidence | Source files |
|---|---|---|---|
| — | — | — | — |

## Uncertain Terms

Potential people, places, organizations, concepts, dates, or aliases that need review.

| Term | Uncertainty | Candidate category | Source files |
|---|---|---|---|
| — | — | — | — |

## Machine Artifacts

Noisy retrieval terms from ASR, diarization, OCR, conversion, timestamps, or file-system artifacts. These are not canonical dictionary entries.

| Artifact | Artifact type | Handling rule | Source files |
|---|---|---|---|
| SPEAKER_00 | diarization_label | keep findable; do not treat as a person without verification | — |
| 00:12:04 | timestamp | keep findable only when useful for media alignment | — |
| l1l / O0 / broken glyphs | ocr_noise | record only if it affects retrieval or repair | — |

## Domain Terms

Specialized vocabulary, acronyms, or jargon used in the sources.

| Term | Language | Definition | Source files |
|---|---|---|---|
| — | — | — | — |

## Update Procedure

1. During startup, read every text-based source file
2. Extract names, places, organizations, explicit source terms, inferred concepts, domain terms, uncertain terms, and machine artifacts
3. Record the language of each term
4. Deduplicate: merge variants into canonical forms
5. Add aliases in all detected languages so that grep finds any variant
6. Quarantine machine artifacts and uncertain metadata instead of promoting them to canonical fields
7. Record which source files use each term
8. When new sources are added, update the dictionary before generating headers
