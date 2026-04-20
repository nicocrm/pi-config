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
- **Prompts**: prompt templates (see workflow below)
- **Agents**: Bedrock-compatible overrides for all pi-subagents builtins (scout, planner, worker, reviewer, context-builder, delegate, researcher)
- **Chains**: `implement-and-review` (worker → reviewer → worker)

## Plan → Implement → Review Workflow

The typical loop:

1. **Scout & plan** — `/scout-and-plan <topic>` produces a plan file under `docs/plans/YYYY-MM-DD-*.md`.
2. **Review the plan** yourself, tweak if needed.
3. **Implement with review** — invoke one of the prompt templates below. The main agent infers the plan from conversation or the newest file in `docs/plans/` (asking to confirm if ambiguous), then runs the `implement-and-review` chain via the subagent tool:
   - `/implement-and-review` — sets up an isolated git worktree first (via the `using-git-worktrees` skill), then worker implements → reviewer reviews → worker applies feedback.
   - `/implement-and-review-here` — same chain, but stays on the current branch (no worktree). Use for quick changes or when you've already set up a workspace.
4. **Finish** — after the chain returns, the main agent invokes the `finishing-a-development-branch` skill (driven by the prompt template) to verify tests and present merge/PR/cleanup options. Finishing runs in the main session, not inside the chain, so it can interact with you.

Other prompt templates:

- `/implement` — single-agent implementation, no review step.
- `/review` — run the reviewer on current changes.
- `/readonly`, `/clip` — utility prompts.
