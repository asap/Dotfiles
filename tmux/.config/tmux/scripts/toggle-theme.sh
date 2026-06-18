#!/bin/bash
# Toggle catppuccin flavor between mocha (dark) and latte (light).
# Persists choice to ~/.config/tmux/flavor.conf and reloads tmux config.
set -euo pipefail

FLAVOR_FILE="${HOME}/.config/tmux/flavor.conf"
TMUX_CONF="${HOME}/.tmux.conf"

current="$(tmux show -gv @catppuccin_flavor 2>/dev/null || echo mocha)"

if [ "$current" = "latte" ]; then
  next="mocha"   # dark
  label="dark"
else
  next="latte"   # light
  label="light"
fi

cat > "$FLAVOR_FILE" <<EOF
# Catppuccin flavor state (toggled by prefix+B via toggle-theme.sh)
set -g @catppuccin_flavor "${next}"
EOF

# catppuccin caches its palette (@thm_*) AND derived module colors
# (@catppuccin_*) with `set -ogq` (only-if-unset), so they lock on first load.
# Clear both families so the new flavor's colors fully recompute on re-source.
for v in $(tmux show -g 2>/dev/null | awk '/^@(thm_|catppuccin_)/{print $1}'); do
  tmux set -gu "$v"
done

tmux source-file "$TMUX_CONF"
tmux display-message "theme: ${label} (${next})"
