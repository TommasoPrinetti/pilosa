# LLM Human Ecology System

LLM Zone is a research framework that turns a protected Root Vault of source material into a searchable, header-indexed, multi-agent-readable knowledge map. The orchestrator routes every user prompt through specialist sub-agents (Conceptualizer, Navigator, Packer, Checker, Cleaner, Startup); the sub-agents never ask questions, only the orchestrator does. Startup is the one-shot path that translates the setup draft and indexes the vault. Cleaner audits repo hygiene and proposes archival moves. Checker is mandatory on every non-fast-path route. Read `AGENTS.md` for the routing contract.

This README is the development-branch checklist. Items are checked only when the repository currently contains an implemented framework, script, protocol, or active instruction that satisfies the task. Items that are only desired behavior, contradicted by current implementation, or not yet wired into the system remain unchecked.

Last reviewed: 2026-06-02.

## 1. Knowledge / Context System

* [x] Create a glossary + dictionaries system → `GLOSSARY.md`, [[dictionary]]
* [x] Detect languages automatically → dictionary records language per term, raw copy headers include `language` field
* [x] Structure project-specific files and contexts → full directory tree
* [x] Build an internal copy/index of the root vault → `.bin/onboard.sh` transposes raw copies, `STARTUP.md` indexes
* [x] Index YAML instructions/configurations → YAML headers are the core retrieval mechanism
* [x] Copy only `.md` files into the indexed environment → `onboard.sh` transposes accepted text formats into markdown raw copies
* [x] Preserve/connect headers and links during indexing → `[[wikilinks]]` in headers, `OBSIDIAN_CONSTRAINTS.md` defines rules
* [x] Generate folder `index.md` retrieval maps → `STARTUP.md` Phase 2 Step 2.5, `HEADER_TEMPLATE.md` raw_folder_index schema
* [ ] Improve token and context management strategy
* [x] Move more functionality into Obsidian-compatible structures → `OBSIDIAN_CONSTRAINTS.md` created, wikilinks supported
* [x] Support Obsidian-style paths and clickable links inside reports → verbatim quote format, wikilinks in Packer output

## 2. Startup / Initialization Workflow

* [x] Define startup bootstrap sequence → `STARTUP.md` (Phase 1 setup translation + Phase 2 indexing)
* [x] On startup: copy and process headers → `STARTUP.md` Step 2.4
* [x] On startup: load glossary + dictionaries → `STARTUP.md` Step 2.3 (multilingual dictionary)
* [x] On startup: collect name + CLI + Root Vault path → `.bin/onboard.sh` (description/URLs/policy gathered by the LLM during startup)
* [x] Delete or archive `startup.md` after activation → [[.trash/]] directory for retired files
* [x] Move initialization files into archive/generated folder → [[.trash/]] for retired files
* [x] Install/setup required services automatically during onboarding → pure bash, zero deps
* [x] Avoid requiring global NPM usage → pure bash, zero deps

## 3. Agent Behavior & Orchestration

### Main Agent Behavior

* [x] Agent should behave like an orchestrator → `AGENTS.md`
* [x] Agent must remain naturally curious → `AGENTS.md`
* [x] Agent should not get locked into one POV → `AGENTS.md`
* [x] Agent should constantly ask questions → `AGENTS.md` (orchestrator owns the `question` tool)
* [x] Agent should guide the search process actively → `AGENTS.md`
* [x] Agent should provide counter-perspectives → `AGENTS.md`
* [x] Agent should avoid blocking/assertive modes → `AGENTS.md`
* [x] Agent should augment user thinking rather than replace it → `AGENTS.md`
* [x] Agent should reason more broadly than the immediate process → `AGENTS.md` deeper-question and counter-argument rules
* [x] Agent should maintain question-driven exploration → `AGENTS.md`
* [x] Orchestrator can pre-process the user prompt before dispatch (trim, summarize, normalize) → `AGENTS.md` Step 4
* [x] Orchestrator can deviate from the default route table at runtime → `AGENTS.md` Step 3

### Sub-Agent System

