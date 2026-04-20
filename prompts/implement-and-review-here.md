---
description: Implement the current plan with review, in the current branch (no worktree)
---
Invoke the `implement-and-review` chain via the subagent tool (use `chainName: "implement-and-review"`).

For the task parameter:
1. Identify the plan file. Prefer, in order:
   a. A plan path explicitly mentioned in this conversation or in $@
   b. The most recently modified file under `docs/plans/` (excluding `docs/plans/implemented/`)
2. If there is more than one plausible candidate, list them and ask me to confirm before invoking the chain.

Compose the task string as:

```
Plan: <resolved plan path>

Work in the current branch; do not create a git worktree.
```

Then invoke the chain.

After the chain completes, use `/skill:finishing-a-development-branch` to wrap up the work (verify tests, present merge/PR/cleanup options, execute the choice).
