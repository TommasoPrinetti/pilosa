#!/usr/bin/env bash
set -euo pipefail

# ── ANSI colors (zero dependencies) ──────────────────────────────────────────
if [[ "${NO_COLOR:-}" == "1" ]] || [[ ! -t 1 ]]; then
  R="" G="" B="" Y="" C="" M="" DIM="" BOLD="" RESET=""
else
  R=$'\033[31m' G=$'\033[32m' B=$'\033[34m' Y=$'\033[33m'
  C=$'\033[36m' M=$'\033[35m' DIM=$'\033[2m' BOLD=$'\033[1m' RESET=$'\033[0m'
fi

# ── helpers ──────────────────────────────────────────────────────────────────
ROOT="$(pwd)"
TODAY="$(date +%Y-%m-%d)"
FORCE="0"

Blueprint="$ROOT/02_user_zone/RESEARCH_BLUEPRINT.md"
Config="$ROOT/00_system/instructions/ZONE_CONFIGURATION.md"
Agents="$ROOT/AGENTS.md"
Claude="$ROOT/CLAUDE.md"
Aggregator="$ROOT/03_logs/research_tendencies/RESEARCH_NEED_AGGREGATOR.md"
AggregatorTemplate="$ROOT/03_logs/research_tendencies/RESEARCH_NEED_AGGREGATOR_TEMPLATE.md"
RawDir="$ROOT/01_llm_zone/raw"

# text-based extensions to copy from Root Vault
TEXT_EXTENSIONS="md|txt|rtf|csv|json|yaml|yml|toml|xml|html|css|js|ts|py|rb|sh|log|ini|cfg|conf|tex|bib|org|adoc|rst|wiki|mediawiki|asciidoc|textile|dokuwiki|pmwiki|tiddlywiki|opml|outliner|workflowy|dynalist|logseq|roam|obsidian"

divider()   { printf '%s\n' "${DIM}$(printf '%.0s─' 1 {1..78})${RESET}"; }
header()    { printf '\n%s\n\n' "${BOLD}${C}$1${RESET}"; }
info()      { printf '  %s %s\n' "${DIM}→${RESET}" "$1"; }
ok()        { printf '  %s %s\n' "${G}✦${RESET}" "$1"; }
warn()      { printf '  %s %s\n' "${Y}⚠${RESET}" "$1"; }
note()      { printf '  %s↳%s %s\n' "${DIM}" "${RESET}" "$1"; }
print_step(){ printf '\n  %s%s[%s/%s] %s%s\n' "${BOLD}" "${C}" "$1" "$2" "$3" "${RESET}"; }
print_box() {
  printf '\n  %s┌%s┐%s\n' "${DIM}" "$(printf '%.0s─' 1 {1..76})" "${RESET}"
  printf '  %s│%s %s%s%s\n' "${DIM}" "${RESET}" "${BOLD}$1${RESET}" "${DIM}" "${RESET}"
  printf '  %s├%s┤%s\n' "${DIM}" "$(printf '%.0s─' 1 {1..76})" "${RESET}"
  while IFS= read -r line; do
    printf '  %s│%s %s\n' "${DIM}" "${RESET}" "$line"
  done
  printf '  %s└%s┘%s\n' "${DIM}" "$(printf '%.0s─' 1 {1..76})" "${RESET}"
}

ask() {
  local prompt="$1" default="${2:-}" hint="${3:-}"
  local fb=""
  [[ -n "$default" ]] && fb=" ${DIM}(${default})${RESET}"
  [[ -n "$hint" ]] && printf '  %s %s\n' "${DIM}↳${RESET}" "$hint" >&2
  printf '%s' "${BOLD}${prompt}${RESET}${fb}${DIM}: ${RESET}" >&2
  local reply
  IFS= read -r reply || true
  reply="${reply:-$default}"
  echo "$reply"
}

