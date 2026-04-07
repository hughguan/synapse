---
name: synapse
description: Full lifecycle management for the Synapse AI Terminal. Automates setup (symlinking dotfiles, dependencies) and removal (restoring original backups).
---

# Synapse Lifecycle Skill

This skill manages the full lifecycle of the Synapse AI Terminal environment.

## Workflow

### 1. Setup Environment
Initialize your AI terminal by overriding local dotfiles with repository versions and installing dependencies.

```bash
zsh scripts/synapse.zsh --setup
```

### 2. Uninstall & Revert
Remove the Synapse overrides and restore your original dotfiles from the latest backup.

```bash
zsh scripts/synapse.zsh --remove
```

### 3. Key Features
- **OS Layer:** Tmux configuration with C-x prefix and navigation bindings.
- **Human Native:** Full Neovim configuration (mirroring `dot/.config/nvim/`) powered by kickstart.nvim and obsidian.nvim.
- **Override Mode:** Directly copies files to your home directory (no symlinks) for maximum compatibility.
- **Full Recursion:** Automatically deploys all files/directories found in the `dot/` folder (including hidden ones).
- **Backups:** Automatic timestamped backups of your original config files and directories before override.
- **Verification:** Headless plugin synchronization for Neovim (Lazy.nvim).

## Troubleshooting

- **Backup Locations:** Backups are stored in `~/.synapse_backup_YYYYMMDD_HHMMSS`.
- **Requirements:** Neovim 0.10+ and Zsh.
