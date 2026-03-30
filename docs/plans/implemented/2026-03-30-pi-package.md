# Make pi-config installable as a pi package

## Goal
Turn this repo into a self-contained pi package installable via `pi install git:github.com/nicocrm/pi-config`.

## Proposed Changes

1. **Remove `extensions/subagent/`** — delete the symlinked files, replace with `pi-subagents` as a dependency
   - Add `pi-subagents` to `dependencies` + `bundledDependencies` in `package.json`
   - Reference its extensions via `node_modules/pi-subagents` in the `pi` manifest

2. **Add `package.json`** (root)
   ```json
   {
     "name": "pi-config",
     "version": "1.0.0",
     "keywords": ["pi-package"],
     "dependencies": {
       "pi-subagents": "^0.11.12"
     },
     "bundledDependencies": ["pi-subagents"],
     "pi": {
       "extensions": [
         "./extensions",
         "node_modules/pi-subagents"
       ],
       "skills": ["./skills"],
       "prompts": ["./prompts"]
     }
   }
   ```

3. **Update `agents/` with pi-subagents builtins** — copy builtin agent `.md` files from pi-subagents, replacing model IDs with Bedrock equivalents:
   - `scout.md` — `anthropic/claude-haiku-4-5` → `us.anthropic.claude-haiku-4-5-20251001-v1:0`
   - `planner.md` — `claude-opus-4-6` → `us.anthropic.claude-opus-4-6-v1`
   - `worker.md` — `claude-sonnet-4-6` → `us.anthropic.claude-sonnet-4-6`
   - `reviewer.md` — keep existing detailed checklist prompt (read-only, structured feedback for worker handoff), but add chain-aware fields from builtin: `thinking: high`, `defaultReads: plan.md, progress.md`, `defaultProgress: true`
   - Also copy `context-builder.md`, `delegate.md`, `researcher.md` if desired (or leave as builtins)

   These agents live in `agents/` but pi-subagents discovers them from `~/.pi/agent/agents/`. Users must symlink/copy after install. Document in README.

4. **Update `README.md`** — document install command and the agents setup step

## Open Questions
- None remaining. All builtin agents use non-Bedrock model IDs, so we must override all of them (except `delegate` which inherits parent model). Full model mapping:
  - `anthropic/claude-haiku-4-5` → `us.anthropic.claude-haiku-4-5-20251001-v1:0`
  - `claude-opus-4-6` → `us.anthropic.claude-opus-4-6-v1`
  - `claude-sonnet-4-6` / `anthropic/claude-sonnet-4-6` → `us.anthropic.claude-sonnet-4-6`
  - `openai-codex/gpt-5.3-codex` → `us.anthropic.claude-opus-4-6-v1`
  - `context-builder.md` and `researcher.md` also need overrides (both use sonnet)
