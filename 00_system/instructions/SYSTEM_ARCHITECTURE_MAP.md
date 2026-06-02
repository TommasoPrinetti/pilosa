---
type: system_architecture_map
role: framework_map
purpose: [show how the home session, logs, sub-agents, and evidence layers connect]
scope: [repo-wide architecture]
connects_to:
  - AGENTS.md
  - 00_system/instructions/STARTUP.md
  - 00_system/sub_agents/conceptualizer/SOUL.md
  - 00_system/sub_agents/navigator/SOUL.md
  - 00_system/sub_agents/packer/SOUL.md
  - 00_system/sub_agents/checker/SOUL.md
  - 00_system/sub_agents/cleaner/SOUL.md
  - 00_system/sub_agents/startup/SOUL.md
  - 01_llm_zone/00_zone_index.md
created: 2026-05-26
updated: 2026-06-02
---

# LLM Zone System Architecture Map

## Core Architecture

LLM Zone is a two-layer research system.

```txt
Root Vault
  read-only original sources
  canonical evidence layer
        |
        | CLI transposes text-based files to .md raw copies,
        | agent builds dictionary, headers, and folder indexes
        v
LLM Zone
  writable indexed collection
  raw copies with YAML headers, dictionary, concept indexes, logs, reports
        |
        | prompt pipeline searches here first for token economy
        v
User-facing answers
  checked against raw copies before factual claims are finalized
```

## Prompt Lifecycle

```txt
User prompt
  |
  v
Home session orchestrator (AGENTS.md)
  |
  v
Request log
  |
  v
Classify
  |
  v
Choose sequence (default shapes; orchestrator may deviate)
  |
  v
Dispatch sub-agents — inject only ## Core Contract, route Detail on demand
  |
  v
Final answer
```

The home session is the orchestrator. It is governed by `AGENTS.md` and controls routing, handoffs, stop conditions, and final response assembly. Sub-agent routing tables, default sequences, hard rules, and evidence/quotes conventions all live in `AGENTS.md` — there is no separate router file.

## Sub-Agent Pipeline

| Stage | Owner | Function | Output |
|---|---|---|---|
| 0 | Home session | Log request, choose route, dispatch sub-agents, enforce stop conditions | Fast-path answer or routed sequence |
| 1 | Conceptualizer | Translate request into search concepts, keywords, route shape | Search brief |
| 2 | Navigator | Search LLM Zone first, Root Vault only when needed | Raw evidence packet |
| 3 | Packer | Build coherent report answering the original request | ONE clean report in [[05_agent_reports/]] |
| 4 | Checker | Verify quotes, claims, paths, indexes | Verification status, in-place corrections |
| 5 | Cleaner | Audit repo hygiene, propose archival moves, evaluate staleness | Cleaner Report with user-confirmation gate |
| 6 | Startup | Execute setup translation + indexing to create the first usable LLM Zone | Configuration, dictionary, headers, folder indexes, concept indexes, startup report |

The **Checker** can run alone for verification, source-path repair, or index maintenance. The **Cleaner** runs on-demand for hygiene audits. The **Startup** sub-agent runs when the user asks to start the Zone or setup files contain placeholders. Routing decisions and default route shapes live in `AGENTS.md`; sub-agent contracts live in `[[00_system/]]sub_agents/<name>/SOUL.md`.

## Setup Lifecycle

Initial setup creates the translation layer between Root Vault and LLM Zone. The **Startup** sub-agent executes the protocol in [[STARTUP]], which has two phases:

```txt
Setup draft / user startup prompt
  |
  v
Startup sub-agent receives brief
  |
  v
Phase 1 — Setup Translation
  fill configuration and research blueprint
  audit translation
  |
  v
CLI transposes accepted text-based files to .md raw copies in [[raw/]]
  |
  v
Phase 2 — Indexing
  agent builds master dictionary
  agent generates YAML headers for all raw copies
  agent creates index.md in every raw folder (canonical structure map)
  disambiguate with user (via orchestrator) if needed
  build concept indexes from repeated themes
  update master index
  |
  v
Run smoke test
  |
  v
Mark setup_status: zone_started
```

The setup output is not a final interpretation of the research corpus. It is the first navigable, token-efficient map that later agents can search.

## Evidence Hierarchy

| Layer | Role |
|---|---|
| Root Vault source | Canonical source of truth |
| Raw copy with header | Indexed, searchable copy in the Zone |
| Dictionary | Canonical vocabulary for consistent headers |
| Concept index | Thematic retrieval and pattern layer |
| Packer report | User-facing synthesis, not evidence by itself |
| Checker note | Verification state for quotes and claims |

## Active Files

| File | Role |
|---|---|
| `AGENTS.md` | Orchestrator playbook — single routing file |
| [[STARTUP]] | Setup translation + indexing protocol (read by Startup) |
| [[ZONE_CONFIGURATION]] | Operating profile |
| [[SYSTEM_ARCHITECTURE_MAP]] | This file — diagrams |
| [[OBSIDIAN_CONSTRAINTS]] | Markdown rules |
| [[conceptualizer|SOUL]] | Conceptualizer contract |
| [[navigator|SOUL]] | Navigator contract (owns canonical search order) |
| [[packer|SOUL]] | Packer contract |
| [[checker|SOUL]] | Checker contract |
| [[cleaner|SOUL]] | Cleaner contract |
| [[startup|SOUL]] | Startup contract |
| [[dictionary]] | Shared term vocabulary |
| [[zone_index]] | Master index |
| [[raw/]] | Markdown raw copies with folder `index.md` retrieval maps |
| [[HEADER_TEMPLATE]] | YAML header schema |
| [[03_concept_indexes/]] | Concept indexes |
| [[user_requests]] | Request log |
| [[05_agent_reports/]] | Reports, checkpoints, evidence packets, verification notes |

## Retired Model

The previous PROCESS_ROUTER and ONBOARDING files, and the previous TODO list, are historical. Active routing lives entirely in `AGENTS.md`. The setup translation protocol and indexing protocol are unified in [[STARTUP]]. The development TODO is now part of `README.md`. Archived files may mention retired names, but archived material is not active instruction.