* [x] Improve sub-agent calling structure → `AGENTS.md` default route shapes
* [x] Make sub-agents easier to invoke with precise profiles → `[[00_system/]]sub_agents/*/SOUL.md` with `## Core Contract` and `## Detail` sections
* [x] Define dedicated sub-agent profiles → `SOUL.md` files
* [x] Sub-agents are executors; only the orchestrator asks questions → `AGENTS.md` Hard Rules
* [ ] Verify whether sub-agents were already called
* [ ] Allow agents to call many sub-agents dynamically

### Search / Research Behavior

* [x] Provide more project context when researchers are involved → `RESEARCH_BLUEPRINT.md`
* [x] Make search behavior more exploratory and contextual → `AGENTS.md`, Conceptualizer brief, Navigator search order

## 4. Reporting & Output

### Report Structure

* [x] Improve report structure overall → clean Packer output format (Answer, Evidence, Analysis, Limitations)
* [ ] Enable direct extraction from markdown into reports
* [x] Keep reports cleaner and less process-heavy → Checker verification is internal, not shown
* [x] Delete intermediate process noise when appropriate → only final report is presented
* [x] Keep primarily the final report/output → ONE clean markdown file
* [x] Improve navigation inside reports with Obsidian paths → wikilinks, verbatim quote format
* [x] Ensure reports contain richer contextual references → verbatim format with author, source, date, bold key passage
* [x] Mandatory verbatim quote format with author/title/date/place/bold → `AGENTS.md` Verbatim Quotes, Packer SOUL

### Input / Output Routing

* [x] Define clear log/input/routing task delegation → `AGENTS.md` The Loop
* [x] Separate orchestration logic from execution logic → orchestrator (`AGENTS.md`) vs specialists (`SOUL.md`)

## 5. UX / Interaction Design

### User Interaction

* [x] Build onboarding question flows → `.bin/onboard.sh`
* [x] Prepare dynamic contextual question series → `STARTUP.md` Step 2.6 disambiguation
* [x] Make questioning adaptive to user/project state → `STARTUP.md` Phase 1 question gating
* [ ] Create different "attitudes"/interaction modes for orchestration

### Knowledge Navigation

* [x] Make Obsidian-style references clickable → `OBSIDIAN_CONSTRAINTS.md`
* [x] Create hidden `.md` guides to connect systems → `OBSIDIAN_CONSTRAINTS.md`
* [x] Folder `index.md` retrieval maps guide Navigator before grep → `STARTUP.md` Step 2.5
* [x] Improve contextual navigation across notes/files → `connects_to`, zone index, dictionary, concept index template

## 6. Infrastructure / Technical Decisions

### Internal Vault Strategy

* [x] Create an internal mirrored vault → [[raw/]]
* [x] Synchronize root vault into internal indexed structure → initial copy via `.bin/onboard.sh`; not continuous sync
* [x] Folder indexes replace embedded vault tree in Navigator's contract → single source of truth for structure map
* [ ] Explore scalable indexing architecture

### Dependency Management

* [x] Package dependencies locally in vault → pure bash, zero deps
* [x] Reduce reliance on globally installed packages → zero external packages
* [x] Design standalone environment setup → `.bin/onboard.sh` + `.bin/check-startup.sh`

### Cleanup and Archival

* [x] Cleaner never moves to [[.trash/]] or deletes without user confirmation → `Cleaner/SOUL.md` user-confirmation gate
* [x] Cleaner evaluates both age and research tendency before proposing archival moves → `Cleaner/SOUL.md` staleness rule
* [x] Retired files are moved to [[.trash/]] (not deleted) with date suffix → `AGENTS.md` Write Boundaries

## 7. Documentation & Communication

### Structural Documentation

* [x] Define workflows formally → `AGENTS.md`
* [x] Document startup lifecycle → `STARTUP.md`
* [x] Document agent orchestration architecture → `SYSTEM_ARCHITECTURE_MAP.md`
* [x] Document indexing + vault synchronization process → `STARTUP.md`, `.bin/onboard.sh`
* [x] AGENTS.md is the single routing file; routing logic no longer split across PROCESS_ROUTER + AGENTS

## 8. Open Questions / Research Directions

* [ ] How should token/context budgeting work long term?
* [ ] What is the optimal orchestration strategy for sub-agents?
* [ ] How much process visibility should remain in final reports?
* [ ] How should the system balance exploration vs execution?
* [ ] How should agent "attitudes" be modeled technically?
* [ ] How should the log/report rotation policy be tuned once real data accumulates?
