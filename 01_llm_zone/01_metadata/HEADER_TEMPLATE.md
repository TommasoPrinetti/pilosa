---
type: metadata_header_template
role: header_schema_guide
purpose: [define the canonical YAML header fields used across the framework]
scope: [all framework markdown files]
connects_to:
  - AGENTS.md
  - 01_llm_zone/00_zone_index.md
  - 01_llm_zone/00_dictionary.md
status: active
created: 2026-05-26
updated: 2026-06-02
---

# Header Template

Use a small, stable header on every framework file. The goal is to let an agent identify the file, understand its role, and know which files it connects to without reading the body first.

## Base Header

```yaml
---
type: [file_type]
role: [what this file does in the framework]
purpose: [one-line function of the file]
scope: [where this file applies]
connects_to:
  - [path]
  - [path]
status: active | draft | template | archived
evidence_type: primary | processed | interpretive | external
evidence_level: L1 | L2
created: YYYY-MM-DD
updated: YYYY-MM-DD
---
```

Use the fields needed for the file. Do not add empty analytic fields.

## Raw Copy Header

Required for every file in [[raw/]]. The dictionary is the source of truth for canonical terms.

```yaml
---
type: raw_copy
source: "/absolute/path/to/root_vault/[relative-path]/[filename]"
source_type: interview | fieldnote | article | report | dataset | correspondence | researcher_note
text_type: md | txt | rtf | csv | json | yaml | ...
language: en | fr | pt | es | ...
date: "YYYY-MM-DD or YYYY-MM-DD"
people: ["canonical name from dictionary"]
places: ["canonical place from dictionary"]
organizations: ["canonical org from dictionary"]
topics: ["topic1", "topic2"]
keywords: ["keyword1", "keyword2", "keyword3"]
concepts: ["[[Concept Name]]"]
explicit_source_terms: ["surface term from source"]
inferred_concepts: ["inferred concept label"]
canonical_aliases: ["alias from dictionary"]
uncertain_terms: ["term needing review"]
machine_artifacts: ["SPEAKER_00", "ocr_noise"]
metadata_uncertainty: ["date_missing", "identity_ambiguous"]
related_sources: ["other_file.md"]
generated_by: startup_agent
generated_at: YYYY-MM-DD
processing_status: copied_text_headered
created: YYYY-MM-DD
updated: YYYY-MM-DD
---
```

Rules:
- `language` is the ISO 639-1 code of the source file's primary language (en, fr, pt, es, etc.).
- `people`, `places`, `organizations` MUST use canonical forms from [[dictionary]].
- `keywords` include both canonical terms and aliases in the source's language (so grep finds any variant).
- `concepts` link to relevant concept entries in the navigation maps.
- `explicit_source_terms` are terms visibly present in the source.
- `inferred_concepts` are derived labels and must stay separate from explicit source terms.
- `canonical_aliases` lists dictionary aliases included for retrieval.
- `uncertain_terms`, `machine_artifacts`, and `metadata_uncertainty` quarantine noisy or incomplete metadata.
- `related_sources` lists other raw copies with shared topics or concepts.
- `generated_by`, `generated_at`, and `processing_status` preserve provenance for generated headers.
- Omit fields that have no value — do not write `people: []`.

## Source Pointer Header

Required for every pointer-only record created for non-text Root Vault files. Pointer records make media retrievable without copying, editing, or interpreting the original file.

```yaml
---
type: source_pointer
role: pointer_only_source_record
purpose: [make a non-text Root Vault source findable without copying the original media]
scope: single_source_file
source: "/absolute/path/to/root_vault/[relative-path]/[filename]"
root_rel_path: "[relative-path]/[filename]"
media_type: image | video | audio | pdf | unknown
extension: jpg | mp4 | wav | pdf | unknown
size_bytes: 12345
processing_status: pointer_only_pending | processed_text_available | needs_review
ocr_status: pending | not_applicable | complete | failed
asr_status: pending | not_applicable | complete | failed
transcription_status: pending | not_applicable | complete | failed
image_analysis_status: pending | not_applicable | complete | failed
generated_by: onboarding_cli
generated_at: YYYY-MM-DD
created: YYYY-MM-DD
updated: YYYY-MM-DD
---
```

Rules:
- `source` must point to the original Root Vault file.
- `root_rel_path` preserves the source folder structure for grep and repair.
- OCR, ASR, transcription, and image analysis statuses stay `pending` unless a later processing pass actually creates evidence.
- Pointer records are retrieval metadata, not source interpretation.

## Navigation Map Header

Required for every generated map file under `01_llm_zone/maps/`.

