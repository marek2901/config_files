-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "AgenticInput", "AgenticChat", "AgenticTodos", "AgenticCode", "AgenticFiles", "AgenticDiagnostics" },
  callback = function()
    local ok, cmp = pcall(require, "cmp")
    if ok then
      cmp.setup.buffer({ enabled = false })
    end
  end,
  desc = "Disable nvim-cmp in Agentic buffers",
})

local is_inside_tmux = vim.env.TMUX ~= nil

if is_inside_tmux then
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("tmux_yank_passthrough", { clear = true }),
    callback = function()
      local register_name = vim.v.event.regname
      if register_name == "_" then
        return
      end
      local yanked_text = vim.fn.getreg(register_name)
      if yanked_text == "" then
        return
      end
      -- -w: also emit the yank as OSC 52 to attached clients (host clipboard over SSH)
      vim.system({ "tmux", "load-buffer", "-w", "-" }, { stdin = yanked_text })
    end,
    desc = "Mirror yanked/deleted text into the tmux paste buffer",
  })
end
