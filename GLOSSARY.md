# Glossary

**Agent** -- One of six active sub-agents that operate the Zone: Conceptualizer, Navigator, Packer, Checker, Cleaner, Startup. Each has a constrained domain and SOUL.md.

**Checker verification** -- Checker opens the Root Vault or raw copy to verify a quote, claim, concept index, or header entry before it is treated as source-grounded.

**Blueprint** -- Short for [[02_user_zone/RESEARCH_BLUEPRINT]]. Defines the research project scope, questions, corpus, evidence standards, and direction. Orients all agent activity.

**Concept index** -- A thematic collection of raw copies grouped under one concept (e.g., "speed vs. quality"). Lives in [[03_concept_indexes/]].

**Dictionary** -- [[01_llm_zone/00_dictionary]]. Shared vocabulary of canonical names, places, organizations, concepts, and domain terms. Supports multilingual keywords. Ensures consistent terminology across [[01_llm_zone/01_metadata/HEADER_TEMPLATE|raw copy]] headers.

**Internal-first source policy** -- The rule that agents must not search external sources (web, APIs, general knowledge) unless the researcher explicitly requests it or the Zone configuration allows logged external intake.

**L1 / L2** -- See *Evidence level*.

**Evidence level** -- L1 (direct, high confidence, explicitly answers the question) or L2 (adjacent and requires Checker verification before reporting).

**Evidence type** -- Whether a claim is: primary (direct source material), processed (summary/cluster), interpretive (hypothesis/pattern), or external (logged outside source).

**Research Need Aggregator** -- [[RESEARCH_NEED_AGGREGATOR]]. Aggregation of research needs, used to detect recurring prompt and search patterns.

**`.now`** -- The convention that every file records `created: [date]` at creation and `updated: [date]` on every edit. Enables maintenance and stale-file checks.

**Zone** -- Short for LLM Zone. The writable, indexed, conceptually navigable map of the Root Vault.

**Zone Configuration** -- [[ZONE_CONFIGURATION]]. The operating profile for the project: source policy, Root Vault path, evidence standards, enabled workflows, and agent sequence.

**Re-index** -- A Navigator and Checker maintenance pass that reorganizes the Zone around a detected pattern or fixes stale source navigation.

**Root Vault** -- The protected source collection. Never modified by agents. All raw copies link back to it.

**SOUL.md** -- A sub-agent contract file stored under sub_agents/[agent]/SOUL.md. Defines one sub-agent's allowed inputs, actions, outputs, behavioral rules, and prohibitions. Sub-agents are executors — they do not ask questions.

**Raw copy** -- A markdown raw copy transposed from a text-based Root Vault file into [[raw/]], carrying the [[01_llm_zone/01_metadata/HEADER_TEMPLATE|raw copy header]] with metadata for grep-based retrieval. The primary retrieval surface of the LLM Zone.

**Source intake log** -- [[03_logs/source_intake_log]]. Register of new Root Vault batches and retained external sources.

**Structured research need** -- A translated version of the researcher's raw question, filed in [[structured_research_needs/]] with evidence requirements and hypotheses.

**Tendency** -- A recurring research direction detected across request logs and structured needs. It can trigger a re-index or maintenance pass.

**User Zone** -- [[02_user_zone/]]. The researcher's free zone for drafts, arguments, and private material. No subfolders — files are placed directly. Read-only for all agents.

**`.trash`** -- Directory for retired files. Moved here instead of deleted. Hidden but present in the repo. Never delete files — archive them to [[.trash/]].