```yaml
---
type: navigation_map
role: [descriptive role, e.g. folder_map, concept_map, entity_map]
purpose: [guide future LLM retrieval into the raw corpus]
scope: 01_llm_zone/raw/
connects_to:
  - 01_llm_zone/raw/
  - 01_llm_zone/00_dictionary.md
map_quality: machine_generated | checked | human_reviewed
description_depth: retrieval_oriented
wikilink_policy: obsidian_wikilinks_required
generated_by: startup_agent
generated_at: YYYY-MM-DD
processing_status: machine_generated | checked | human_reviewed
created: YYYY-MM-DD
updated: YYYY-MM-DD
---
```

Map files must use Obsidian wikilinks for internal references:
- `[[raw/interviews/interview_01__txt|interview_01.txt]]`
- `[[raw/photos/photo_01__jpg.pointer|photo_01.jpg pointer]]`
- `[[concept_map]]`

Map entries must be retrieval-oriented. For normal files, include a 3-6 sentence retrieval summary plus topics, entities, concepts, search terms, and caveats. For large or dense files, use 2-4 short paragraphs and an internal-structure table so future LLMs can choose search targets without opening every file.

Legacy note: older projects may contain `raw/**/index.md` files with `type: raw_folder_index`. Leave them in place for compatibility, but new Startup runs should create central `navigation_map` files in `01_llm_zone/maps/`.

## Header For Evidence-Bearing Files

```yaml
source: /root_vault/source_batch_NNN/[subfolder]/[file]
role: evidence_surface
purpose: [point to the source material this file summarizes]
scope: [single file or small source cluster]
connects_to:
  - [[zone_index]]
  - [[source_intake_log]]
  - [[05_agent_reports/]]
source_types: [interview, fieldnote, dataset]
evidence_type: [primary | processed | interpretive | external]
evidence_level: [L1 | L2]
confidence: [high | medium | low]
tags: [tag1, tag2]
```

## Header For Coded Fragments Or Indexes

```yaml
codes:
  - [descriptive code]
concepts:
  - "[[Concept Name]]"
role: coded_retrieval_surface
purpose: [cluster recurring ideas for fast retrieval]
scope: [one concept family]
category: "[[Category Name]]"
coding_status: uncoded | open_coded | focused_coded | categorized
```

## Add Only When Relevant

```yaml
negative_case_status: none_found | partial | present | needs_search
constant_comparison:
  similar_fragments:
    - "[[Fragment]]"
  contrasting_fragments:
    - "[[Fragment]]"
  comparison_status: not_compared | partial | compared
sensitizing_concepts:
  - [attention guide, not evidence]
theoretical_frames:
  - [frame to consider later]
relation_to_query: direct | adjacent | oppositional | speculative
checker_required: true | false
metadata_uncertainty:
  - date_missing
  - identity_ambiguous
uncertain_terms:
  - [term needing review]
machine_artifacts:
  - [ASR, diarization, OCR, or conversion noise]
```
## Wikilink Conventions

In body text, use Obsidian wikilinks for all internal references. Apply these rules:

- Files with unique basenames use just the basename: `[[AGENTS]]`, `[[STARTUP]]`, `[[ZONE_CONFIGURATION]]`, `[[HEADER_TEMPLATE]]`, `[[INFORMATIONS]]`, `[[dictionary]]`, `[[zone_index]]`
- Folders keep their full vault-relative path with trailing `/`: `[[00_system/]]`, `[[01_llm_zone/]]`, `[[03_logs/]]`, `[[05_agent_reports/]]`, `[[.trash/]]`, `[[raw/]]`
- `.md` extension is implicit (Obsidian convention)

**Frontmatter exception:** `connects_to:` and other YAML keys use **bare paths** (not wikilinks). This keeps the metadata machine-readable, grep-friendly, and stable for sub-agents to parse. Wikilink aliasing in YAML is fragile.

**Bare paths shown in code (`backticks`)** are acceptable for illustrative patterns like `.agents/skills/*/SKILL.md` (wildcard) or `.agents/skills/<name>/SKILL.md` (placeholder). These describe a pattern, not a specific file.

## Rule

Frontmatter is for routing and retrieval. The body is for interpretation, comparison, and context.

For fast grep:
- use lowercase snake_case field names,
- keep retrieval arrays short,
- prefer stable nouns over prose,
- include `source`, `root_rel_path`, `generated_by`, `generated_at`, and `processing_status` when the file points back to Root Vault structure or is generated by the framework,
- omit fields that do not help retrieval.

Validation before `zone_started`:
- required YAML fields must be present for the file type,
- `source` paths must exist when they point to Root Vault or raw files,
- array fields must be YAML arrays,
- generated files must include `generated_by`, `generated_at`, and `processing_status`,
- navigation maps must use Obsidian wikilinks for internal file references,
- machine artifacts must not appear in canonical entity fields unless verified.

## Common Source Types
Use short lowercase values in `source_type`.

```yaml
source_types: [interview, fieldnote, article, policy, report, news, web_capture, legal, dataset, image, scan, audio, video, correspondence, researcher_note, external]
```
