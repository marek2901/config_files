return {
  {
    "carlos-algms/agentic.nvim",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "AgenticChat", "AgenticInput", "AgenticCode", "AgenticFiles", "AgenticTodos", "AgenticDiagnostics" },
        callback = function(args)
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
    acp_providers = {
      ["claude-agent-acp"] = {
        command = "claude-agent-acp",
      },
      ["opencode"] = {
        command = "opencode",
      },
      ["cursor"] = {
        command = "agent",
      },
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
