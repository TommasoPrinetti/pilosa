# Glossary

**Agent** — One of four AI roles that maintain the Realm: Cicero, Varro, Lucrezio, Tacito. Each has a constrained domain and skill file.

**Back-search** — Returning to the Root Vault to read the full context of a quoted fragment before reporting it as evidence. Mandatory for L2 clues.

**Blueprint** — Short for `USER_BLUEPRINT.md`. Defines the research project scope, questions, and direction. Orients all agent activity.

**Closed system** — The rule that agents must not search external sources (web, APIs, general knowledge) unless the researcher explicitly requests it.

**Concept index** — A thematic collection of evidence fragments grouped under one concept (e.g., "speed vs. quality"). Lives in `03_concept_indexes/`.

**Evidence fragment** — A verbatim quote or precise paraphrase from the Root Vault, stored with source path, context, tags, and confidence.

**Evidence level** — L1 (direct, high confidence, explicitly answers the question) or L2 (serendipitous, adjacent, needs back-search).

**Evidence type** — Whether a claim is: primary (verbatim quote), processed (summary/cluster), or interpretive (hypothesis/pattern).

**Guilty knowledge** (Hughes, 1984) — Forms of knowing and doing that appear unserious, embarrassing, unethical, or dangerous to outsiders. A key theoretical frame for understanding concealment of AI use.

**L1 / L2** — See *Evidence level*.

**Mailbox** — `04_mailbox/inbox.md`. Where Tacito writes leads, warnings, contradictions, and serendipitous clues for the researcher.

**Master Omen** — `06_research_tendencies/MASTER_OMEN.md`. Lucrezio's aggregation of all research needs, used to detect recurring patterns.

**Moral division of labour** (Hughes) — The process by which professions collectively manage guilty knowledge through occupational norms, specialised vocabularies, and tacit coordination.

**`.now`** — The convention that every file records `created: [date]` at creation and `updated: [date]` on every edit. Enables Varro's cleanup cycle.

**Realm** — Short for LLM Realm. The writable, indexed, conceptually navigable map of the Root Vault.

**Re-index** — A Cicero pass triggered by Lucrezio when a tendency reaches count ≥ 3. The Realm reorganises around the detected pattern.

**Root Vault** — The immutable source archive. Never modified by agents. All fragments link back to it.

**Shadow AI** — The use of personal AI accounts for professional work, driven underground by organisational policies that forbid official AI use.

**Skill** — An agent skill file (e.g., `CICERO_SKILL.md`) that constrains an agent's actions, tools, and workflows.

**Structured research need** — A translated version of the researcher's raw question, filed in `03_logs/structured_research_needs/` with evidence requirements and hypotheses.

**Tendency** — A recurring research direction detected by Lucrezio when a question type appears ≥ 3 times. Triggers a re-index signal to Cicero.

**Writing Space** — `02_user_realm/writing/`. The researcher's private drafts and arguments. Read-only for all agents.
