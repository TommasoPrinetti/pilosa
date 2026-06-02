---
type: startup_protocol
role: setup_and_indexing_protocol
purpose: [translate the protected Root Vault into a searchable, header-indexed LLM Zone]
scope: [initial setup only]
connects_to:
  - 00_system/instructions/ZONE_CONFIGURATION.md
  - 02_user_zone/RESEARCH_BLUEPRINT.md
  - 01_llm_zone/00_zone_index.md
  - 01_llm_zone/01_metadata/HEADER_TEMPLATE.md
  - 00_system/sub_agents/startup/SOUL.md
created: 2026-05-28
updated: 2026-06-02
---

# STARTUP.md — Setup Translation and Indexing Protocol

This is the **protocol document** that defines what to do and how to do it. The **Startup sub-agent** reads this file and executes the steps.

Use this file when the user asks to **start the Zone** or when setup files still contain placeholders.

## Mission

Translate the protected Root Vault into the first usable **LLM Zone**: a searchable, header-indexed collection of raw copies with a shared dictionary for consistent terminology.

The CLI onboarding script has already transposed accepted text-based files from the Root Vault into markdown raw copies under [[raw/]]. The Startup sub-agent's job is to:

1. **Build the master dictionary**
2. **Generate YAML headers** for every raw copy
3. **Create folder `index.md` files** for every raw folder
4. **Build concept indexes** from repeated themes
5. **Update the master index**
6. **Run the smoke test**

The protocol runs in two phases: **Phase 1 (Setup Translation)** and **Phase 2 (Indexing)**. The CLI handles file transposition; the Startup sub-agent handles translation and indexing.

## Non-Negotiable

- **Never edit, rename, reorganize, or delete Root Vault files.**
- Do not copy binary files (PDFs, images, audio, video) into the Zone — note them in the zone index as **pointer-only**.
- Use the dictionary for consistent terminology across all headers.
- Put retrieval-critical terms in **YAML frontmatter** because fast grep starts there.
- Put interpretation and context in the body.
- Do not re-ask questions the CLI draft already answered.

## Required Startup Inputs

Read:

1. `AGENTS.md`
2. [[ZONE_CONFIGURATION]]
3. [[SYSTEM_ARCHITECTURE_MAP]]
4. [[RESEARCH_BLUEPRINT]]
5. [[HEADER_TEMPLATE]]

If the user already ran `bash .bin/onboard.sh`, treat its answers as the **setup draft** and complete startup without repeating questions unless a required field is missing or a risky assumption blocks indexing.

---

# Phase 1 — Setup Translation

## 1.1 Inspect Setup Draft

Read [[RESEARCH_BLUEPRINT]] and [[ZONE_CONFIGURATION]]. Identify filled fields, placeholders, and missing data.

Create a short todo list with the CLI's todo/task tool if available. **Mandatory** when the tool exists. Minimum todo items:

- inspect setup draft,
- verify Root Vault,
- synthesize blueprint/config,
- build master dictionary,
- generate raw copy headers,
- create raw folder indexes,
- disambiguate with user,
- build concept indexes,
- run retrieval smoke test.

## 1.2 Translate Setup Draft

Treat CLI-generated answers as a **setup draft**, not as questions to repeat. Translate the draft into a usable research configuration:

- preserve the project title and description,
- register helpful artifact URLs or file paths,
- infer a tentative source universe, vocabulary, methods, outputs, and indexing target from the description, artifacts, and Root Vault,
- keep inferred fields explicitly marked as inferred when useful.

Use shell/file tools to confirm the Root Vault path exists and is treated as **read-only**.

If artifact URLs are present, use web/MCP/browser tools **only** when `external_sources_allowed` is set to `yes`. If the policy is `no`, record URLs but do not fetch them.

## 1.3 Fill Blueprint and Configuration

- Fill [[RESEARCH_BLUEPRINT]] (project title, project description, helpful artifact URLs or file paths, Root Vault path, evidence standards, external source policy).
- Fill [[ZONE_CONFIGURATION]] (`root_vault_path`, `root_vault_mode`, `source_policy`, `external_sources_allowed`, `preferred_llm_cli`, `claim_standard`, `l2_policy`).
- Replace `setup_status: cli_started` with `setup_status: zone_started` in both files when translation is complete.

