---
type: zone_configuration
agent: onboarding_cli
role: framework_configuration
purpose: [store project-level setup, source policy, and protected paths]
scope: [entire framework]
connects_to:
  - AGENTS.md
  - 00_system/instructions/STARTUP.md
  - INFORMATIONS.md
created: 2026-05-26
updated: 2026-06-02
setup_status: cli_started
---

# Zone Configuration

Agents read this before major work.

```yaml
zone_type: research_framework
research_mode: evolving_complex_corpus
root_vault_path: "[path]"
root_vault_mode: protected_append_only

source_policy: internal_first
active_corpus_path: 01_llm_zone/raw/
active_corpus_policy: raw_zone_first_after_onboarding
external_sources_allowed: no
external_logs:
  - 03_logs/external_queries.md
  - 03_logs/source_intake_log.md

claim_standard: source_link_required
l2_policy: checker_required

protected_paths:
  - "[root_vault_path]"
  - INFORMATIONS.md

stale_after_days: 30
preferred_llm_cli: "[cli]"
```
