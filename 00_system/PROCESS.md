---
type: process_guide
agent: Cicero
created: [date]
updated: [date]
---

# Process — Agent Activation Runbook

## Canonical workflow (18 steps)

```
Gather → Translate → Preserve → Map (Cicero) → Connect → Blueprint → Writing Space
→ Headers (Cicero) → Log (Lucrezio) → Read tendencies (Lucrezio)
→ Reorganize (Cicero + Varro) → Constrain → Maintain (Varro)
→ Intelligence (Tacito) → Render → Separate L1/L2 → Back-search → Interpret (researcher)
```

---

## Simplified directional flow

```
User Blueprint → Logs → Lucrezio → Cicero → Realm → Varro → Tacito → Mailbox → Researcher → Back-search → Root Vault
```

---

## Agent activation diagram

```
                        ┌──────────────────────┐
                        │     ROOT VAULT        │
                        │  (immutable source)    │
                        └──────────┬───────────┘
                                   │
                                   ▼
                        ┌──────────────────────┐
                        │  ① CICERO (initial)  │
                        │  Maps → indexes →     │
                        │  fragments            │
                        └──────────┬───────────┘
                                   │
                                   ▼
                        ┌──────────────────────┐
                        │     LLM REALM         │
                        │  (evidence base)      │
                        └──────────┬───────────┘
                                   │
              ┌────────────────────┼────────────────────┐
              │                    │                    │
              ▼                    ▼                    ▼
   ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
   │ ② RESEARCHER │    │ ④ LUCREZIO  │    │ ⑥ TACITO    │
   │ Asks         │    │ Reads logs   │    │ Detects      │
   │ Writes       │    │ + Blueprint  │    │ patterns     │
   │ Reads Mailbox│    │ + tendencies │    │ → Mailbox    │
   └──────┬───────┘    │ → signals    │    └──────┬───────┘
          │            └──────┬───────┘           │
          │                   ▼                   │
          │            ┌──────────────┐           │
          │            │ ③ CICERO    │           │
          │            │  (re-index)  │           │
          │            └──────┬───────┘           │
          │                   │                   │
          │                   ▼                   │
          │            ┌──────────────┐           │
          │            │ ⑤ VARRO     │◄──────────┘
          │            │ (maintain)   │
          │            └──────┬───────┘
          │                   │
          └────────┬──────────┘
                   ▼
         ┌──────────────────┐
         │ ⑦ RESEARCHER     │
         │ Interprets       │
         │ → new question   │
         └──────────────────┘
```

---

## 1. FRESH START — bootstrap

**Trigger:** Repository cloned, Root Vault exists, `01_llm_realm/` empty.

| # | Who | Action | Output |
|---|---|---|---|
| 1.1 | **Human** | Fill `02_user_realm/USER_BLUEPRINT.md` | Blueprint |
| 1.2 | **Human** | (Optional) Place drafts in `02_user_realm/writing/` | Writing Space |
| 1.3 | **Cicero** | Follow `INITIAL_TRANSLATION_PROTOCOL.md` | Populated Realm |
| 1.4 | **Cicero** | Write completion report to `05_agent_reports/` | Report |
| 1.5 | **Human** | Verify `00_realm_index.md` shows all folders mapped | Verification |

---

## 2. RESEARCH LOOP

**Trigger:** Human asks a question or writes in the Writing Space.

### 2.1 Lucrezio — log

| # | Who | Action | Output |
|---|---|---|---|
| 2.1.1 | **Human** | Ask question | Raw question |
| 2.1.2 | **Lucrezio** | Append to `03_logs/user_questions.md` | Logged |
| 2.1.3 | **Lucrezio** | Write structured need to `03_logs/structured_research_needs/` | `.md` file |
| 2.1.4 | **Lucrezio** | Update MASTER_OMEN: append + increment counter | Updated omen |
| 2.1.5 | **Lucrezio** | If any type ≥ 3 → register tendency (2.2) | Decision |

### 2.2 Lucrezio — register tendency

