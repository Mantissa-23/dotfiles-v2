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
        ensure_installed = { "lua_ls", "csharp_ls", "vtsls" },
      }
    end,
  },
  { -- Sane LSP presets
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
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
      { "<leader>cli", "<cmd>LspInstall<cr>", desc = "Install LSP" },
      { "<leader>cll", "<cmd>Mason<cr>", desc = "Open LSP manager" },
      { "<leader>clr", "<cmd>LspRestart<cr>", desc = "Open LSP manager" },
      { "<leader>cls", "<cmd>LspInfo<cr>", desc = "LSP Status" },
      { "<leader>ld", function() vim.lsp.buf.definition() end, desc = "Goto definition"},
      { "<leader>lr", function() vim.lsp.buf.references() end, desc = "Goto references"},
      { "gd", function() vim.lsp.buf.definition() end, desc = "Goto definition"},
      { "gr", function() vim.lsp.buf.references() end, desc = "Goto references"},
      { "<leader>lR", function() vim.lsp.buf.rename() end, desc = "Rename symbol"},
      { "<leader>lh", function() vim.lsp.buf.hover() end, desc = "Hover symbol"},
      { "<leader>lci", function() vim.lsp.buf.incoming_calls() end, desc = "List incoming calls" },
      { "<leader>lco", function() vim.lsp.buf.outgoing_calls() end, desc = "List outgoing calls"},
      { "<leader>la", function() vim.lsp.buf.code_action() end, desc = "Code Actions"},
      { "<C-.>", function() vim.lsp.buf.code_action() end, desc = "Code Actions"},
      { "<leader>lD", function() vim.diagnostic.open_float() end, desc = "LSP Diagnostics (on cursor)" },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require('cmp');

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            local insert = require('mini.snippets').config.expand.insert or require('mini.snippets').default_insert
            insert({ body = args.body }) -- Insert at cursor
            cmp.resubscribe({ "TextChangedI", "TextChangedP" })
            require("cmp.config").set_onetime({ sources = {} })
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        })
      })

      -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
      -- Set configuration for specific filetype.
      --[[ cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        })
      })
      require("cmp_git").setup() ]]-- 

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      require('lspconfig')['lua_ls'].setup {
        capabilities = capabilities,
        autostart = true,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      }
      require('lspconfig')['csharp_ls'].setup {
        autostart = true,
        capabilities = capabilities,
      }
      require('lspconfig')['vtsls'].setup {
        capabilities = capabilities,
        autostart = true,
        settings = {
          vtsls = {
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
                enableProjectDiagnostics = true,
              },
            },
          },
        }
      }
    end,
  },
  {
    "echasnovski/mini.snippets",
    version = false,
    cond = not vim.g.vscode,
    config = function()
      local gen_loader = require('mini.snippets').gen_loader
      require('mini.snippets').setup({
        snippets = {
          -- Load custom file with global snippets first (adjust for Windows)
          gen_loader.from_file('~/.config/nvim/snippets/global.json'),

          -- Load snippets based on current language by reading files from
          -- "snippets/" subdirectories from 'runtimepath' directories.
          gen_loader.from_lang(),
        },
      })
    end,
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
