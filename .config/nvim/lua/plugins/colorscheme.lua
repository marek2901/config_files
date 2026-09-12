return {
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-latte" },
  },
  {
    "catppuccin/nvim",
    keys = {
      {
        "<leader>ut",
        function()
          vim.cmd.colorscheme(vim.g.colors_name == "catppuccin-latte" and "catppuccin-mocha" or "catppuccin-latte")
        end,
        desc = "Toggle Day/Night Theme",
      },
    },
  },
}
