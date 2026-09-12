return {
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-mocha" },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
    },
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
