---
type: constraints
role: markdown_formatting_rules
purpose: [define Obsidian-compatible markdown rules for all agent-written reports]
scope: [05_agent_reports/, 01_llm_zone/]
connects_to:
  - AGENTS.md
  - 00_system/sub_agents/packer/SOUL.md
created: 2026-05-28
updated: 2026-06-02
---

# Obsidian Markdown Constraints

All reports and agent-written files in [[05_agent_reports/]] and [[01_llm_zone/]] must use **Obsidian-compatible markdown**. This ensures the LLM Zone can be opened and navigated as an Obsidian vault.

## Allowed Features

### Structure
- **YAML frontmatter** (required for all files)
- Headings (`#`, `##`, `###`)
- Tables (GFM syntax)
- Horizontal rules (`---`)

### Text Formatting
- **Bold** (`**text**`)
- *Italic* (`*text*`)
- ~~Strikethrough~~ (`~~text~~`)
- ==Highlights== (`==text==`)
- `Inline code` (`` `code` ``)
- Code blocks (triple backticks with language)

### Links
- **Wikilinks** to other notes: `[[Note Name]]`
- Wikilinks with display text: `[[Note Name|display text]]`
- Standard markdown links for external URLs: `[text](url)`

### Lists
- Bullet lists (`- item`)
- Numbered lists (`1. item`)
- Task lists (`- [ ]` unchecked, `- [x]` checked)

### Blockquotes
- Standard blockquotes (`> text`)
- Multi-paragraph blockquotes

### Embeds
- Note embeds: `![[Note Name]]`
- Section embeds: `![[Note Name#Heading]]`

## Disallowed Features

| Feature | Syntax | Why |
|---|---|---|
| Binary embeds | `![[image.png]]` | Breaks portability, large files |
| Block references | `^block-id` | Fragile, tool-dependent |
| Custom CSS classes | `cssclasses` | Not portable |
| Obsidian-only callout types | `> [!bug]`, `> [!success]` | Use only GitHub-compatible types |
| HTML elements | `<div>`, `<span>` | Obsidian does not render markdown inside HTML |

## Allowed Callout Types

Use only callout types that render on **both Obsidian and GitHub**:

```markdown
> [!note] Title
> Content

> [!tip] Title
> Content

> [!warning] Title
> Content

> [!info] Title
> Content

> [!quote] Title
> Content

> [!example] Title
> Content
```

Foldable callouts (Obsidian-only, but harmless on GitHub):
```markdown
> [!note]- Folded title
> Content hidden by default
```

## Verbatim Quote Format

When featuring direct quotes from sources, **always** use:

```markdown
> **Author Name**, *Source Title* (Date, Place)
>
> "Text with **the important part in bold** and enough context to understand the quote without opening the source."
```

## Frontmatter Schema

Every agent-written file must start with **YAML frontmatter**:

```yaml
---
type: [report | raw_copy | raw_folder_index | concept_index | dictionary | ...]
created: YYYY-MM-DD
updated: YYYY-MM-DD
status: [draft | verified | partial]
---
```

Additional fields as needed by file type (see `HEADER_TEMPLATE.md`).

## Linking Conventions

- Link to raw copies using **wikilinks**: `[[raw_copy_name]]`
- Link to concept indexes: `[[Concept Name]]`
- Link to dictionary entries: `[[00_dictionary]]`
- External URLs use standard markdown links
- **Never** use relative paths for internal links

### Wikilink Form (Framework Files)

In the framework (`AGENTS.md`, `README.md`, `GLOSSARY.md`, [[00_system/]], [[01_metadata/]]), body text uses **short-form wikilinks**:

- Files with unique basenames use just the basename: `[[AGENTS]]`, `[[STARTUP]]`, `[[ZONE_CONFIGURATION]]`, `[[HEADER_TEMPLATE]]`, `[[dictionary]]`, `[[zone_index]]`
- Sub-agent `SOUL.md` files (six of them) include the folder prefix for disambiguation: `[[conceptualizer|SOUL]]`, `[[navigator|SOUL]]`, `[[packer|SOUL]]`, `[[checker|SOUL]]`, `[[cleaner|SOUL]]`, `[[startup|SOUL]]`
- Folders keep their full vault-relative path with trailing `/`: `[[00_system/]]`, `[[01_llm_zone/]]`, `[[02_user_zone/]]`, `[[03_logs/]]`, `[[05_agent_reports/]]`, `[[.trash/]]`, `[[raw/]]`, `[[02_user_zone/]]`
- `.md` extension is implicit (Obsidian convention)

**Frontmatter exception:** `connects_to:` and other YAML keys use **bare paths** (not wikilinks). This keeps the metadata machine-readable, grep-friendly, and stable for sub-agents to parse. Wikilink aliasing in YAML is fragile.

**Bare paths shown in code (`backticks`)** are acceptable for **illustrative patterns** like `[[00_system/]]sub_agents/*/SOUL.md` (wildcard) or `[[00_system/]]sub_agents/<name>/SOUL.md` (placeholder). These describe a pattern, not a specific file, and should not be converted.
