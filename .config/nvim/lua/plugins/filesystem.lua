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
      require("nvim-tree").setup {
        actions = {
          open_file = {
            quit_on_open = true,
          }
        },
        update_focused_file = {
          enable = true,
        },
        view = {
          width = 50,
        },
        filters = {
          custom = {
            ".*\\.wav",
            ".*\\.png",
            ".*\\.rpp",
            ".*\\.uid",
            ".*\\.import",
            ".*\\.tscn",
            ".*\\.tres",
          }
        },
      }
    end,
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
}
