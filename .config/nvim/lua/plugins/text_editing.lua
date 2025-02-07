return {
  { -- Automatic enclosures
    'echasnovski/mini.pairs',
    cond = not vim.g.vscode,
    config = true,
  },
  {
    'echasnovski/mini.surround',
    version = false,
    event = "VeryLazy",
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
      { "sn", "<cmd>lua require('treesj').toggle()<cr>", desc = "Toggle semantic node" },
    },
  },
}