select_menu() {
  local prompt="$1"
  shift
  local options=("$@")

  printf '%s\n' "${BOLD}${prompt}${RESET}" >&2
  for i in "${!options[@]}"; do
    printf '  %s %s\n' "${DIM}$((i+1)).${RESET}" "${options[$i]}" >&2
  done

  local choice
  while true; do
    printf '%s' "${DIM}  Enter number [1-${#options[@]}]: ${RESET}" >&2
    IFS= read -r choice || choice="1"
    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#options[@]} )); then
      echo "${options[$((choice-1))]}"
      return
    fi
    printf '  %s\n' "${R}Invalid choice. Try again.${RESET}" >&2
  done
}

arrow_select() {
  # Arrow-key menu with TTY detection.
  # - In a TTY: up/down keys move the cursor, Enter selects, q cancels.
  # - Outside a TTY (piped input, non-interactive shells): fall back to select_menu.
  # - Set NUMBERED=1 in the environment to force the numbered menu.
  local prompt="$1"
  shift
  local options=("$@")

  if [[ "${NUMBERED:-0}" == "1" ]] || [[ ! -t 0 ]]; then
    select_menu "$prompt" "${options[@]}"
    return
  fi

  if ! command -v stty >/dev/null 2>&1; then
    select_menu "$prompt" "${options[@]}"
    return
  fi

  local count=${#options[@]}
  local current=0
  local key seq part
  local old_stty
  old_stty=$(stty -g 2>/dev/null) || { select_menu "$prompt" "${options[@]}"; return; }

  # Render initial menu
  printf '\n  %s\n' "${BOLD}${prompt}${RESET}" >&2
  printf '  %s\n' "${DIM}↑/↓ to move, Enter to confirm, q to cancel${RESET}" >&2
  for i in "${!options[@]}"; do
    if (( i == current )); then
      printf '  %s %s %s\n' "${C}" "▶" "${BOLD}${options[$i]}${RESET}" >&2
    else
      printf '    %s\n' "${options[$i]}" >&2
    fi
  done

  if ! stty raw -echo 2>/dev/null; then
    printf '\n  %s arrow-key mode failed, falling back to numbered menu\n' "${Y}⚠${RESET}" >&2
    # Clear the partial menu we already printed
    printf '\033[%dF' "$count" >&2
    for _ in "${!options[@]}"; do printf '\r\033[2K\n' >&2; done
    select_menu "$prompt" "${options[@]}"
    return
  fi

  local old_int_trap old_term_trap old_exit_trap
  old_int_trap="$(trap -p INT || true)"
  old_term_trap="$(trap -p TERM || true)"
  old_exit_trap="$(trap -p EXIT || true)"

  restore_arrow_traps() {
    if [[ -n "$old_int_trap" ]]; then eval "$old_int_trap"; else trap - INT; fi
    if [[ -n "$old_term_trap" ]]; then eval "$old_term_trap"; else trap - TERM; fi
    if [[ -n "$old_exit_trap" ]]; then eval "$old_exit_trap"; else trap - EXIT; fi
  }

  cleanup_arrow() {
    stty "$old_stty" 2>/dev/null || true
    printf '\033[?25h' >&2
    restore_arrow_traps
  }
  trap 'cleanup_arrow; printf "\n  Cancelled.\n" >&2; exit 1' INT TERM
  trap 'cleanup_arrow' EXIT

  while true; do
    IFS= read -r -n 1 -s key 2>/dev/null || { cleanup_arrow; return 1; }
    case "$key" in
      $'\x1b')
        seq=""
        while IFS= read -r -n 1 -s -t 1 part 2>/dev/null; do
          seq+="$part"
          [[ ${#seq} -ge 2 ]] && break
        done
        case "$seq" in
          '[A'|'OA') ((current--)); ((current < 0)) && current=$((count - 1)) ;; # up
          '[B'|'OB') ((current++)); ((current >= count)) && current=0 ;;            # down
          *) continue ;;
        esac
        # Redraw: move to the first option column, then rewrite each line.
        printf '\033[%dF' "$count" >&2
        for i in "${!options[@]}"; do
          printf '\r\033[2K' >&2
          if (( i == current )); then
            printf '  %s %s %s\n' "${C}" "▶" "${BOLD}${options[$i]}${RESET}" >&2
          else
            printf '    %s\n' "${options[$i]}" >&2
          fi
        done
        ;;
      ''|$'\n'|$'\r') break ;; # Enter
      $'\x03') cleanup_arrow; printf '\n  %s\n' "${DIM}Cancelled.${RESET}" >&2; return 1 ;;
      'q'|'Q') cleanup_arrow; printf '\n  %s\n' "${DIM}Cancelled.${RESET}" >&2; return 1 ;;
    esac
  done

  cleanup_arrow

  # Print final selection visibly
  printf '  %s %s %s\n' "${G}" "✓" "${BOLD}${options[$current]}${RESET}" >&2
  echo "${options[$current]}"
}

