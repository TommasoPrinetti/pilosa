---
type: request_log
role: request_routing_log
purpose: record user prompts and the file or route outcome
scope: framework_and_research_requests
connects_to:
  - AGENTS.md
  - 05_agent_reports/
created: 2026-05-26
updated: 2026-06-02
---

# User Requests

Short routing log for user prompts. Log the request before deciding whether to answer directly or route through sub-agents.

| Date | Request summary | Route | Status | Output |
|---|---|---|---|---|
| 2026-06-02 | Diagnose onboarding Root Vault path not found | fast_path | done | Path exists; onboarding now strips wrapping quotes |
| 2026-06-02 | Fix onboarding quoted-path handling and push | fast_path | done | Onboarding accepts quoted paths and preserves success after copy summary |
| 2026-06-02 | Turn README into operational development TODO | fast_path | done | README replaced with checked branch-status checklist |
| 2026-06-02 | Rename onboarding copy destination to raw folder | fast_path | done | Onboarding now writes initial copies to 01_llm_zone/raw/ |
| 2026-06-02 | Add raw folder index.md requirement to onboarding | fast_path | done | Startup now requires index.md in every raw folder with file summaries |
| 2026-06-02 | Refactor framework: thin AGENTS.md routing, eliminate PROCESS_ROUTER/ONBOARDING/TODO, SOUL Core Contract split, Cleaner research-tendency staleness | index_maintenance | done | AGENTS.md 383→241 lines; AGENTS.md is now the single routing file; SOUL.md files split into ## Core Contract + ## Detail |
| 2026-06-02 | Convert inline bare paths in framework body to short-form wikilinks; frontmatter `connects_to:` stays bare | index_maintenance | done | 200+ conversions across 13 files; bracket-explosion fix via idempotent regex; convention documented in OBSIDIAN_CONSTRAINTS.md |
| 2026-06-02 | Rename "realm" → "zone": folder renames, file renames, terminology, free-zone restructure, archive removal | index_maintenance | done | 168 text replacements + 9 follow-up fixes; folders renamed with git mv (01_llm_realm→01_llm_zone, 02_user_realm→02_user_zone, 00_realm_index.md→00_zone_index.md, REALM_CONFIGURATION.md→ZONE_CONFIGURATION.md); archive/ and writing/ folders removed; 02_user_zone/ is now a flat free zone |
