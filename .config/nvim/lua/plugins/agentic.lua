local function toggle_provider(provider_name)
  local agentic = require("agentic")
  local registry = require("agentic.session_registry")
  local visible = registry.visible_here()
  if visible and visible.provider_name == provider_name then
    agentic.close()
    return
  end
  for _, session in ipairs(registry.list()) do
    if session.provider_name == provider_name then
      registry.show_session(session.session_key)
      return
    end
  end
  agentic.new_session({ provider = provider_name })
end

return {
  {
    "carlos-algms/agentic.nvim",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "AgenticChat", "AgenticInput", "AgenticCode", "AgenticFiles", "AgenticTodos", "AgenticDiagnostics" },
        callback = function(args)
          if vim.g.colors_name then
            vim.cmd.colorscheme(vim.g.colors_name)
          end
          vim.keymap.set({ "n", "i" }, "<C-c>", function() require("agentic").stop_generation() end, {
            buffer = args.buf,
            desc = "Stop Agentic generation",
          })
        end,
      })
    end,
    --- @type agentic.PartialUserConfig
    opts = {
      provider = "claude-agent-acp",
      file_picker = {
        auto_trigger = false,
      },
      slash_commands = {
        auto_trigger = false,
      },
  },
  keys = {
    {
      "<leader>at",
      function() require("agentic").toggle() end,
      mode = { "n", "v" },
      desc = "Toggle Agentic Chat",
    },
    {
      "<leader>ac",
      function() toggle_provider("claude-agent-acp") end,
      mode = { "n", "v" },
      desc = "Agentic Claude",
    },
    {
      "<leader>ao",
      function() toggle_provider("opencode-acp") end,
      mode = { "n", "v" },
      desc = "Agentic OpenCode",
    },
    {
      "<leader>ag",
      function() toggle_provider("cursor-acp") end,
      mode = { "n", "v" },
      desc = "Agentic Cursor",
    },
    {
      "<leader>aa",
      function() require("agentic").add_selection_or_file_to_context() end,
      mode = { "n", "v" },
      desc = "Add file or selection to Agentic context",
    },
    {
      "<leader>an",
      function() require("agentic").new_session() end,
      mode = { "n", "v" },
      desc = "New Agentic Session",
    },
    {
      "<leader>ar",
      function() require("agentic").restore_session() end,
      desc = "Restore Agentic Session",
      silent = true,
      mode = { "n", "v" },
    },
    {
      "<leader>ad",
      function() require("agentic").add_current_line_diagnostics() end,
      desc = "Add line diagnostics to Agentic",
      mode = { "n" },
    },
    {
      "<leader>aD",
      function() require("agentic").add_buffer_diagnostics() end,
      desc = "Add buffer diagnostics to Agentic",
      mode = { "n" },
    },
  },
  },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      local prev = opts.enabled
      opts.enabled = function()
        if vim.bo.filetype == "AgenticInput" then
          return false
        end
        if type(prev) == "function" then
          return prev()
        end
        return true
      end
    end,
  },
}
