return {
  { -- Automatic enclosures
    'echasnovski/mini.pairs',
    cond = not vim.g.vscode,
    config = true,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    'echasnovski/mini.trailspace',
    cond = not vim.g.vscode,
    version = false,
  },
  { -- For joining/splitting on semantic nodes and delimiters, i.e. scope, arrays, etc.
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
        max_join_length = 512,
      })
    end,
    keys = {
      { "<leader>j", "<cmd>lua require('treesj').toggle()<cr>", desc = "Toggle semantic node" },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
    },
    keys = {
      --{ "St", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      --{ "ST", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
    config = true,
  }
}
