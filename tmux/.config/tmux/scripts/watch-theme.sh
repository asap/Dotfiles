#!/bin/bash
# Poll macOS appearance and sync the tmux catppuccin flavor on change.
# Run by the com.alexs.tmux-theme-sync LaunchAgent. Lightweight: a defaults
# read every few seconds, only invoking sync-theme.sh when the mode flips.
set -uo pipefail

# launchd gives a minimal PATH; ensure Homebrew (tmux) and ~/.local/bin (herdr)
# are reachable.
export PATH="${HOME}/.local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"

SYNC="${HOME}/.config/tmux/scripts/sync-theme.sh"
INTERVAL=3
last=""

while true; do
  if [ "$(osascript -e 'tell app "System Events" to tell appearance preferences to get dark mode' 2>/dev/null)" = "true" ]; then
    now="dark"
  else
    now="light"
  fi
  if [ "$now" != "$last" ]; then
    "$SYNC" || true
    last="$now"
  fi
  sleep "$INTERVAL"
done
