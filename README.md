# synapse
> Where human flow-state meets autonomous AI execution

Synapse is more than just a collection of dotfiles; it is the orchestrator for a next-generation AI terminal. It transforms a standard Tmux + Neovim setup into a multi-model development environment. By seamlessly integrating lightweight pipeline tools (Gemini/Obsidian CLI) with heavyweight agentic frameworks (oh-my-openagent), Synapse acts as the critical junction connecting human intent with autonomous machine intelligence.

-🧠 Human Native (The Interface): Neovim, powered by kickstart.nvim, obsidian.nvim and LSP, optimized for uninterrupted flow-state.

-⚡ The Specialist (Lightweight Pipeline): Gemini CLI + Obsidian CLI hooked into standard Unix pipes for real-time querying, Git hooks, and dynamic knowledge base extraction.

-🏗️ The Architect (Heavyweight Engine): oh-my-openagent managing Claude 4.6 and local Gemma 4 for deep logic refactoring and autonomous multi-agent background tasks.

-🌐 The OS Layer: Tmux binding the entire ecosystem together, ensuring context persists and agents keep working even when you detach.

```text
+-------------------------------------------------------------------------------------+
|                           TMUX (The Hypervisor / OS Layer)                          | |           (Global Keybinds, Seamless Pane Navigation, Background Daemons)           |
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
### Neovim & Plugins
*Install Neovim the latest 'stable'.
*Basic utils: git, make, unzip, C Compiler (gcc)
*ripgrep, fd-find
*tree-sitter CLI
*Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
*A Nerd Font: optional, provides various icons
  if you have it set vim.g.have_nerd_font in init.lua to true
*Emoji fonts (Ubuntu only, and only if you want emoji!) sudo apt install fonts-noto-color-emoji
*Language Setup:
  If you want to write Typescript, you need npm
  If you want to write Golang, you will need go
  etc.
