# 05_agent_reports — Durable Reports & Checkpoints

Synthesis reports, evidence packets, verification notes, checkpoints, and maintenance reports. These are the primary output artifacts of the sub-agent pipeline.

## Sub-agent ownership

- **Packer** writes reports: full synthesis, partial results, checkpoints. Each report answers the original user prompt or marks progress.
- **Checker** annotates, corrects in-place, and writes standalone verification notes. Corrections are applied directly to the report (not as separate commentary).
- **Cleaner** evaluates reports for staleness and may propose archival to `.trash/` based on age alone (no structured research needs).
- **Navigator** does not write here — outputs raw evidence packets inline to the orchestrator.

## Operations

- Reports are **read-write**: Packer creates, Checker corrects in-place. Cleaner may archive.
- Each report must have a clear `type` and `scope` in the body or frontmatter.
- Evidence-bearing claims must cite source paths (raw copy or Root Vault).
- Verification failures are documented, not hidden.
- Partial results must be labeled as such.
- Cleaner evaluates staleness by comparing `updated:` dates against current date — no tendency detection or structured needs analysis.

## Report types

| Type | When | Who |
|---|---|---|
| `synthesis` | Full answer to a user prompt | Packer |
| `evidence_packet` | Raw evidence from Navigator handoff | Navigator → Packer |
| `checkpoint` | Partial progress during long routes | Packer |
| `verification` | Claim/path/index verification | Checker |
| `maintenance` | Index repair, stale audit, cleanup proposal | Checker / Cleaner |

## Conventions

- Filenames: descriptive-snake-case.md
- Report bodies are Markdown. Use Obsidian wikilinks for Zone references.
- If a report cites a claim that Checker could not verify, mark it explicitly.

## See also

- [[AGENTS]] — orchestrator playbook (Packer dispatch, Checker dispatch)
- [[.trash/AGENTS]] — archival destination for stale reports
