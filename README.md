# synapse: Where human flow-state meets autonomous AI execution

Synapse is more than just a collection of dotfiles; it is the orchestrator for a next-generation AI terminal. It transforms a standard Tmux + Neovim setup into a multi-model development environment. By seamlessly integrating lightweight pipeline tools (Gemini/Obsidian CLI) with heavyweight agentic frameworks (oh-my-openagent), Synapse acts as the critical junction connecting human intent with autonomous machine intelligence.

-🧠 Human Native (The Interface): Neovim, powered by obsidian.nvim and LSP, optimized for uninterrupted flow-state.

-⚡ The Specialist (Lightweight Pipeline): Gemini CLI + Obsidian CLI hooked into standard Unix pipes for real-time querying, Git hooks, and dynamic knowledge base extraction.

-🏗️ The Architect (Heavyweight Engine): oh-my-openagent managing Claude 4.6 and local Gemma 4 for deep logic refactoring and autonomous multi-agent background tasks.

-🌐 The OS Layer: Tmux binding the entire ecosystem together, ensuring context persists and agents keep working even when you detach.

```text
+-------------------------------------------------------------------------------------+
|                           TMUX (The Hypervisor / OS Layer)                          |
|           (Global Keybinds, Seamless Pane Navigation, Background Daemons)           |
+-------------------------------------------------------------------------------------+
            |                                                 |
  🧑‍💻 Human Native (Flow State)                     🤖 AI Native (Compute Zone)
            |                                                 |
    Neovim (Main Console)                     +---------------+---------------+
    |-- obsidian.nvim (Knowledge)             |                               |
    |-- treesitter/LSP (Code Input)    <Lightweight/Pipes>         <Heavyweight/Architect>
    +-- vim-tmux-navigator (Navigate)  Gemini CLI                  oh-my-openagent
                                              |                               |
                                       (Equipped Skill)             (Wrapped Engine)
                                              |                               |
                                       Obsidian CLI                 OpenCode
                                              |                               |
                                              +---------------+---------------+
                                                              |
+-------------------------------------------------------------------------------------+
|                  💾 Single Source of Truth (Database & Codebase)                    |
|              (Obsidian Vault Markdown Files / Local Rust Source Code)               |
+-------------------------------------------------------------------------------------+
                                                              |
                                  ⚙️ Automation & CI/CD (Execution Pipeline)
                                  |-- Git / GitHub Actions
                                  |-- N8N (Auto-send JoyRobots Newsletter)
                                  +-- Hugo / Slidev (Website & Slide Rendering)