## 1.4 Audit the Translation

Before moving on, confirm:

- every project detail from the CLI draft is preserved or intentionally summarized,
- every artifact URL or file path is listed,
- every source policy and protected path is reflected in configuration,
- inferred scope, source universe, vocabulary, methods, outputs, and initial indexing target are present where useful,
- anything not translated is listed as deferred with a reason.

## 1.5 Create the Aggregator

If [[RESEARCH_NEED_AGGREGATOR]] does not exist, create it from its template.

## 1.6 Question Gating

Do not ask follow-up questions before Phase 2 unless:

- a required field is absent,
- the Root Vault path cannot be located,
- external URL access needs permission, or
- a risky assumption blocks immediate indexing.

The user's `start the Zone` prompt is already permission to run initial indexing.

---

# Phase 2 — Indexing

## 2.1 Survey Root Vault

List every directory in the Root Vault. For each directory:

1. List all files and subdirectories (skip `.DS_Store`, system files, empty dirs)
2. Note file types present (`.pdf`, `.md`, `.docx`, `.mp4`, `.wav`, `.csv`, `.json`, etc.), count per type, approximate date range
3. Open and read enough files to characterize the folder's content accurately
4. Record: source types, modality, names, dates, topics, keywords, machine-readability, gaps

Separate text-based files (already transposed to markdown raw copies in `raw/`) from binary files (still in Root Vault).

## 2.2 Log Source Intake

Register the source batch in [[source_intake_log]]. If any sources are external, also log them in [[external_queries]]. This creates a traceable record of what was intake and when.

## 2.3 Build Master Dictionary

Read every text-based raw copy in [[raw/]]. Extract:

1. **Names** — people, roles, named entities. Merge variants into canonical forms (e.g., "Alice", "A. Tufano", "Alice Tufano" → canonical: "Alice Tufano"). Record the language of each term.
2. **Places** — geographic locations, sites, regions. Merge variants (e.g., "Pacific", "Pacific Islands", "Oceania" → canonical: "Pacific Islands"). Record the language.
3. **Organizations** — institutions, groups, agencies. Merge abbreviations (e.g., "WWF", "World Wildlife Fund" → canonical: "World Wildlife Fund"). Record the language.
4. **Concepts** — domain-specific ideas, theories, frameworks. Map to concept index entries. Record the language.
5. **Domain terms** — specialized vocabulary, acronyms, jargon. Define each. Record the language.

**Multilingual rule:** Keywords must appear in the language they were found in. If a source is in French, French keywords are recorded. If in English, English keywords. If a concept appears in multiple languages, list all language variants as aliases so grep finds any form.

Example:
```markdown
| Canonical form | Language | Aliases | Source files |
|---|---|---|---|
| adaptation | fr | adapção (pt), adaptation (en) | interview_01.md |
| coral reef | en | récif corallien (fr), recife de coral (pt) | fieldnote_03.md |
```

Write [[dictionary]] with canonical forms, languages, aliases, and source file references. Every term that appears in more than one source file **MUST** have an alias entry so grep finds any variant in any language.

## 2.4 Generate Raw Copy Headers

For every raw copy file in [[raw/]], generate a YAML header using the dictionary. Skip generated folder `index.md` files; they are folder indexes, not raw copies. The raw copy header must contain:

```yaml
---
type: raw_copy
source: "/absolute/path/to/root_vault/[relative-path]/[filename]"
source_type: interview | fieldnote | article | report | dataset | ...
text_type: md | txt | rtf | csv | json | ...
language: en | fr | pt | es | ...
date: "YYYY-MM-DD or YYYY-MM-DD"
people: ["canonical name from dictionary"]
places: ["canonical place from dictionary"]
organizations: ["canonical org from dictionary"]
topics: ["topic1", "topic2"]
keywords: ["keyword1", "keyword2", "keyword3"]
concepts: ["[[Concept Name]]"]
related_sources: ["other_file.md"]
created: "YYYY-MM-DD"
updated: "YYYY-MM-DD"
---
```

