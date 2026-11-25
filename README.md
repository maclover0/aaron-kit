# aaron-kit

Personal skills for Claude Code, packaged as a plugin and its own marketplace.

## Install

```
/plugin marketplace add <github-owner>/<repo>
/plugin install aaron-kit@aaron-kit
/plugin install mattpocock-skills@claude-plugins-official
```

## Skills

- `/aaron-kit:basic-setup`: creates the standard project structure. Previews first and never overwrites.
- `/aaron-kit:design-steps`: turns a raw idea into a plan in `DESIGN.md`, starting from its data sources and visuals.
- `/aaron-kit:resourcing`: token, testing and skill-choice preferences. A session-start hook loads it automatically.

## Layout

- `.claude-plugin/`: marketplace and plugin manifests
- `hooks/`: the session-start hook
- `skills/<skill-name>/SKILL.md`: one directory per skill

Edit a preference in `skills/resourcing/SKILL.md`; the hook reads that same file.
