# AGENTS.md — LLM Realm Operating Rules

## 1. Purpose
The LLM Realm is an indexed, LLM-ready, conceptually navigable map of the Root Vault. It is not a copy of the archive. The Root Vault remains the immutable source of truth. The Realm evolves as research progresses: indexes are updated, fragments are added, logs accumulate, and the map reorganizes around the researcher's active direction.

## 2. Folder structure

```
LLM REALM/
  00_system/              Agent definitions, system rules, operating loop, skills
  01_llm_realm/           Indexes, concept maps, metadata, evidence fragments, protocols
  02_user_realm/          User Blueprint, research tendencies, research writing space
  03_logs/                User questions, structured research needs, external queries
  04_mailbox/             Agent-to-researcher notes, leads, serendipitous clues
  05_agent_reports/       Audits, maintenance reports, cleanup logs
  06_mirror/              User-facing output layer (planned: HTML, Telegram, etc.)
  AGENTS.md               This file — central entry point for all agents
  README.md               Realm orientation
```

## 3. Permissions per folder

| Folder | Read | Write | Notes |
|---|---|---|---|
| `00_system/` | ✅ All agents | ✅ Varro only | Agent role definitions and skills are stable; Varro may update |
| `01_llm_realm/` | ✅ All agents | ✅ Cicero, Varro | Cicero writes indexes/maps; Varro maintains |
| `02_user_realm/` | ✅ All agents | ✅ Lucrezio (tendencies only) | User's space — `writing/` subfolder is read-only for ALL agents. Lucrezio may update `RESEARCH_TENDENCIES.md` |
| `03_logs/` | ✅ All agents | ✅ Lucrezio | Lucrezio logs questions and translates to research needs |
| `04_mailbox/` | ✅ All agents | ✅ Tacito | Tacito writes notes; other agents may read |
| `05_agent_reports/` | ✅ All agents | ✅ Varro, Tacito, Lucrezio, Cicero | Reports, maintenance logs, re-index signals, completion signals |
| `06_mirror/` | ✅ All agents | ❌ Reserved | Future output channel; not yet operational |

## 4. What agents CANNOT do

| Prohibition | Rationale |
|---|---|
| Modify the Root Vault | It is the immutable source of truth |
| Edit or overwrite files in `02_user_realm/writing/` | The writing space belongs to the researcher |
| Delete files without archiving | Always move outdated content to a dated subfolder in `01_llm_realm/archive/` |
| Leave code artifacts (`.py`, `.sh`, `.js`, etc.) in the Realm | Code can run but must never leave leftover files. The Realm is markdown-only. Temporary scripts must be deleted after execution |

## 5. Four agent roles

| Agent | Core task | Skill file |
|---|---|---|
| **Cicero** — Translator | Transform raw Root Vault material into LLM-readable indexes, headers, fragments, source pointers | `00_system/skills/CICERO_SKILL.md` |
| **Varro** — Realm Keeper | Maintain the Realm: deduplicate, refresh tags, fix broken links, archive outdated structures | `00_system/skills/VARRO_SKILL.md` |
| **Lucrezio** — Tendency Reader | Read Blueprint, Logs, and Writing Space to detect recurring research directions | `00_system/skills/LUCREZIO_SKILL.md` |
| **Tacito** — Research Intelligence | Detect patterns, contradictions, hypotheses across the Realm; send leads to Mailbox. Adversarial by design. | `00_system/skills/TACITO_SKILL.md` |

## 6. Evidence discipline
Every piece of evidence an agent produces must include TWO labels:

**Evidence type** (what kind of material it is):
| Type | Definition | Example |
|---|---|---|
| **Primary evidence** | Direct quote or excerpt checked against the Root Vault, with source file path | `> "It was faster, but I had to correct everything." — exercise_004/audio/transcription_003.md` |
| **Processed evidence** | Summary, thematic cluster, agent-generated connection, small fragment stored in the Realm | `Fragments for speed/quality tradeoff indexed under 01_llm_realm/03_concept_indexes/` |
| **Interpretive suggestion** | Possible argument, pattern, contradiction, serendipitous clue, Mailbox note | `This may suggest acceleration displaces quality work into a later repair phase` |

**Evidence level** (how directly it answers the question):
| Level | Definition |
|---|---|
| **L1 — Direct evidence** | Explicitly answers the question. Verbatim quotes, precise source links, high confidence |
| **L2 — Serendipitous evidence** | Adjacent clues, metaphors, marginalia, weak signals, contradictions. Lower confidence. Requires back-search before use |

Both labels are orthogonal. Example: an L2 serendipitous clue can be primary evidence (a real quote found serendipitously) or an interpretive suggestion (a possible connection).

## 7. Two evidence levels

### Level 1 — Direct evidence (L1)
Explicitly answers the researcher's question. Verbatim quotes, precise source links, high confidence.

### Level 2 — Serendipitous evidence (L2)
Adjacent clues, metaphors, marginalia, weak signals, contradictions. Lower confidence. Requires back-search before use.

## 8. Operating loop
The canonical 18-step workflow (see `00_system/OPERATING_LOOP.md` for full detail):

1. Gather archive → 2. Translate to machine-readable → 3. Preserve Root Vault → 4. Map into Realm (Cicero) → 5. Connect via source pointers → 6. Create User Blueprint → 7. Create Writing Space → 8. Generate headers and indexes (Cicero) → 9. Log every question (Lucrezio) → 10. Read tendencies (Lucrezio) → 11. Reorganize Realm around direction (Cicero + Varro) → 12. Constrained skills → 13. Maintain (Varro) → 14. Mailbox notes (Tacito) → 15. Render answers → 16. Separate L1/L2 → 17. Back-search → 18. Researcher interprets

## 9. Back-search rule
Before finalizing any answer that depends on a factual claim:
1. Check the Realm indexes for the evidence fragment.
2. If the researcher needs precision, return to the Root Vault file linked by the index.
3. Read the full surrounding context before reporting.
4. Always include the source file path in your output.
5. For L2 clues, back-search is MANDATORY before reporting (see `01_llm_realm/05_backsearch_instructions/SERENDIPITY_PROTOCOL.md`).

## 10. Writing boundary
The `02_user_realm/writing/` folder contains the researcher's active drafts, papers, notes, and arguments. Agents may:
- **Read** it as a signal of research direction
- **Detect** gaps, contradictions, or missing evidence
- **Suggest** leads via the Mailbox

Agents must **NOT**:
- Edit or overwrite any file in `02_user_realm/writing/`
- Insert text, rewrite arguments, or restructure the researcher's document
- Claim the researcher's writing as agent output

## 11. Closed system
The LLM Realm is a **closed system** by default. Agents must not:
- Search the web, access external APIs, or query knowledge bases outside this project
- Import external assumptions, theories, or data that do not belong to the archive
- Use general LLM knowledge to supplement missing evidence

**Exception**: The researcher may explicitly ask the agent to fetch an external source. In that case, the agent must:
1. Note in the answer that external sources were used
2. Clearly distinguish external material from internal archive evidence
3. Log the external query in `03_logs/external_queries.md` for traceability
