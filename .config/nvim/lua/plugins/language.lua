return {
  { -- Syntax-aware highlighting and many other things
    "nvim-treesitter/nvim-treesitter",
    cond = not vim.g.vscode,
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "lua", "vim", "vimdoc", "markdown" },
        auto_install = true,
        indent = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["ip"] = "@parameter.inner",
              ["ap"] = "@parameter.outer",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.outer",
              ["as"] = { query = '@local.scope', query_group = "locals" },
              ["is"] = { query = '@local.scope', query_group = "locals" },
            },
            selection_modes = {
              ['@parameter.inner'] = 'v', -- charwise
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@function.inner'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
              ['@class.inner'] = '<c-v>', -- blockwise
              ['@local.scope'] = 'V', -- blockwise
            },
            include_surrounding_whitespace = true,
          },
          swap = {
            enable = true,
            swap_next = {
              ["<A-l>"] = '@parameter.inner',
            },
            swap_previous = {
              ["<A-h>"] = '@parameter.inner',
            },
          }
        }
      }
    end,
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      layout = {
        default_direction = "right",
      },
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Code Outline" },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        csharp = { "csharpier" }
      }
    },
    keys = {
      { "<leader>F", function() require("conform").format() end, mode = { "n", "v" }, desc = "Format" }
    }
  },
  {
    'zapling/mason-conform.nvim',
    dependencies = { 'stevearc/conform.nvim' },
    opts = {
      ignore_install = { 'prettier' },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
