---
name: synapse
description: Full lifecycle management for the Synapse AI Terminal. Automates setup (symlinking dotfiles, dependencies) and removal (restoring original backups).
---

# Synapse Lifecycle Skill

This skill manages the full lifecycle of the Synapse AI Terminal environment.

## Workflow

### 1. Setup Environment
Initialize your AI terminal by symlinking dotfiles and installing dependencies.

```bash
zsh scripts/synapse.zsh --setup
```

### 2. Uninstall & Revert
Remove the Synapse symlinks and restore your original dotfiles from the latest backup.

```bash
zsh scripts/synapse.zsh --remove
```

### 3. Key Features
- **OS Layer:** Tmux configuration with C-x prefix and navigation bindings.
- **Human Native:** Neovim setup powered by kickstart.nvim and obsidian.nvim.
- **Backups:** Automatic timestamped backups of your original config files.
- **Verification:** Headless plugin synchronization for Neovim (Lazy.nvim).

## Troubleshooting

- **Backup Locations:** Backups are stored in `~/.synapse_backup_YYYYMMDD_HHMMSS`.
- **Requirements:** Neovim 0.10+ and Zsh.
