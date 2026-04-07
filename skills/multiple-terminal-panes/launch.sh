#!/usr/bin/env bash
# Launch a new pi instance in a Zellij floating pane
# Usage: launch.sh <pane-name> <working-directory> "<prompt>" [pi-flags...]
# Extra args after the prompt are passed as flags to pi (e.g. --thinking high)
set -euo pipefail

# Validate arguments
if [ $# -lt 3 ]; then
  echo "Usage: launch.sh <pane-name> <working-directory> '<prompt>' [pi-flags...]" >&2
  echo "Example: launch.sh 'my-task' '/path/to/project' 'Implement feature X' --thinking high" >&2
  exit 1
fi

PANE_NAME="$1"
CWD="$2"
PROMPT="$3"
shift 3
PI_FLAGS=("$@")

# Validate environment
if [ -z "${ZELLIJ:-}" ]; then
  echo "ERROR: Not inside a Zellij session. Please run this from within Zellij." >&2
  exit 1
fi

# Validate working directory
if [ ! -d "$CWD" ]; then
  echo "ERROR: Working directory '$CWD' does not exist" >&2
  exit 1
fi

# Check if pi command exists
if ! command -v pi &> /dev/null; then
  echo "ERROR: 'pi' command not found in PATH" >&2
  exit 1
fi

echo "Launching pi in floating pane '$PANE_NAME' at '$CWD'..."

# Handle empty PI_FLAGS array safely
if [ ${#PI_FLAGS[@]} -eq 0 ]; then
  if zellij run \
    --name "$PANE_NAME" \
    --floating \
    --cwd "$CWD" \
    -- pi "$PROMPT"; then
    echo "✅ Successfully launched pi in floating pane '$PANE_NAME'"
  else
    echo "❌ Failed to launch pi in pane '$PANE_NAME'" >&2
    exit 1
  fi
else
  echo "Using pi flags: ${PI_FLAGS[*]}"
  if zellij run \
    --name "$PANE_NAME" \
    --floating \
    --cwd "$CWD" \
    -- pi "${PI_FLAGS[@]}" "$PROMPT"; then
    echo "✅ Successfully launched pi in floating pane '$PANE_NAME' with flags"
  else
    echo "❌ Failed to launch pi in pane '$PANE_NAME'" >&2
    exit 1
  fi
fi
