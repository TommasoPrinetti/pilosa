---
type: zone_configuration
agent: onboarding_cli
role: framework_configuration
purpose: [store project-level setup, source policy, and protected paths]
scope: [entire framework]
connects_to:
  - AGENTS.md
  - 00_system/instructions/STARTUP.md
  - 02_user_zone/RESEARCH_BLUEPRINT.md
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
external_sources_allowed: no
external_logs:
  - [[external_queries]]
  - [[source_intake_log]]

claim_standard: source_link_required
l2_policy: checker_required

protected_paths:
  - "[root_vault_path]"
  - [[02_user_zone/]]

stale_after_days: 30
preferred_llm_cli: "[cli]"
```
