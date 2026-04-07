#!/usr/bin/env zsh

# synapse.zsh - Setup script for the Synapse AI Terminal environment

set -e

# Find the project root (where the .git folder or dot/ folder is)
SCRIPT_DIR="${0:A:h}"
PROJECT_ROOT=$(cd "$SCRIPT_DIR/../.." && pwd)
DOT_DIR="$PROJECT_ROOT/dot"
BACKUP_DIR="$HOME/.synapse_backup_$(date +%Y%m%d_%H%M%S)"

echo "🚀 Starting Synapse setup..."
echo "📂 Project root detected: $PROJECT_ROOT"

if [[ ! -d "$DOT_DIR" ]]; then
    echo "❌ Error: Could not find 'dot/' directory at $DOT_DIR"
    exit 1
fi

# Function to create symlinks with backup
link_file() {
    local src=$1
    local dest=$2
    local dest_dir=$(dirname "$dest")

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        echo "📦 Backing up existing file: $dest"
        mkdir -p "$BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi

    mkdir -p "$dest_dir"
    echo "🔗 Symlinking $src -> $dest"
    ln -sf "$src" "$dest"
}

# 1. Symlink Dotfiles
link_file "$DOT_DIR/.gitconfig" "$HOME/.gitconfig"
link_file "$DOT_DIR/.tmux.conf" "$HOME/.tmux.conf"
link_file "$DOT_DIR/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua"

# 2. Install Tmux Plugin Manager (TPM) if not present
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "📥 Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
    echo "✅ TPM already installed."
fi

# 3. Neovim Headless Setup (Install plugins via Lazy.nvim)
if command -v nvim &> /dev/null; then
    echo "⚡ Bootstrapping Neovim plugins..."
    # Lazy.nvim will automatically bootstrap itself on first run if configured in init.lua
    # We run it once to install everything
    nvim --headless "+Lazy! sync" +qa
else
    echo "⚠️ Neovim not found. Please install Neovim to complete setup."
fi

# 4. Check for Gemini CLI
if ! command -v gemini &> /dev/null; then
    echo "⚠️ Gemini CLI not found. Install it with: npm install -g @google/gemini-cli"
else
    echo "✅ Gemini CLI found."
fi

echo "✨ Synapse setup complete! Please restart your terminal or source your configs."
