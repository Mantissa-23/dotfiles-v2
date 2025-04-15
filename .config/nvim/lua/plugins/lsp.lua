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
        ensure_installed = { "lua_ls", "csharp_ls", "vtsls", "svelte", "cssls" },
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
}
