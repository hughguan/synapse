---
name: synapse-setup
description: Automated setup for the Synapse AI Terminal. Use this to install dotfiles, symlink configurations, and set up the OS/Human native environment (Tmux/Neovim).
---

# Synapse Setup Skill

This skill automates the installation and configuration of the Synapse AI Terminal environment.

## Workflow

### 1. Execute Setup Script
Run the bundled `synapse.zsh` script to perform symlinking and dependency checks.

```bash
zsh scripts/synapse.zsh
```

The script will:
- Backup existing `.gitconfig`, `.tmux.conf`, and `~/.config/nvim/init.lua` to a timestamped folder in `~/.synapse_backup_...`.
- Create symlinks from the `dot/` directory to your home folder.
- Install Tmux Plugin Manager (TPM) if missing.
- Trigger a headless Neovim plugin sync via Lazy.nvim.

### 2. Verify Installation
After the script completes, verify the setup:

- **Tmux:** Start tmux and press `prefix C-x` then `r` to reload.
- **Neovim:** Open nvim and check for errors. Run `:checkhealth` if needed.
- **Git:** Run `git config --list` to confirm the user name and email are correct.

### 3. Post-Installation Steps
If Neovim or Tmux plugins fail to install automatically, you can trigger them manually:
- **Tmux Plugins:** Inside tmux, press `prefix C-x` then `I` (capital I) to install plugins.
- **Neovim Plugins:** Run `:Lazy sync` inside Neovim.

## Troubleshooting

- **Symlink Errors:** If the script fails to create symlinks, ensure you have write permissions to your home directory.
- **Neovim Version:** This setup requires Neovim 0.10 or newer. Check with `nvim --version`.
- **Node/NPM:** Required for many Neovim plugins and Gemini CLI. Ensure they are in your `$PATH`.
