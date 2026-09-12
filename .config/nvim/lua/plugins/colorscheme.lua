return {
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "tokyonight-day" },
  },
  {
    "folke/tokyonight.nvim",
    keys = {
      {
        "<leader>ut",
        function()
          vim.cmd.colorscheme(vim.g.colors_name == "tokyonight-day" and "tokyonight-night" or "tokyonight-day")
        end,
        desc = "Toggle Day/Night Theme",
      },
    },
  },
}
