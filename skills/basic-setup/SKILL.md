---
name: basic-setup
description: Scaffold the user's standard project structure. Use when the user starts a new project, when coding is about to begin in an empty folder, or when the user asks to check a project against their structure.
---

# Basic setup

`scripts/scaffold.sh` in this skill's folder does the creating. It adds what is missing and leaves every existing file as it is.

## 1. Choose the language

Go, unless performance, a needed library or a hard limitation gives a meaningful reason to switch. Preference order: Go, Rust, Python, C++, others. Raise the reason, and any case for mixing languages, before step 2. For anything except Go, read [LANGUAGES.md](LANGUAGES.md).

## 2. Preview

Run:

```
bash <skill folder>/scripts/scaffold.sh --plan --lang go <project folder>
```

Use `--lang none` for other languages. Show the user the result, including any language exception, and wait for their OK.

If `EXTRA` entries show a project that already has a different layout, report the differences and stop there: the user decides what, if anything, changes.

## 3. Create

After the OK, run the same command with `--apply` in place of `--plan`. For other languages, then add the starting files from LANGUAGES.md.

The step is done when every `WARN` line has been shown to the user with a proposed fix. Edit an existing file only after they accept that fix.

## 4. Fill in what is known

Replace the bracketed prompts in `README.md`, `CLAUDE.md` and `DESIGN.md` with what the user has already said, and keep the rest as prompts. Leave the first commit to the user.
