# synapse
> Where human flow-state meets autonomous AI execution

Synapse is more than just a collection of dotfiles; it is the orchestrator for a next-generation AI terminal. It transforms a standard Tmux + Neovim setup into a multi-model development environment. By seamlessly integrating lightweight pipeline tools (Gemini/Obsidian CLI) with heavyweight agentic frameworks (oh-my-openagent), Synapse acts as the critical junction connecting human intent with autonomous machine intelligence.

- 🧠 **Human Native (The Interface):** Neovim, powered by kickstart.nvim, obsidian.nvim and LSP, optimized for uninterrupted flow-state.
- ⚡ **The Specialist (Lightweight Pipeline):** Gemini CLI + Obsidian CLI hooked into standard Unix pipes for real-time querying, Git hooks, and dynamic knowledge base extraction.
- 🏗️ **The Architect (Heavyweight Engine):** oh-my-openagent managing Claude 4.6 and local Gemma 4 for deep logic refactoring and autonomous multi-agent background tasks.
- 🌐 **The OS Layer:** Tmux binding the entire ecosystem together, ensuring context persists and agents keep working even when you detach.

```text
+-------------------------------------------------------------------------------------+
|                           TMUX (The Hypervisor / OS Layer)                          |
|           (Global Keybinds, Seamless Pane Navigation, Background Daemons)           |
+-------------------------------------------------------------------------------------+
            |                                                 |
  🧑‍💻 Human Native (Flow State)                     🤖 AI Native (Compute Zone)
            |                                                 |
    Neovim (Main Console)                     +---------------+---------------+
    |-- kickstart.nvim (Foundation)           |                               |
    |-- obsidian.nvim (Vault Access)          |                               |
    |-- treesitter/LSP (Code Input)    <Lightweight/Pipes>         <Heavyweight/Architect>
    +-- vim-tmux-navigator (Navigate)  Gemini CLI                  oh-my-openagent
            |                                 |                               |
            |                          (Equipped Skill)             (Wrapped Engine)
            |                                 |                               |
            |                          Obsidian CLI                 OpenCode
            |                                 |                               |
            +---------------------------------+---------------+---------------+
                                                              |
+-------------------------------------------------------------------------------------+
|                  💾 Single Source of Truth (Database & Codebase)                    |
|              (Obsidian Vault Markdown Files / Local Rust Source Code)               |
+-------------------------------------------------------------------------------------+
                                                              |
                                ⚙️ Automation & CI/CD (Execution Pipeline)
                                  |-- Git / GitHub Actions
                                  |-- N8N (Automated Newsletter & Content Distribution)
                                  +-- Hugo / Slidev (Static Site & Slide Rendering)
```

## External Dependencies

### Tmux & Plugins
* install plugin
```zsh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
Reload your config: While inside a tmux session, run:
```zsh
tmux source ~/.tmux.conf
```
Trigger the install: Press your tmux prefix (usually Ctrl+b) followed by I (capital I for Install).
Wait: You will see a terminal message indicating that the plugins are being installed. Once finished, press Enter to dismiss the message.

### Neovim & Plugins
* **Neovim**: Install the latest 'stable' version.
* **Basic utils**: `git`, `make`, `unzip`, C Compiler (`gcc`)
* **Search**: `ripgrep`, `fd-find`
* **Tree-sitter**: `tree-sitter CLI`
* **Clipboard**: `xclip`/`xsel` (Linux), `pbcopy` (macOS), or `win32yank` (Windows/WSL)
* **A Nerd Font**: Optional, provides various icons. If you have it, set `vim.g.have_nerd_font` in `init.lua` to `true`.
* **Emoji fonts**: (Ubuntu only) `sudo apt install fonts-noto-color-emoji`

### Language Setup
* **TypeScript/JS**: `npm` / `node`
* **Golang**: `go`
* **Rust**: `rustup` / `cargo`
