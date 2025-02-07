return {
  {
    "echasnovski/mini-git",
    version = false,
    cond = not vim.g.vscode,
    config = function()
      require('mini.git').setup()
    end,
    keys = {
      { "<leader>g", group = "Git" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gs", "<cmd>Git status<cr>", desc = "Git status" },
      { "<leader>gg", "<cmd>lua require('mini.git').show_at_cursor()<cr>", desc = "Git info at cursor" },
    },
  },
  {
    "echasnovski/mini.diff",
    version = false,
    cond = not vim.g.vscode,
    config = function()
      require('mini.diff').setup()
    end,
  },
}