| # | Who | Action | Output |
|---|---|---|---|
| 2.2.1 | **Lucrezio** | Record in `02_user_realm/RESEARCH_TENDENCIES.md` | Tendency entry |
| 2.2.2 | **Lucrezio** | Write re-index signal to `05_agent_reports/` | Signal |

### 2.3 Cicero — re-index

| # | Who | Action | Output |
|---|---|---|---|
| 2.3.1 | **Cicero** | Read signal, search gaps against tendency | Analysis |
| 2.3.2 | **Cicero** | Extract new fragments, update/create indexes | Updated indexes |
| 2.3.3 | **Cicero** | Update `00_realm_index.md` | Updated index |

### 2.4 Answer

| # | Who | Action | Output |
|---|---|---|---|
| 2.4.1 | **Any agent** | Search indexes for evidence | Evidence set |
| 2.4.2 | **Any agent** | Back-search to Root Vault | Verified |
| 2.4.3 | **Any agent** | Structure: **L1** (verbatim, sources) + **L2** (patterns, contradictions) | Answer |
| 2.4.4 | **Any agent** | Present to researcher | Delivered |

### 2.5 Tacito — intelligence

| # | Who | Action | Output |
|---|---|---|---|
| 2.5.1 | **Tacito** | Read Blueprint + tendencies + omen + indexes | Context |
| 2.5.2 | **Tacito** | Run adversarial checklist | Checklist |
| 2.5.3 | **Tacito** | Detect patterns, contradictions, clues | Leads |
| 2.5.4 | **Tacito** | Back-search leads to Root Vault | Verified |
| 2.5.5 | **Tacito** | Write Mailbox note to `04_mailbox/inbox.md` | Note |
| 2.5.6 | **Tacito** | Write report to `05_agent_reports/` | Report |

### 2.6 Human — interpret

| # | Who | Action | Output |
|---|---|---|---|
| 2.6.1 | **Human** | Read Mailbox, back-search, interpret | Decision |
| 2.6.2 | **Human** | (Optional) Write in `02_user_realm/writing/` | Update |

**Loop returns to 2.1** for the next question.

---

## 3. MAINTENANCE — Varro

**Trigger:** (A) 30 days idle, (B) after Cicero pass, (C) before Tacito.

| # | Who | Action | Output |
|---|---|---|---|
| 3.1 | **Varro** | Health check: duplicates, stale files, broken links, weak tags | Report |
| 3.2 | **Varro** | Deduplicate, refresh tags, fix paths | Clean |
| 3.3 | **Varro** | Archive outdated indexes to `archive/` with date prefix | Archived |
| 3.4 | **Varro** | Write maintenance report to `05_agent_reports/` | Log |

---

## 4. IDLE MODE

| # | Who | When | Action |
|---|---|---|---|
| 4.1 | **Varro** | Every 30 days | Full health check |
| 4.2 | **Tacito** | After Varro | Periodic scan |
| 4.3 | **Tacito** | If pattern found | Mailbox note |
| 4.4 | **Human** | On next login | Read → may trigger §2 |

---

## Activation triggers

| Agent | When | Writes to |
|---|---|---|
| **Cicero** | Bootstrap / tendency ≥ 3 | `01_llm_realm/` |
| **Lucrezio** | Each question | `03_logs/`, `06_research_tendencies/` |
| **Varro** | 30 days / after Cicero / before Tacito | `archive/`, `05_agent_reports/` |
| **Tacito** | New indexes / broad question / periodic | `04_mailbox/`, `05_agent_reports/` |
| **Human** | Mailbox note / own need | `02_user_realm/writing/` |

---

## Parallel rules

- Cicero first, Varro after (same index)
- Lucrezio + Tacito reading same files: safe
- Tacito **never** before Cicero finishes

## `.now` enforcement

Every file gets `created` and `updated` at write time. Varro uses these:
- `updated` > 30 days → flag
- `updated` > 60 days → archive
- Only `created` → abandoned file
