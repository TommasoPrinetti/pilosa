# LLM Zone

LLM Zone turns a protected folder of source material (the **Root Vault**) into a searchable, header-indexed, multi-agent-readable knowledge map. A thin orchestrator (`AGENTS.md`) routes every prompt through specialist sub-agents (Conceptualizer, Navigator, Packer, Checker, Cleaner, Startup). The **Startup** sub-agent is the one-shot path that translates the setup draft and indexes the vault. **Checker** is mandatory on every non-fast-path route. Sub-agents never ask questions — only the orchestrator does.

## Quick Start

### 1. Clone the repo

```bash
git clone https://github.com/TommasoPrinetti/pilosa.git
cd pilosa
```

### 2. Create your own branch

Each user/research project lives on its own branch. `main` is the framework. `dev` is the active development branch. Pick a name for your project and branch from `dev` (or from `main` if you want a clean framework only):

```bash
git checkout -b my-project-name
git push -u origin my-project-name
```

> Why a branch? Onboarding rewrites `00_system/instructions/ZONE_CONFIGURATION.md` and `02_user_zone/RESEARCH_BLUEPRINT.md` and copies your Root Vault text files into `01_llm_zone/raw/`. Keeping that on a project branch lets you re-onboard, re-index, or wipe the project without touching the framework.

### 3. Run the onboard script

The script collects your project name, preferred LLM CLI, and Root Vault path, transposes text-based files into markdown raw copies, writes a setup draft, and prints a startup prompt to paste into your LLM CLI. Optional context such as project description and artifact URLs can be inferred or added later.

```bash
bash .bin/onboard.sh
```

What happens:
- TTY arrow-key picker for the CLI choice (numbered fallback when piped).
- Cursor hidden during file transposition, restored on exit.
- Existing setup files trigger an overwrite confirmation unless you pass `--force`.
- A startup prompt is written to your clipboard and printed to the terminal.

Flags:
- `--force` — overwrite existing setup data without asking
- `--numbered` — force the numbered CLI menu instead of the arrow-key picker
- `--no-color` — disable colored output
- `--help` — show usage

On macOS you can also double-click `onboard.command`. On Windows, double-click `onboard.cmd`.

### 4. Paste the prompt into your LLM CLI

Open Claude Code, Codex, OpenCode, or whichever CLI you picked, point it at this folder, and paste the prompt. The LLM will:

1. Use the fast setup draft, treating project description and artifact URLs as optional. If they were not provided, it records that and infers working scope from the raw corpus.
2. Update `00_system/instructions/ZONE_CONFIGURATION.md` and `02_user_zone/RESEARCH_BLUEPRINT.md` from `setup_status: cli_started` → `zone_started`.
3. Build the master dictionary, generate YAML headers for every raw copy, create folder `index.md` retrieval maps, build concept indexes, run the retrieval smoke test.
4. Write a startup report to `05_agent_reports/`.

After that, ask research questions normally. The orchestrator will route them through the right sub-agents.

## How the Zone is Organized

```
pilosa/
├── AGENTS.md                    The thin orchestrator (single routing file)
├── GLOSSARY.md                  Shared vocabulary
├── README.md                    This file
├── .bin/
│   ├── onboard.sh               Mechanical setup script (zero deps)
│   └── check-startup.sh         Pre-flight check
├── onboard.command              macOS launcher
├── onboard.cmd                  Windows launcher
├── 00_system/
│   ├── instructions/            AGENTS, STARTUP, ZONE_CONFIG, OBSIDIAN rules
│   ├── sub_agents/<name>/SOUL.md   Conceptualizer, Navigator, Packer, Checker, Cleaner, Startup
│   └── templates/               STARTUP_REPORT_TEMPLATE
├── 01_llm_zone/
│   ├── 00_zone_index.md         Master index (built at startup)
│   ├── 00_dictionary.md         Master dictionary (built at startup)
│   ├── raw/                     Markdown raw copies of text-based Root Vault files
│   ├── 01_metadata/             Header schema (HEADER_TEMPLATE)
│   └── 03_concept_indexes/      Concept indexes (built from recurring themes)
├── 02_user_zone/
│   └── RESEARCH_BLUEPRINT.md    Project description, sources, methods, outputs
├── 03_logs/                     Request log, source intake, external queries
└── 05_agent_reports/            Packer / Checker / Startup reports
```

## What the Orchestrator Does

Read `AGENTS.md` for the full routing contract. Briefly:

- **Classifies** every prompt into one of nine classes (`fast_path`, `clarify_search`, `find_material`, `evidence_answer`, `synthesis_report`, `verification`, `index_maintenance`, `cleanup`, `startup`).
- **Chooses a sub-agent sequence** for non-fast-path prompts — never answers them directly.
- **Owns the question tool** — sub-agents execute; they never ask.
- **Pre-processes** the user prompt (trim, summarize, normalize) before dispatch.
- **Logs every request** in `03_logs/user_requests.md`.

## Hard Rules

- Never edit the Root Vault.
- Never edit `02_user_zone/` content from sub-agents (it's the user's free zone).
- `connects_to` lists in YAML frontmatter stay at 3–5 load-bearing entries.
- File retirement goes to `.trash/`, not `rm`.

## Contributing

- Framework changes go to `dev` (or a feature branch off `dev`), not to your project branch.
- Keep `.bin/` scripts pure bash, zero deps.
- Update `01_llm_zone/01_metadata/HEADER_TEMPLATE.md` and `00_system/instructions/STARTUP.md` together if the header schema changes.
- Add a row to `03_logs/user_requests.md` for any framework-affecting work.

## Development Branch Checklist — What's Still To Do

The original development checklist from the framework design notes, condensed to the items not yet implemented. Tracked openly so anyone visiting the repo can see what's left.

### Knowledge / Context System
- [ ] Improve token and context management strategy (no quota or budget system yet)

### Sub-Agent System
- [ ] Verify whether sub-agents were already called (no call log yet)
- [ ] Allow agents to call many sub-agents dynamically (current dispatcher is fixed-shape)

### Reporting & Output
- [ ] Enable direct extraction from markdown into reports (no pipe from raw copies to Packer)

### UX / Interaction Design
- [ ] Create different "attitudes" / interaction modes for orchestration (single mode today)

### Infrastructure
- [ ] Explore scalable indexing architecture (current indexing is O(files) per startup)
- [ ] Continuous Root Vault sync (today: one-shot copy at onboarding, re-run to refresh)

### Open Questions
- [ ] How should token/context budgeting work long term?
- [ ] What is the optimal orchestration strategy for sub-agents?
- [ ] How much process visibility should remain in final reports?
- [ ] How should the system balance exploration vs execution?
- [ ] How should agent "attitudes" be modeled technically?
- [ ] How should the log/report rotation policy be tuned once real data accumulates?