confirm() {
  local prompt="$1" default="${2:-y}"
  local hint="Y/n"
  [[ "$default" == "n" ]] && hint="y/N"
  printf '%s' "${BOLD}${prompt}${RESET} ${DIM}${hint}${RESET}: " >&2
  local reply
  IFS= read -r reply || reply="$default"
  reply="${reply:-$default}"
  case "$reply" in y|Y|yes|Yes|YES) return 0;; *) return 1;; esac
}

copy_to_clipboard() {
  local text="$1"
  if command -v pbcopy &>/dev/null; then
    printf '%s' "$text" | pbcopy
    return 0
  elif command -v xclip &>/dev/null; then
    printf '%s' "$text" | xclip -selection clipboard
    return 0
  elif command -v xsel &>/dev/null; then
    printf '%s' "$text" | xsel --clipboard --input
    return 0
  elif command -v clip.exe &>/dev/null; then
    printf '%s' "$text" | clip.exe
    return 0
  fi
  return 1
}

sanitize_yaml() { echo "$1" | tr '"' "'" | tr '\n' ' '; }

normalize_path_input() {
  local value="$1"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  if [[ ${#value} -ge 2 ]]; then
    if [[ "${value:0:1}" == "'" && "${value: -1}" == "'" ]] || [[ "${value:0:1}" == '"' && "${value: -1}" == '"' ]]; then
      value="${value:1:${#value}-2}"
    fi
  fi
  echo "$value"
}

should_skip_source_file() {
  case "$1" in
    */.DS_Store|*/.gitkeep|*/node_modules/*|*/.git/*) return 0 ;;
    *) return 1 ;;
  esac
}

is_text_source_file() {
  local path="$1"
  local name ext
  name="$(basename "$path")"

  [[ "$name" == *.* ]] || return 1
  ext="${name##*.}"
  ext="$(printf '%s' "$ext" | tr '[:upper:]' '[:lower:]')"

  case "|$TEXT_EXTENSIONS|" in
    *"|$ext|"*) return 0 ;;
    *) return 1 ;;
  esac
}

markdown_raw_rel_path() {
  local rel_path="$1"
  local name dir stem ext
  name="$(basename "$rel_path")"
  dir="$(dirname "$rel_path")"

  ext="${name##*.}"
  ext="$(printf '%s' "$ext" | tr '[:upper:]' '[:lower:]')"

  if [[ "$ext" == "md" ]]; then
    echo "$rel_path"
    return
  fi

  stem="${name%.*}"
  if [[ "$dir" == "." ]]; then
    echo "${stem}__${ext}.md"
  else
    echo "${dir}/${stem}__${ext}.md"
  fi
}

# ── ASCII loader ────────────────────────────────────────────────────────────
loader_pid=""

loader_start() {
  local msg="$1"
  local frames=("⠁" "⠈" "⠐" "⠠" "⢀" "⡀" "⠄" "⠐")
  printf '\033[?25l' >&2
  (
    while true; do
      for f in "${frames[@]}"; do
        printf "\r  %s %s" "$f" "$msg" >&2
        sleep 0.1
      done
    done
  ) &
  loader_pid=$!
}

loader_stop() {
  if [[ -n "$loader_pid" ]]; then
    kill "$loader_pid" 2>/dev/null || true
    wait "$loader_pid" 2>/dev/null || true
    loader_pid=""
  fi
  printf "\r\033[2K\033[?25h" >&2
}

# ── transpose root vault text files into markdown raw copies ────────────────
copy_root_vault() {
  local vault_path="$1"
  local dest_dir="$2"

  local file_count=0
  while IFS= read -r -d '' f; do
    should_skip_source_file "$f" && continue
    is_text_source_file "$f" || continue
    file_count=$((file_count + 1))
  done < <(find "$vault_path" -type f -print0 2>/dev/null)

  if [[ "$file_count" -eq 0 ]]; then
    warn "No text-based files found in Root Vault."
    return 1
  fi

  # Print a persistent status line FIRST, then run the spinner BELOW it.
  # After the spinner stops, the status line remains visible alongside the success line.
  printf '\n  %sTransposing %d text files into markdown raw copies...%s\n' "${DIM}" "$file_count" "${RESET}"
  loader_start ""

  local copied=0 skipped=0

  while IFS= read -r -d '' src_file; do
    should_skip_source_file "$src_file" && continue
    is_text_source_file "$src_file" || continue

    local rel_path="${src_file#"$vault_path"/}"
    local raw_rel_path
    raw_rel_path="$(markdown_raw_rel_path "$rel_path")"
    local dest_file="$dest_dir/$raw_rel_path"
    local dest_parent
    dest_parent="$(dirname "$dest_file")"

    mkdir -p "$dest_parent"

    if [[ -f "$dest_file" ]]; then
      skipped=$((skipped + 1))
      continue
    fi

    cp "$src_file" "$dest_file"
    copied=$((copied + 1))
  done < <(find "$vault_path" -type f -print0 2>/dev/null)

  loader_stop

  local binary_count=0
  while IFS= read -r -d '' f; do
    should_skip_source_file "$f" && continue
    is_text_source_file "$f" && continue
    binary_count=$((binary_count + 1))
  done < <(find "$vault_path" -type f -print0 2>/dev/null)

  printf '  %s✓%s %sRoot vault transposed to%s %s%s%s\n' "${G}${BOLD}" "${RESET}" "${BOLD}" "${RESET}" "${C}${BOLD}" "${dest_dir}" "${RESET}"
  printf '  %s→%s %s markdown raw copies written\n' "${DIM}" "${RESET}" "${copied}"
  if [[ "$skipped" -gt 0 ]]; then
    printf '  %s→%s %s markdown raw copies skipped (already exist)\n' "${DIM}" "${RESET}" "$skipped"
  fi
  if [[ "$binary_count" -gt 0 ]]; then
    printf '  %s→%s %s non-text files (PDFs, images, etc.) left in original vault\n' "${DIM}" "${RESET}" "$binary_count"
  fi
  return 0
}

# ── overwrite check ─────────────────────────────────────────────────────────
has_filled_setup() {
  [[ -f "$Blueprint" && -f "$Config" ]] || return 1
  local b c
  b=$(<"$Blueprint")
  c=$(<"$Config")
  for ph in "[project name]" "[path]"; do
    [[ "$b" == *"$ph"* || "$c" == *"$ph"* ]] && return 1
  done
  return 0
}

# ── main ─────────────────────────────────────────────────────────────────────
main() {
  # Top-level cleanup: kill any running spinner, restore terminal, show cursor.
  cleanup_main() {
    if [[ -n "${loader_pid:-}" ]]; then
      kill "$loader_pid" 2>/dev/null || true
      wait "$loader_pid" 2>/dev/null || true
      loader_pid=""
    fi
    printf '\033[?25h' >&2
  }
  trap 'cleanup_main; printf "\n  Onboarding interrupted. Nothing was written.\n" >&2; exit 1' INT TERM
  trap 'cleanup_main' EXIT

  # parse flags
  for arg in "$@"; do
    case "$arg" in
      --force) FORCE="1" ;;
      --numbered) NUMBERED="1" ;;
      --no-color) R="" G="" B="" Y="" C="" M="" DIM="" BOLD="" RESET="" ;;
      --help|-h)
        printf '\n  %s\n\n' "${BOLD}LLM Zone Setup${RESET}"
        printf '  %s\n\n' "${DIM}Usage:${RESET} bash .bin/onboard.sh [--force] [--numbered] [--no-color]"
        printf '  %s\n\n' "${DIM}Flags:${RESET}"
        printf '    %-14s %s\n' "--force" "Overwrite existing setup data"
        printf '    %-14s %s\n' "--numbered" "Force numbered menu instead of arrow-key picker"
        printf '    %-14s %s\n' "--no-color" "Disable colored output"
        printf '\n  %s\n' "${DIM}Collects: project name, CLI preference, Root Vault path. The rest is gathered by your LLM CLI after the handoff.${RESET}"
        return 0
        ;;
    esac
  done

  # title
  printf '\n'
  printf '  %s\n' "${BOLD}${C}██████╗ ██╗██╗      ██████╗ ███████╗ █████╗ ${RESET}"
  printf '  %s\n' "${BOLD}${C}██╔══██╗██║██║     ██╔═══██╗██╔════╝██╔══██╗${RESET}"
  printf '  %s\n' "${BOLD}${C}██████╔╝██║██║     ██║   ██║███████╗███████║${RESET}"
  printf '  %s\n' "${BOLD}${C}██╔═══╝ ██║██║     ██║   ██║╚════██║██╔══██║${RESET}"
  printf '  %s\n' "${BOLD}${C}██║     ██║███████╗╚██████╔╝███████║██║  ██║${RESET}"
  printf '  %s\n' "${BOLD}${C}╚═╝     ╚═╝╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝${RESET}"
  printf '\n'
  divider
  printf '\n  %s  %s\n' "${BOLD}${C}LLM Zone${RESET}" "${DIM}Fast Setup${RESET}"
  printf '\n  %s\n' "${DIM}Three questions. Your LLM agent gathers the rest and runs indexing.${RESET}"
  divider

  if has_filled_setup && [[ "$FORCE" != "1" ]]; then
    printf '\n  %s Existing setup data found.\n' "${Y}${BOLD}⚠${RESET}"
    if ! confirm "  Overwrite?" "n"; then
      printf '\n  %s\n\n' "${DIM}No changes made. Use --force to overwrite.${RESET}"
      return 0
    fi
  fi

  # ── Question 1: project name ─────────────────────────────────────────────
  print_step 1 3 "Project name"
  note "This is the working title for your research framework."
  note "It appears at the top of every report and in the blueprint."
  note "You can change it later by editing 02_user_zone/RESEARCH_BLUEPRINT.md."
  project_title=""
  while [[ -z "$project_title" ]]; do
    project_title="$(ask "Project name" "" "e.g. My Research Project")"
    [[ -z "$project_title" ]] && printf '  %s\n' "${R}Project name is required.${RESET}" >&2
  done
  ok "Project: ${BOLD}${project_title}${RESET}"

  # ── Question 2: CLI preference ───────────────────────────────────────────
  print_step 2 3 "Preferred LLM CLI"
  note "Which CLI will you paste the startup prompt into?"
  note "You can change this later; the prompt is the same shape."
  preferred_cli="$(arrow_select "Preferred LLM CLI" "Claude Code" "Codex" "OpenCode" "Kilo" "Other")" || return 1
  ok "CLI: ${BOLD}${preferred_cli}${RESET}"

  # ── Question 3: Root Vault path ──────────────────────────────────────────
  print_step 3 3 "Root Vault"
  note "The Root Vault is the folder of your source files — PDFs, notes, transcripts, etc."
  note "Nothing is moved or renamed. We will copy text-based files into 01_llm_zone/raw/."
  note "Use an absolute path (drag the folder onto the terminal to paste its path)."
  root_vault_path=""
  while [[ -z "$root_vault_path" ]]; do
    root_vault_path="$(ask "Root Vault path (absolute)" "" "e.g. /Users/name/Documents/my-sources")"
    root_vault_path="$(normalize_path_input "$root_vault_path")"
    [[ -z "$root_vault_path" ]] && printf '  %s\n' "${R}Root Vault path is required.${RESET}" >&2
  done

  if [[ ! -d "$root_vault_path" ]]; then
    printf '\n  %s Root Vault path does not exist: %s\n\n' "${R}✗${RESET}" "$root_vault_path" >&2
    return 1
  fi
  ok "Root Vault: ${BOLD}${root_vault_path}${RESET}"

  # transpose accepted text-based files into markdown raw copies
  printf '\n'
  copy_root_vault "$root_vault_path" "$RawDir"
  printf '\n'

  # ── ensure directories exist ──────────────────────────────────────────────
  mkdir -p "$(dirname "$Blueprint")"
  mkdir -p "$(dirname "$Config")"

  # ── write blueprint ───────────────────────────────────────────────────────
  cat > "$Blueprint" << BLUEPRINT_EOF
---
type: research_blueprint
agent: setup_cli
created: $TODAY
updated: $TODAY
setup_status: cli_started
connects_to:
  - AGENTS.md
  - 00_system/instructions/ZONE_CONFIGURATION.md
  - 00_system/instructions/STARTUP.md
  - 03_logs/user_requests.md
---

# Research Blueprint

## Project
- Title: ${project_title:-[project name]}
- Description: [project description — to be gathered by the LLM CLI during startup]

## Project Artifacts
- [helpful artifact URLs or file paths, if any — to be gathered by the LLM CLI]

## Sources
- Root Vault path: ${root_vault_path:-[path]}
- Main source types: [inferred during startup from the Root Vault]
- Expected incoming sources: [inferred during startup]

## Research Vocabulary
- Key actors / institutions / places: [inferred during startup]
- Key concepts: [inferred during startup]
- Sensitizing concepts, not evidence: [inferred during startup]
- Theoretical frames, not forced labels: [inferred during startup]

## Method And Evidence
- Methods: [inferred during startup]
- Claims require source paths.
- L2 clues require Checker verification before reporting.
- External sources must stay labeled external unless moved into the Root Vault.
- External source policy: no (LLM will confirm with the user during startup)

## Outputs
- Start with folder mirror indexes and evidence-grounded answers unless the researcher requests another output.

## Blind Spots
- [identified during startup]

## Researcher Preferences
[stated or inferred during startup]

## Preferred LLM CLI
$preferred_cli
BLUEPRINT_EOF

  # ── write config ──────────────────────────────────────────────────────────
  local safe_vault
  safe_vault="$(sanitize_yaml "$root_vault_path")"

  cat > "$Config" << CONFIG_EOF
---
type: zone_configuration
agent: setup_cli
created: $TODAY
updated: $TODAY
setup_status: cli_started
---

# Zone Configuration

Agents read this before major work.

\`\`\`yaml
zone_type: research_framework
research_mode: evolving_complex_corpus
root_vault_path: "$safe_vault"
root_vault_mode: protected_append_only

source_policy: internal_first
external_sources_allowed: no
external_logs:
  - 03_logs/external_queries.md
  - 03_logs/source_intake_log.md

claim_standard: source_link_required
l2_policy: checker_required

protected_paths:
  - "$safe_vault"
  - 02_user_zone/

stale_after_days: 30
preferred_llm_cli: "$preferred_cli"
\`\`\`

## Notes
- This file was initialized by the CLI fast setup.
- The CLI collected: project name, Root Vault path, preferred LLM CLI. Raw copies are transposed into 01_llm_zone/raw/ under the same path.
- The LLM CLI agent must gather the remaining fields during startup: project description, helpful artifact URLs, external source policy. Then update both this file and [[RESEARCH_BLUEPRINT]] accordingly.
- When setup_status reaches zone_started, the Startup sub-agent has built the master dictionary, generated YAML headers, created folder index.md files, and built concept indexes.
- This file never grants permission to edit the Root Vault.
CONFIG_EOF

  # ── create aggregator if missing ──────────────────────────────────────────
  local agg_created="no"
  if [[ ! -f "$Aggregator" && -f "$AggregatorTemplate" ]]; then
    sed "s/created: \[date\]/created: $TODAY/; s/updated: \[date\]/updated: $TODAY/" \
      "$AggregatorTemplate" > "$Aggregator"
    agg_created="yes"
  fi

  # ── create CLAUDE.md if preferred CLI is Claude Code ──────────────────────
  local claude_created="no"
  if [[ "$preferred_cli" == "Claude Code" && -f "$Agents" ]]; then
    cp "$Agents" "$Claude"
    claude_created="yes"
  fi

  # ── success ───────────────────────────────────────────────────────────────
  printf '\n'
  divider
  printf '\n  %s\n\n' "${G}${BOLD}✦ Setup files written${RESET}"
  printf '  %s %s\n' "${DIM}─${RESET}" "${C}${Blueprint}${RESET}"
  printf '  %s %s\n' "${DIM}─${RESET}" "${C}${Config}${RESET}"
  [[ "$agg_created" == "yes" ]] && printf '  %s %s\n' "${DIM}─${RESET}" "${C}${Aggregator}${RESET}"
  [[ "$claude_created" == "yes" ]] && printf '  %s %s\n' "${DIM}─${RESET}" "${C}${Claude}${RESET}"

  printf '\n  %s\n\n' "${BOLD}Next:${RESET}"

  local startup_prompt
  startup_prompt=$(cat <<PROMPT_EOF
This is the LLM Zone startup handoff. The user has completed fast CLI setup.

Read these files first, in this order:
1. AGENTS.md
2. 00_system/instructions/ZONE_CONFIGURATION.md
3. 02_user_zone/RESEARCH_BLUEPRINT.md
4. 00_system/instructions/STARTUP.md
5. 00_system/sub_agents/startup/SOUL.md

The setup draft already contains:
- Project name: ${project_title}
- Root Vault path: ${root_vault_path} (already validated, files transposed into 01_llm_zone/raw/)
- Preferred LLM CLI: ${preferred_cli}

Still missing (ask the user, ONE question at a time, then update both files):
- Project description
- Helpful artifact URLs or file paths (optional)
- External source policy (default is no — confirm or change)

Then execute 00_system/instructions/STARTUP.md from Phase 1.2 onwards. Specifically:
- Translate the setup draft into filled blueprint + config
- Build the master dictionary by reading all transposed raw copies
- Generate YAML headers for every raw copy using the dictionary
- Create an index.md in every folder under 01_llm_zone/raw/ that reconstructs the folder contents and summarizes each raw copy
- Build concept indexes from repeated themes
- Update 01_llm_zone/00_zone_index.md
- Run the retrieval smoke test
- Set setup_status to zone_started in both blueprint and config
- Write the startup report to 05_agent_reports/ using 00_system/templates/STARTUP_REPORT_TEMPLATE.md

Do not re-ask questions the CLI draft already answered. Do not stop after one index. Do not edit the Root Vault.
PROMPT_EOF
  )

  # Present the prompt in a clearly demarcated block.
  if copy_to_clipboard "$startup_prompt"; then
    clipboard_status="copied to your clipboard"
    note "Just open your LLM CLI in this folder and paste (Cmd-V / Ctrl-V)."
  else
    clipboard_status="not copied (no clipboard tool found) — select and copy from the block below"
    note "Click and drag to select the block, then Cmd-C / Ctrl-C."
  fi
  print_box "LLM Zone Startup Prompt — ${clipboard_status}" <<< "$startup_prompt"
  printf '\n'
  divider
  printf '\n'
}

main "$@"
