return {
  { -- Installs external dependencies
    "williamboman/mason.nvim",
    cond = not vim.g.vscode,
    lazy = false,
    config = function()
      require('mason').setup()
    end,
  },
  { -- Interop with nvim-lspconfig
    "williamboman/mason-lspconfig.nvim",
    cond = not vim.g.vscode,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls" },
      }
    end,
  },
  { -- Sane LSP presets
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode,
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason-lspconfig").setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {
            autostart = true,
          }
        end,
        ["lua_ls"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" }
                }
              }
            }
          }
        end,
      }
    end,
    keys = {
      { "<leader>cl", group = "LSP" },
      { "<leader>cli", "<cmd>LspInstall<cr>", desc = "Install LSP" },
      { "<leader>cll", "<cmd>Mason<cr>", desc = "Open LSP manager" },
      { "<leader>clr", "<cmd>LspRestart<cr>", desc = "Open LSP manager" },
      { "<leader>cls", "<cmd>LspInfo<cr>", desc = "LSP Status" },
    },
  },
  { -- Autocompletion. Use Ctrl+N to select from autocomplete menu
    'echasnovski/mini.completion',
    version = false,
    config = true,
  },
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
}
