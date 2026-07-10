# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Synapse is a **dotfiles payload + lifecycle installer** that turns a stock terminal + Neovim setup into an "AI terminal." There is no application code, build system, or unit-test framework — the repo's "tests" are a shell-based CI that exercises the installer's setup→remove lifecycle. Treat changes to config files as edits to user-facing dotfiles, not library code.

## Common commands

Lifecycle (run from repo root). The installer copies dotfiles into `$HOME`; it does **not** symlink:

```bash
zsh skills/synapse/scripts/synapse.zsh --setup     # install dotfiles + deps (default if no flag)
zsh skills/synapse/scripts/synapse.zsh --remove    # revert to latest backup, then delete all backups
```

Validate a change the way CI does (`.github/workflows/validate.yml` is the canonical test):

```bash
# On a clean box with zsh + tmux + neovim installed:
./skills/synapse/scripts/synapse.zsh --setup
nvim --headless +qa                                # config must load without error
./skills/synapse/scripts/synapse.zsh --remove
# then assert the pre-existing dummy files were restored
```

Neovim-specific (run inside nvim or headless):

```bash
nvim --headless "+Lazy! sync" +qa                  # bootstrap/sync plugins (also auto-run by --setup)
```

Format Lua (`.stylua.toml` lives in `dot/.config/nvim/` — 2-space indent, single quotes, no call parens, width 160):

```bash
stylua dot/.config/nvim/
```

Tmux reload after editing `dot/.tmux.conf`: `tmux source ~/.tmux.conf` (or prefix + `r`).

## Architecture

**Lifecycle installer — `skills/synapse/scripts/synapse.zsh`.** This is the core of the repo. It locates the project root via `PROJECT_ROOT=$(cd "$SCRIPT_DIR/../../.." && pwd)`, so the script's path **must** stay at `<root>/skills/synapse/scripts/synapse.zsh` — moving it breaks root detection. Setup walks `dot/` and copies every entry into `$HOME`, with special handling: contents of `dot/.config/*` deploy into `~/.config/*` rather than `~/.config/`. Exception: `dot/.config/herdr/` deploys **file-by-file** (each file -> `~/.config/herdr/<file>`), because herdr keeps runtime state (sockets, `session.json`, `session-history.json`, logs) inside `~/.config/herdr/`; a whole-dir replace would orphan a running server and move session history into the backup. Its backups land under `~/.synapse_backup_<ts>/herdr/` so `--remove` restores them in place. Before overwriting, real files/dirs are backed up to `~/.synapse_backup_<timestamp>`; existing *symlinks* are just removed. Setup also installs TPM (`~/.tmux/plugins/tpm`) if missing and runs the headless Lazy sync. Remove restores from the newest backup then deletes every `~/.synapse_backup_*`.

**Dotfile payload — `dot/`.** What actually ships to the user:
- `.tmux.conf` — prefix is **`C-x`** (not the default `C-b`). `prefix + g` opens a Gemini CLI split in the current dir; `prefix + r` reloads. Uses vim-tmux-navigator, tmux-resurrect/continuum (auto-save/restore), and the synthweave theme with CPU/RAM widgets.
- `.config/herdr/config.toml` — herdr multiplexer config, the primary windowing layer in the Ghostty + herdr stack (replaces tmux). Prefix `ctrl+x` (same as the tmux config), vim-style splits and bare `ctrl+h/j/k/l` pane focus, catppuccin theme, native session persistence. Reload via `herdr server reload-config` (or `prefix+r`).
- `.config/ghostty/config` — ghostty terminal config tuned for herdr: `theme = catppuccin-mocha` (matches herdr, no light/dark auto-switch) and `macos-option-as-alt = true` so herdr's Alt bindings work.
- `.gitconfig` — git aliases (`ci`, `co`, `cp`, `st`, `br`, `df`, `lg`) and a **hardcoded user identity** (Hugh Guan). Deploying it overrides the user's existing gitconfig (the old one is backed up).
- `.config/nvim/` — see below.

**Neovim config — `dot/.config/nvim/`.** A single-file `init.lua` derived from kickstart.nvim, managed by lazy.nvim (`<space>` leader, Nerd Font on, tokyonight-night). Beyond stock kickstart it carries the project's AI hooks:
- A `:Gemini <prompt>` user command that runs `gemini ask '<prompt>'` synchronously and inserts the markdown output below the cursor.
- `obsidian.nvim` with a workspace hardcoded to an iCloud Obsidian vault path (`init.lua` has a `TODO: update vault` next to it) — update this path rather than assuming it's correct.
- LSP servers (via mason): `clangd` (with `--background-index --clang-tidy`), `pyright`, `rust_analyzer`, `ts_ls`, `marksman`, `stylua`, `lua_ls`. `gopls` is commented out.
- The intended extension point is `lua/custom/plugins/` (the `{ import = 'custom.plugins' }` line is currently commented out, and that file returns `{}`). Optional kickstart plugins in `lua/kickstart/plugins/` (debug, lint, autopairs, indent_line, neo-tree, gitsigns) are also disabled.

**Gemini CLI skill — `skills/synapse/` + `skills/synapse.skill`.** `SKILL.md` documents the setup/remove workflow for the Gemini CLI. `skills/synapse.skill` is a **packaged zip artifact** of `scripts/synapse.zsh` + `SKILL.md` (install via `gemini skills install`). If you edit the source files under `skills/synapse/`, the `.skill` zip is stale until repackaged.

## Gotchas

- **`Dockerfile.test` is stale and does not work.** It runs `zsh /synapse-repo/synapse.zsh` (no such file at repo root — the script lives under `skills/synapse/scripts/`) and asserts symlinks (`ls -la … | grep "\->"`), but the installer copies files, it does not symlink. Do not use it as a reference for behavior. `.github/workflows/validate.yml` is the source of truth and correctly asserts non-symlinks.
- **`.github/workflows/stylua.yml` never runs on this fork** — it's gated `if: github.repository == 'nvim-lua/kickstart.nvim'`, inherited from kickstart. Run `stylua` locally to check Lua formatting.
- **Override, not symlink:** every setup `cp -rf`s over `$HOME`. Re-running `--setup` on a machine Synapse already manages will back up Synapse's own previously-copied files again (the script notes this but intentionally doesn't guard against it). The only way back is `--remove`, which requires a backup to exist.
- `todo.md` tracks a 7-day implementation roadmap; many items are still unchecked — it's a planning doc, not a spec.
