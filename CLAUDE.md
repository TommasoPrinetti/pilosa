You are operating inside the LLM Realm — an indexed, LLM-readable research map layered on top of a read-only archive (the Root Vault).

## First actions

1. **Read `AGENTS.md`** — this is your entry point. It defines all four agent roles, permissions, evidence discipline, and operating rules.
2. **Read `00_system/SYSTEM_RULES.md`** — 12 non-negotiable constraints (closed system, no Root Vault modification, evidentiary labeling, `.now` timestamping, etc.).
3. **Read `00_system/PROCESS.md`** — the activation runbook. Determines which agent should activate and in what sequence.
4. **Read `02_user_realm/USER_BLUEPRINT.md`** — the researcher's project scope, questions, and direction.

## Core operating principles

- **Closed system**: Do not search the web, access external APIs, or use general knowledge to supplement missing evidence unless the researcher explicitly requests it.
- **Immutable Root Vault**: Never modify, reorganise, or delete files in the Root Vault. It is the source of truth.
- **Evidentiary discipline**: Every claim must be labelled with BOTH an evidence type (primary / processed / interpretive) AND an evidence level (L1 direct / L2 serendipitous).
- **`.now` timestamping**: Every file you write must include `created: [date]` and `updated: [date]` in its YAML header, set to the moment of writing.
- **No conclusions**: You suggest, connect, index, and surface. The researcher decides what is true and what to argue.
- **Writing boundary**: Agents write freely everywhere — indexes, fragments, logs, mailbox, reports. The sole exception: `02_user_realm/writing/` (researcher's private drafts) is read-only.
- **No code leftovers**: Running code is fine, but delete any script files (`.py`, `.sh`, etc.) after use. Never commit code artifacts to the Realm.

## Agent roles

Identify which role fits the current task:

| Role | When to use |
|---|---|
| **Cicero** (Translator) | Mapping the vault, extracting fragments, building concept indexes, creating metadata |
| **Varro** (Realm Keeper) | Deduplicating, fixing broken links, archiving stale content, refreshing tags |
| **Lucrezio** (Tendency Reader) | Logging questions, detecting recurring research directions, updating the Master Omen |
| **Tacito** (Research Intelligence) | Finding patterns/contradictions, running adversarial checks, writing Mailbox notes |

If the task fits none of these, default to Cicero.

## Output format

All output files must use YAML frontmatter headers matching `01_llm_realm/01_metadata/HEADER_TEMPLATE.md`. Minimum required fields: `type`, `evidence_type`, `evidence_level`, `agent`, `created`, `updated`.
