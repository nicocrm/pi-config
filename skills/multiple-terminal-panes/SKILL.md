---
name: multiple-terminal-panes
description: Launch a new pi coding agent instance in a separate terminal pane using Zellij and send it a command. Use when the user wants to delegate work (e.g. implementing a plan) to a new pi instance running in parallel.
---

# Zellij Pi Launcher

Launches a new pi instance in a separate Zellij pane so work happens there, not in the current session.

## Usage

```bash
bash <skill-dir>/launch.sh "<pane-name>" "<working-directory>" "<prompt>" [pi-flags...]
```

Where `<skill-dir>` is the directory containing this SKILL.md (resolve relative paths against it).

Any arguments after the prompt are passed as flags to `pi` (e.g. `--thinking high`).

## Requirements

- Must be run inside a Zellij session
- Working directory must exist
- `pi` command must be available in PATH

## Error Handling

- Validates all arguments and environment before launching
- Provides clear error messages for common issues
- Handles empty pi-flags arrays safely (fixed bash array expansion issue)
- Reports success/failure with emoji indicators

### Examples

**Implement a plan:**
```bash
bash <skill-dir>/launch.sh "implement-plan" "/path/to/project" "Read docs/plans/2026-03-19-my-plan.md and implement it. Follow all instructions in the plan."
```

**Run with high thinking:**
```bash
bash <skill-dir>/launch.sh "review" "/path/to/project" "Review the code thoroughly." --thinking high
```

**Run any task:**
```bash
bash <skill-dir>/launch.sh "refactor" "/path/to/project" "Refactor the auth module to use JWT tokens"
```

## Important

- The new pi instance runs interactively in a floating pane.
- Do NOT attempt to implement the plan yourself. Your job is only to launch the new pane.
- After launching, confirm to the user that the new pane has been created.
- The prompt sent to pi should be self-contained: include file paths, context, and clear instructions since the new instance has no conversation history.
