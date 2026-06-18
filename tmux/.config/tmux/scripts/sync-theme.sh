#!/bin/bash
# Set catppuccin flavor to match the current macOS appearance.
# Dark mode -> mocha, Light mode -> latte. Idempotent: only acts on change.
set -euo pipefail

# launchd gives a minimal PATH; ensure Homebrew (tmux) and ~/.local/bin (herdr)
# are reachable.
export PATH="${HOME}/.local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"

FLAVOR_FILE="${HOME}/.config/tmux/flavor.conf"
TMUX_CONF="${HOME}/.tmux.conf"

# Read appearance via AppleScript (authoritative; `defaults read` is cached
# per-process by cfprefsd and goes stale in long-lived daemons).
if [ "$(osascript -e 'tell app "System Events" to tell appearance preferences to get dark mode' 2>/dev/null)" = "true" ]; then
  want="mocha"                    # tmux: dark
  cc_theme="dark-daltonized"      # Claude Code: dark
  herdr_theme="catppuccin"        # herdr: dark
else
  want="latte"                    # tmux: light
  cc_theme="light-daltonized"     # Claude Code: light
  herdr_theme="catppuccin-latte"  # herdr: light
fi

# Keep Claude Code's theme in sync with macOS appearance. `auto` only toggles
# plain light/dark, so we set the theme explicitly to stay on the daltonized
# variants. Atomic jq write preserves all other settings keys. Only acts on
# change. (Applies on Claude Code's next read of settings.json.)
CC_SETTINGS="${HOME}/.claude/settings.json"
if command -v jq >/dev/null 2>&1 && [ -f "$CC_SETTINGS" ]; then
  cc_current="$(jq -r '.theme // empty' "$CC_SETTINGS" 2>/dev/null || echo '')"
  if [ "$cc_current" != "$cc_theme" ]; then
    tmp="$(mktemp)"
    if jq --arg t "$cc_theme" '.theme = $t' "$CC_SETTINGS" > "$tmp" 2>/dev/null \
       && jq empty "$tmp" 2>/dev/null; then
      mv "$tmp" "$CC_SETTINGS"
    else
      rm -f "$tmp"
    fi
  fi
fi

# Keep herdr's theme in sync. herdr names its catppuccin variants "catppuccin"
# (dark) and "catppuccin-latte" (light). Rewrite the name under [theme] and ask
# the running server to hot-reload. Only acts on change.
HERDR_CONF="${HOME}/.config/herdr/config.toml"
if command -v herdr >/dev/null 2>&1 && [ -f "$HERDR_CONF" ]; then
  herdr_current="$(awk '/^\[theme\]/{f=1;next} f&&/^name *=/{gsub(/[" ]/,"");sub(/^name=/,"");print;exit} /^\[/{f=0}' "$HERDR_CONF")"
  if [ "$herdr_current" != "$herdr_theme" ]; then
    # Replace the first `name = "..."` after the [theme] header only.
    htmp="$(mktemp)"
    awk -v t="$herdr_theme" '
      /^\[theme\]/{f=1; print; next}
      f && /^name *=/{print "name = \"" t "\""; f=0; next}
      /^\[/{f=0}
      {print}
    ' "$HERDR_CONF" > "$htmp" && mv "$htmp" "$HERDR_CONF" || rm -f "$htmp"
    herdr server reload-config >/dev/null 2>&1 || true
  fi
fi

# Persist for restarts / manual toggle consistency.
cat > "$FLAVOR_FILE" <<EOF
# Catppuccin flavor state (auto-synced to macOS appearance; prefix+B toggles)
set -g @catppuccin_flavor "${want}"
EOF

# Apply to the running server only if one exists and the flavor actually changed.
if tmux info >/dev/null 2>&1; then
  current="$(tmux show -gv @catppuccin_flavor 2>/dev/null || echo '')"
  if [ "$current" != "$want" ]; then
    # catppuccin caches its palette (@thm_*) AND derived module colors
    # (@catppuccin_*) with `set -ogq` (only-if-unset), so they lock on first
    # load. Clear both so the new flavor's colors fully recompute on re-source.
    for v in $(tmux show -g 2>/dev/null | awk '/^@(thm_|catppuccin_)/{print $1}'); do
      tmux set -gu "$v"
    done
    tmux source-file "$TMUX_CONF"
  fi
fi
