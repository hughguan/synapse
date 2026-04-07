# Synapse Execution Plan: 7-Day Implementation Roadmap

## ✅ Day 1: Foundation & The "Synapse" Lifecycle Skill
- [x] **Environment Check:** Verify core dependencies (`zsh`, `tmux`, `nvim 0.10+`, `node`, `npm`).
- [x] **Docker Validation:** Run `docker build -f Dockerfile.test -t synapse-test .` to verify the setup script and Neovim config in a clean environment.
- [x] **Skill Creation:** Initialize and refine the `synapse` Gemini CLI skill (Setup + Remove).
- [x] **Scripting:** Finalize `synapse.zsh` with "Override Mode" and recursive directory support.
- [x] **Initial Deployment:** Use `gemini skills install` to load the skill and automate dotfile deployment.
- [x] **Verification:** Confirm Tmux starts with `prefix C-x` and Neovim loads full `kickstart.nvim` config without errors.

## Day 2: Human Native Interface (Neovim & Flow)
- [x] **Kickstart Integration:** Deployed full `kickstart.nvim` structure (lua/, doc/, .stylua.toml).
- [ ] **LSP Optimization:** Refine `init.lua` with specific LSP servers (`rust_analyzer`, `lua_ls`, `pyright`).
- [x] **Navigation:** `vim-tmux-navigator` is active between Tmux panes and Nvim splits.
- [x] **Aesthetics:** `tokyonight` theme and Nerd Font icons are configured.
- [ ] **Flow Test:** Practice the "Code -> Split -> Terminal" cycle within the new environment.

## Day 3: The Knowledge Junction (Obsidian)
- [ ] **Vault Sync:** Set up `obsidian.nvim` to point to the correct Markdown vault path.
- [ ] **CLI Integration:** Install and verify `obsidian-cli` for terminal-based vault queries.
- [ ] **Linking:** Test the `gf` (go to file) functionality within Neovim to jump between code and notes.
- [ ] **Database Setup:** Ensure the "Single Source of Truth" directory structure is recognized by the OS layer.

## Day 4: The Lightweight Specialist (Gemini CLI Plumbing)
- [ ] **Unix Pipes:** Create Zsh aliases for piping terminal output directly into Gemini CLI (e.g., `cat log.txt | gemini "analyze errors"`).
- [ ] **Specialized Skills:** Create a `code-reviewer` skill for Gemini CLI to provide instant PR feedback.
- [ ] **Context Injection:** Experiment with passing Obsidian notes as context to Gemini CLI queries.

## Day 5: The Heavyweight Architect (Agentic Framework)
- [ ] **Agent Install:** Clone and configure `oh-my-openagent`.
- [ ] **Model Orchestration:** Connect Claude 4.6 (Remote) and Gemma 4 (Local) to the agentic engine.
- [ ] **Background Tasks:** Test a multi-agent background task (e.g., "Refactor this Rust module while I work on the docs").
- [ ] **Detachment Test:** Verify agents continue running in Tmux sessions after detaching the terminal.

## Day 6: Automation & Execution Pipeline (CI/CD)
- [x] **GitHub Actions:** Automated lifecycle validation (Setup/Remove/Restore) is live.
- [ ] **Git Hooks:** Implement a `pre-commit` hook that uses Gemini CLI to check for secrets and linting.
- [ ] **Distribution Flow:** Configure N8N to trigger content distribution.
- [ ] **Rendering:** Setup `Hugo` or `Slidev` to transform markdown notes into a static site or presentation.

## Day 7: Stress Test & Calibration
- [ ] **Full Cycle Test:** Research a topic in Obsidian -> Draft code in Neovim -> Validate with Architect -> Commit and Publish via Pipeline.
- [ ] **Latency Audit:** Optimize startup times for Neovim and Tmux.
- [ ] **Backup:** Finalize the backup logic in `synapse.zsh` to ensure settings are never lost.
- [ ] **Final Push:** Commit the entire stable state to the remote repository.
