---
name: basic-setup
description: Scaffold the user's standard project structure. Use when the user starts a new project, when coding is about to begin in an empty folder, or when the user asks to check a project against their structure.
---

# Basic setup

`scripts/scaffold.sh` in this skill's folder does the creating. It adds what is missing and leaves every existing file as it is.

## 1. Choose the stack

Choose the language and containers by the Stack rules in `../resourcing/SKILL.md`. For anything except Go, read [LANGUAGES.md](LANGUAGES.md).

## 2. Preview

Run:

```
bash <skill folder>/scripts/scaffold.sh --plan --lang go --containers compose <project folder>
```

Use `--lang none` for other languages, and `--containers k8s` (Compose plus `k8s/`) or `none` when step 1 chose it. Show the user the result, including any language exception, and wait for their OK.

If `EXTRA` entries show a project that already has a different layout, report the differences and stop there: the user decides what, if anything, changes.

## 3. Create

After the OK, run the same command with `--apply` in place of `--plan`. For other languages, then add the starting files from LANGUAGES.md.

The step is done when every `WARN` line has been shown to the user with a proposed fix. Edit an existing file only after they accept that fix.

## 4. Fill in what is known

Replace the bracketed prompts in `README.md`, `CLAUDE.md` and `DESIGN.md` with what the user has already said, and keep the rest as prompts. Without containers, replace the Docker commands in `README.md` and `CLAUDE.md`. Leave the first commit to the user.
