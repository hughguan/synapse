#!/usr/bin/env zsh

# synapse.zsh - Lifecycle management for the Synapse AI Terminal environment

set -e

# Find the project root
SCRIPT_DIR="${0:A:h}"
PROJECT_ROOT=$(cd "$SCRIPT_DIR/../../.." && pwd)
DOT_DIR="$PROJECT_ROOT/dot"
BACKUP_DIR_BASE="$HOME/.synapse_backup"

usage() {
    echo "Usage: $0 [-s|--setup] [-r|--remove]"
    echo "  -s, --setup   Install dotfiles and dependencies (default)"
    echo "  -r, --remove  Uninstall dotfiles and restore from latest backup"
    exit 1
}

setup() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="${BACKUP_DIR_BASE}_${timestamp}"

    echo "🚀 Starting Synapse setup (Override Mode)..."
    echo "📂 Project root detected: $PROJECT_ROOT"

    if [[ ! -d "$DOT_DIR" ]]; then
        echo "❌ Error: Could not find 'dot/' directory at $DOT_DIR"
        exit 1
    fi

    deploy_item() {
        local src=$1
        local dest=$2
        local backup_subdir=${3:-}  # optional: back up under $backup_dir/$backup_subdir/
        local dest_dir=$(dirname "$dest")
        local backup_target="$backup_dir"
        if [[ -n "$backup_subdir" ]]; then
            backup_target="$backup_dir/$backup_subdir"
        fi

        # Backup logic: Only backup if it's a real file/dir and NOT a symlink.
        # To avoid backing up Synapse's own overrides repeatedly, we could check
        # but for now we follow the "override" instruction strictly.
        if [[ -e "$dest" ]]; then
            if [[ -L "$dest" ]]; then
                echo "🗑️ Removing existing symlink: $dest"
                rm "$dest"
            else
                echo "📦 Backing up existing item: $dest"
                mkdir -p "$backup_target"
                mv "$dest" "$backup_target/"
            fi
        fi

        mkdir -p "$dest_dir"
        echo "📥 Overriding $dest with $src"
        cp -rf "$src" "$dest"
    }

    # 1. Deploy Dotfiles from the dot/ directory
    # Using (N) qualifier for nullglob in zsh
    for item in "$DOT_DIR"/.[!.]*(N) "$DOT_DIR"/*(N); do
        local base_item=$(basename "$item")
        
        # We want to deploy the contents of .config/ specifically to ~/.config/
        if [[ "$base_item" == ".config" ]]; then
            for subitem in "$item"/*(N); do
                local base_subitem=$(basename "$subitem")

                # herdr keeps runtime state (sockets, session.json, logs) inside
                # ~/.config/herdr/, so deploy its config file-by-file instead of
                # replacing the whole directory (which would orphan a running
                # server and move session history into the backup). Backups land
                # under $backup_dir/herdr/ so remove() can restore them in place.
                if [[ "$base_subitem" == "herdr" ]]; then
                    for cfgfile in "$subitem"/*(N); do
                        local fname=$(basename "$cfgfile")
                        deploy_item "$cfgfile" "$HOME/.config/herdr/$fname" "herdr"
                    done
                else
                    deploy_item "$subitem" "$HOME/.config/$base_subitem"
                fi
            done
        else
            deploy_item "$item" "$HOME/$base_item"
        fi
    done

    # 2. Dependencies
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        echo "📥 Installing TPM..."
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi

    if command -v nvim &> /dev/null; then
        echo "⚡ Bootstrapping Neovim plugins..."
        nvim --headless "+Lazy! sync" +qa
    fi

    echo "✨ Synapse setup complete!"
}

remove() {
    local latest_backup=$(ls -td ${BACKUP_DIR_BASE}_* 2>/dev/null | head -n 1)

    if [[ -z "$latest_backup" ]]; then
        echo "❌ Error: No backup found to restore from."
        exit 1
    fi

    echo "🔄 Reverting Synapse and restoring from: $latest_backup"

    restore_item() {
        local backup_item="$1"
        local target="$2"

        if [[ -e "$backup_item" ]]; then
            echo "⏪ Restoring $target"
            rm -rf "$target"
            mv "$backup_item" "$target"
        fi
    }

    # Restore everything found in the backup directory
    for item in "$latest_backup"/.[!.]*(N) "$latest_backup"/*(N); do
        local base_item=$(basename "$item")

        # Special handling for .config contents
        if [[ "$base_item" == "nvim" ]]; then
             restore_item "$item" "$HOME/.config/nvim"
        elif [[ "$base_item" == "herdr" ]]; then
             # herdr config was deployed file-by-file; restore each backed-up
             # file into ~/.config/herdr/ (runtime state was left in place).
             mkdir -p "$HOME/.config/herdr"
             for cfgfile in "$item"/*(N); do
                 restore_item "$cfgfile" "$HOME/.config/herdr/$(basename "$cfgfile")"
             done
        else
             restore_item "$item" "$HOME/$base_item"
        fi
    done

    # Cleanup backup folders
    echo "🧹 Cleaning up backup directories..."
    rm -rf ${BACKUP_DIR_BASE}_*

    echo "✨ Synapse removed, original files restored, and backups cleaned."
}

# Parse arguments
if [[ $# -eq 0 ]]; then
    setup
else
    case "$1" in
        -s|--setup) setup ;;
        -r|--remove) remove ;;
        *) usage ;;
    esac
fi
