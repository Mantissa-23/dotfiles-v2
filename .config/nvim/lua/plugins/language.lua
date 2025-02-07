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
        -- Configure the plugin here
        function(server_name)
          require("lspconfig")[server_name].setup {
            autostart = true,
          }
        end,
        -- Set configuration for LSPs here
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

      -- Unbind default bindings
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          vim.bo[ev.buf].formatexpr = nil
          vim.bo[ev.buf].omnifunc = nil
          --vim.keymap.del('n', 'K', { buffer = ev.buf }) -- trigger hover with default K binding
        end,
      })
    end,
    keys = {
      { "<leader>cl", group = "LSP Config" },
      { "<leader>cli", "<cmd>LspInstall<cr>", desc = "Install LSP" },
      { "<leader>cll", "<cmd>Mason<cr>", desc = "Open LSP manager" },
      { "<leader>clr", "<cmd>LspRestart<cr>", desc = "Open LSP manager" },
      { "<leader>cls", "<cmd>LspInfo<cr>", desc = "LSP Status" },
      { "<leader>l", group = "LSP" },
      { "<leader>ld", function() vim.lsp.buf.definition() end, desc = "Goto definition"},
      { "<leader>lr", function() vim.lsp.buf.references() end, desc = "Goto references"},
      { "gd", function() vim.lsp.buf.definition() end, desc = "Goto definition"},
      { "gr", function() vim.lsp.buf.references() end, desc = "Goto references"},
      { "<leader>lR", function() vim.lsp.buf.rename() end, desc = "Rename symbol"},
      { "<leader>lh", function() vim.lsp.buf.hover() end, desc = "Hover symbol"},
      { "<leader>lci", function() vim.lsp.buf.incoming_calls() end, desc = "List incoming calls" },
      { "<leader>lco", function() vim.lsp.buf.outgoing_calls() end, desc = "List outgoing calls"},
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
