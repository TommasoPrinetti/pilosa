# Onboarding Process

## Purpose
This document describes how a new researcher sets up the Ecology of Agent-Human Research system from scratch.

## Steps

### 1. Prepare the Root Vault
- Gather all raw research material into a Root Vault folder (e.g., `EVOLUTION - ROOTVAULT/`)
- Convert as much material as possible into machine-readable formats (markdown OCR, transcriptions)
- Create at minimum a high-level INDEX.md describing what the vault contains

### 2. Configure the LLM Realm
- Clone or copy this repository to your working directory
- Rename the folder to match your project (e.g., `MY_PROJECT - LLM REALM/`)
- The folder should already contain AGENTS.md and all subdirectories

### 3. Create the User Blueprint
- Fill out `02_user_realm/USER_BLUEPRINT.md` with research project, scope, questions, expertise, expected outputs, and constraints
- This is the most important step — the Blueprint orients the entire system

### 4. Create the Writing Space
- Place any existing drafts, notes, or working documents in `02_user_realm/writing/`
- This can be a single note or multiple files; it will grow over time

### 5. Run the Initial Translation
- Cicero performs the bootstrap pass following `00_system/INITIAL_TRANSLATION_PROTOCOL.md`
- This populates the Realm with exercise maps, concept indexes, evidence fragments, and metadata

### 6. Verify
- Check that the Realm Index (`01_llm_realm/00_realm_index.md`) shows all exercises as mapped
- Ask a test question to verify the pipeline works
- Check that the Mailbox (`04_mailbox/inbox.md`) receives a test note from Tacito

### 7. Begin research
- The system is now operational. Log questions normally in `03_logs/user_questions.md`.
- Lucrezio will begin detecting tendencies as questions accumulate.
- Varro will maintain the Realm as Cicero adds new material.
- Tacito will send serendipitous leads to the Mailbox.
