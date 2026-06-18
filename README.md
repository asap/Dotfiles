# Dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level
directory is a *package* that mirrors `$HOME`.

## Setup

```sh
git clone git@github.com:asap/Dotfiles.git ~/dotfiles
cd ~/dotfiles
stow tmux nvim ghostty   # symlink packages into $HOME
```

## Packages

| Package   | Symlinks                                                        |
|-----------|----------------------------------------------------------------|
| `tmux`    | `~/.tmux.conf`, `~/.config/tmux/scripts`, theme-sync LaunchAgent |
| `nvim`    | `~/.config/nvim`                                                |
| `ghostty` | Ghostty `config` under `~/Library/Application Support`          |

## macOS appearance → theme auto-sync

A LaunchAgent watches the macOS light/dark setting and switches the theme of
tmux, Claude Code, and herdr to match:

| macOS | tmux (catppuccin) | Claude Code      | herdr            |
|-------|-------------------|------------------|------------------|
| Light | `latte`           | `light-daltonized` | `catppuccin-latte` |
| Dark  | `mocha`           | `dark-daltonized`  | `catppuccin`       |

- `prefix + B` manually toggles the tmux theme (system change reasserts auto).
- Scripts live in `tmux/.config/tmux/scripts/`; the agent in
  `tmux/Library/LaunchAgents/com.alexs.tmux-theme-sync.plist`.

### Activate the watcher (once per machine)

`stow tmux` symlinks the plist, but launchd still needs to load it:

```sh
launchctl load ~/Library/LaunchAgents/com.alexs.tmux-theme-sync.plist
```

To stop or reload it:

```sh
launchctl unload ~/Library/LaunchAgents/com.alexs.tmux-theme-sync.plist
launchctl load   ~/Library/LaunchAgents/com.alexs.tmux-theme-sync.plist
```

> Note: `~/.config/tmux/flavor.conf` is runtime state (not tracked). Claude
> Code's `~/.claude/settings.json` and herdr's `~/.config/herdr/config.toml`
> are rewritten live by the watcher, so they are intentionally not stowed.
