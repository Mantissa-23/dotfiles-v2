return {
  { -- File explorer
    "nvim-tree/nvim-tree.lua",
    cond = not vim.g.vscode,
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
}
