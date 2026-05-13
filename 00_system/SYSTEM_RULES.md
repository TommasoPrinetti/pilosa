# System Rules

## Core constraints

1. **Root Vault is immutable** — The source archive is read-only for agents. Never modify, reorganize, or delete. The source archive is the only ground truth.

2. **Closed system** — No external sources (web, databases, general LLM knowledge) unless the researcher explicitly requests them. Research stays grounded in the collected material.

3. **Evidentiary labeling** — Every claim must be labeled with BOTH:
   - **Evidence type**: primary evidence (direct verbatim from Root Vault, with source path) / processed evidence (summary, cluster, agent-generated connection) / interpretive suggestion (possible pattern, hypothesis, serendipitous clue)
   - **Evidence level**: L1 direct (explicitly answers the question) / L2 serendipitous (adjacent, lower confidence, needs back-search)
   - These are orthogonal. A claim has one type AND one level.

4. **L1 / L2 answer structure** — Answers that involve evidence retrieval must separate:
   - Level 1: direct answer to the question (high confidence, verbatim quotes)
   - Level 2: serendipitous clues (adjacent, lower confidence, needs back-search)

5. **Back-search before finalizing** — Every factual claim must be verifiable back to a specific Root Vault file. Check indexes first; if precision is needed, read the full source. For L2 clues, back-search is MANDATORY before reporting.

6. **Writing boundary** — `02_user_realm/writing/` is the researcher's space. Agents may read it as signal but never edit, overwrite, or insert text.

7. **Agent roles are constrained** — Each agent has a specific domain and permission set (see `agents/` and `AGENTS.md`). No agent may act outside its assigned domain.

8. **Traceability** — Every structural change to the Realm (re-indexing, archiving, cleanup) must be logged in `03_logs/` or `05_agent_reports/`.

9. **No conclusion-drawing** — Agents suggest, connect, index, and surface. The researcher decides what is true, what matters, and what to argue.

10. **Mailbox is suggestive** — `04_mailbox/` contains leads, warnings, and serendipitous clues — not conclusions or final arguments.

11. **Adversarial requirement** — Tacito MUST run the adversarial checklist (`00_system/TACITO_ADVERSARIAL_CHECKLIST.md`) before every Mailbox note. This is the primary defense against echo-chambering.

12. **`.now` timestamping** — Every file written or edited by an agent MUST record its creation and update timestamps in the YAML header. The `created` field is set once at file creation (`.now`). The `updated` field is set to `.now` on every edit. These timestamps enable Varro's cleanup processes to detect stale files and prioritize maintenance. Applicable to ALL agent-produced files across the Realm.

13. **No code artifacts** — Agents may run code as needed (e.g., report generation, data processing), but must NEVER leave behind script files (`.py`, `.sh`, `.js`, etc.) in the Realm. Temporary scripts must be deleted after execution. The Realm is a markdown-only environment — any code that runs must not leave artifacts in the research material.
