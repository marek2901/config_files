# 💤 LazyVim + Agentic

Minimal [LazyVim](https://github.com/LazyVim/LazyVim) starter, tuned for AI-driven editing with [agentic.nvim](https://github.com/carlos-algms/agentic.nvim) and Catppuccin.

## Features

- LazyVim defaults, zero extras bloat
- Agentic multi-provider chat: Claude Agent, OpenCode, Cursor ACP
- Catppuccin Mocha default + `<leader>ut` day/night toggle
- Completion disabled in Agentic buffers (blink.cmp + nvim-cmp guards)
- `:W :Q :Wq :WQ` typo commands

## Structure

```
lua/
  config/
    lazy.lua      lazy.nvim bootstrap
    keymaps.lua   typo commands
    autocmds.lua  cmp disable in Agentic buffers
    options.lua   LazyVim overrides (currently stock)
  plugins/
    agentic.lua     agentic.nvim + blink.cmp gate + <leader>a* keys
    colorscheme.lua catppuccin-mocha + toggle
```

## Keymaps

| Key | Mode | Action |
|-----|------|--------|
| `<leader>at` | n,v | Toggle Agentic Chat |
| `<leader>ac` | n,v | Agentic Claude |
| `<leader>ao` | n,v | Agentic OpenCode |
| `<leader>ag` | n,v | Agentic Cursor |
| `<leader>aa` | n,v | Add file/selection to context |
| `<leader>an` | n,v | New session |
| `<leader>ar` | n,v | Restore session |
| `<leader>ad` | n | Add line diagnostics |
| `<leader>aD` | n | Add buffer diagnostics |
| `<leader>ut` | n | Toggle Latte/Mocha |
| `<C-c>` | n,i (Agentic buf) | Stop generation |

## Requirements

- Neovim >= 0.9
- Git, ripgrep, fd, lazygit (per LazyVim)
- Nerd Font
- ACP provider binary (e.g. `claude`, `opencode`, `cursor-agent`) on `$PATH`

## Install

```sh
mv ~/.config/nvim ~/.config/nvim.bak
git clone <this-repo> ~/.config/nvim
nvim
# :LazyHealth, :checkhealth agentic
```
