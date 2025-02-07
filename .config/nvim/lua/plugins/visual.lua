return {
  { -- Colorscheme
    "luisiacc/gruvbox-baby",
    cond = not vim.g.vscode,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox-baby]])
    end,
  },
  { -- Modeline/Statusline/Airline/Whatever
    "echasnovski/mini.statusline",
    version = false,
    cond = not vim.g.vscode,
    lazy = false,
    config = function()
      require('mini.statusline').setup()
    end,
  },
  { -- Add lines to denote indent depth
    "lukas-reineke/indent-blankline.nvim",
    cond = not vim.g.vscode,
    main = "ibl",
    opts = {
      indent = {
        char = "▏",
      },
      scope = {
        char = "▍"
      },
    },
  },
  { -- Detect indentation depth automatically
    "tpope/vim-sleuth",
    cond = not vim.g.vscode,
  },
}
