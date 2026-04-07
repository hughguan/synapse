#!/usr/bin/env zsh

# synapse.zsh - Lifecycle management for the Synapse AI Terminal environment

set -e

# Find the project root
SCRIPT_DIR="${0:A:h}"
PROJECT_ROOT=$(cd "$SCRIPT_DIR/../.." && pwd)
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

    echo "🚀 Starting Synapse setup..."
    echo "📂 Project root detected: $PROJECT_ROOT"

    if [[ ! -d "$DOT_DIR" ]]; then
        echo "❌ Error: Could not find 'dot/' directory at $DOT_DIR"
        exit 1
    fi

    link_file() {
        local src=$1
        local dest=$2
        local dest_dir=$(dirname "$dest")

        if [[ -e "$dest" && ! -L "$dest" ]]; then
            echo "📦 Backing up existing file: $dest"
            mkdir -p "$backup_dir"
            mv "$dest" "$backup_dir/"
        fi

        mkdir -p "$dest_dir"
        echo "🔗 Symlinking $src -> $dest"
        ln -sf "$src" "$dest"
    }

    # 1. Symlink Dotfiles
    link_file "$DOT_DIR/.gitconfig" "$HOME/.gitconfig"
    link_file "$DOT_DIR/.tmux.conf" "$HOME/.tmux.conf"
    link_file "$DOT_DIR/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua"

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

    restore_file() {
        local backup_file="$latest_backup/$1"
        local target="$HOME/$2"

        if [[ -f "$backup_file" ]]; then
            echo "⏪ Restoring $target"
            rm -f "$target"
            mv "$backup_file" "$target"
        fi
    }

    restore_file ".gitconfig" ".gitconfig"
    restore_file ".tmux.conf" ".tmux.conf"
    restore_file "init.lua" ".config/nvim/init.lua"

    echo "✨ Synapse removed and original files restored."
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
