# pi-config

Configuration for [pi coding agent](https://pi.dev).

## Install

```bash
pi install git:github.com/nicocrm/pi-config
```

Agent definitions are automatically symlinked into `~/.pi/agent/agents/` on session start via the `sync-agents` extension.

## Upgrading Bundled Extensions

To upgrade `pi-subagents`:

```bash
cd ~/.pi/packages/pi-config
npm update pi-subagents
```

## What's Included

- **Extensions**: notification, permission gate, plan mode, questionnaire, agent sync (+ pi-subagents)
- **Skills**: custom skill definitions
- **Prompts**: prompt templates
- **Agents**: Bedrock-compatible overrides for all pi-subagents builtins (scout, planner, worker, reviewer, context-builder, delegate, researcher)