Rules:
- Use canonical forms from the dictionary — **never invent new variants**.
- `people`, `places`, `organizations` **MUST** use dictionary canonical names.
- `keywords` should include both canonical terms and common aliases (so grep finds any form).
- `concepts` link to concept index files in `03_concept_indexes/`.
- `related_sources` lists other raw copies that share topics or concepts.
- Omit fields that have no value — do not write `people: []`.

Write the header at the top of each raw copy file. The body (original content) stays **unchanged**.

## 2.5 Create Raw Folder Indexes

For every folder under [[raw/]], including the root `raw/` folder, create or update an `index.md` file. This file is the **canonical structure map** for the raw tree; Navigator reads it before grepping headers.

Each folder `index.md` must include the header schema from [[HEADER_TEMPLATE]] (`type: raw_folder_index`):

```markdown
# Raw Folder Index — [folder path]

## Folder Summary
[2-4 sentences explaining what this folder contains, based only on files in the folder.]

## Child Folders
| Folder | What it appears to contain |
|---|---|

## Files
| Raw copy | Original source | Short content summary | Key topics | Status |
|---|---|---|---|---|
```

Rules:
- Summarize each raw copy in **one concise sentence**.
- Preserve the raw copy path exactly.
- Preserve the original Root Vault source path from the raw copy header when available.
- Mark unreadable, empty, ambiguous, or unsupported files as `unreadable`, `empty`, `ambiguous`, or `needs_review`; do not guess.
- Do not create `index.md` files in the Root Vault.
- Do not treat generated `index.md` files as raw copies.

## 2.6 Disambiguate With The User

This is the moment to **ask questions**. You have now read every source file and built the dictionary. You know what's ambiguous. Use the `question` tool to resolve ambiguities before finalizing headers and concept indexes.

Ask about:

1. **Name collisions** — If "Maria" appears in 3 sources, is it the same Maria? Ask the user to confirm which people are distinct and which are aliases.
2. **Place ambiguity** — If "the village" appears without a name, ask the user which village. If "the coast" could mean multiple locations, disambiguate.
3. **Unclear concepts** — If a domain term has no obvious definition in the sources, ask the user what it means.
4. **Missing metadata** — If a source has no date, no author, or unclear context, ask the user to fill the gap.
5. **Cross-language ambiguity** — If the same concept appears in multiple languages with slightly different meanings, ask which meaning is intended.
6. **Source relationships** — If two sources seem to contradict each other, ask the user whether this is a real disagreement or a misunderstanding.

**Do not guess. Do not assume.** The dictionary and headers are only as good as the disambiguation that feeds them. Ask concisely — group related questions together, keep each question short, and offer concrete options when possible.

If the user cannot answer (e.g., they don't know either), mark the term as `unresolved` in the dictionary and move on.

## 2.7 Build Concept Indexes

Identify concepts that appear across multiple raw copies. For each recurring concept:

1. Create a concept index in [[03_concept_indexes/]] using `CONCEPT_INDEX_TEMPLATE.md`
2. List all raw copies that reference this concept
3. Note similar and contrasting concepts
4. Mark negative cases if present

Use [[dictionary]] to identify concepts that appear in **3+ source files**.

## 2.8 Update Master Index

Update [[zone_index]] with:

- Root Vault path,
- Raw copy coverage (how many files copied, by type),
- Raw folder indexes created,
- Dictionary status (canonical names, places, organizations, concepts),
- Concept indexes created,
- Non-text files noted as pointer-only,
- Known gaps.

## 2.9 Smoke Test

Before reporting startup complete, run **one retrieval smoke test**:

1. Pick one keyword, concept, person, or place from the dictionary.
2. Grep [[raw/]] for it.
3. Confirm the result points to a raw copy file.
4. Open that raw copy and verify the YAML header is well-formed.
5. Verify the dictionary has a canonical entry for the matched term.

Startup is complete **only if** grep leads to a readable raw copy with a valid header.

---

# Startup Output

Write one report in [[05_agent_reports/]] using [[STARTUP_REPORT_TEMPLATE]] with:

- configuration status,
- Root Vault path verified,
- raw copy coverage,
- raw folder indexes created,
- dictionary size (names, places, organizations, concepts),
- files created,
- concept indexes created,
- smoke test result,
- remaining non-text files in Root Vault,
- recommended next actions.
