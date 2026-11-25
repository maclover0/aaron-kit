# aaron-kit

Personal skills for Claude Code, packaged as a plugin and its own marketplace.

## Install

### For every sandbox

Clone into the shared skills store of Docker Sandboxes, on the host. Sandboxes mount it read-only, and Claude Code loads the plugin from there, hook included.

macOS:

```
git clone git@github.com:maclover0/aaron-kit.git "$HOME/Library/Application Support/com.docker.sandboxes/sandboxes/agent-skills/aaron-kit"
```

Windows (PowerShell):

```
git clone https://github.com/maclover0/aaron-kit.git "$env:LOCALAPPDATA\DockerSandboxes\sandboxes\state\agent-skills\aaron-kit"
```

Linux:

```
git clone git@github.com:maclover0/aaron-kit.git "${XDG_STATE_HOME:-$HOME/.local/state}/sandboxes/sandboxes/agent-skills/aaron-kit"
```

Update with `git pull` in that folder. `sbx reset` clears the store; clone again after it. Use a plain clone, as `sbx skills add` picks out individual skills.

In each new sandbox, inside Claude Code:

```
/plugin install mattpocock-skills@claude-plugins-official
```

### Without a sandbox

Use this or the shared store, as both together load the plugin twice.

```
/plugin marketplace add maclover0/aaron-kit
/plugin install aaron-kit@aaron-kit
/plugin install mattpocock-skills@claude-plugins-official
```

## Skills

- `/aaron-kit:basic-setup`: creates the standard project structure with Docker Compose, or Kubernetes on request. Previews first and never overwrites.
- `/aaron-kit:design-steps`: turns a raw idea into a plan in `DESIGN.md`, starting from its data sources and visuals.
- `/aaron-kit:resourcing`: token, stack, testing, commit message and skill-choice preferences. A session-start hook loads it automatically.

## Layout

- `.claude-plugin/`: marketplace and plugin manifests
- `hooks/`: the session-start hook
- `skills/<skill-name>/SKILL.md`: one directory per skill

Edit a preference in `skills/resourcing/SKILL.md`; the hook reads that same file.
