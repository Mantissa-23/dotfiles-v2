return {
  {
    "echasnovski/mini-git",
    version = false,
    cond = not vim.g.vscode,
    config = function()
      require('mini.git').setup()
    end,
    keys = {
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gs", "<cmd>Git status<cr>", desc = "Git status" },
      { "<leader>gg", "<cmd>lua require('mini.git').show_at_cursor()<cr>", desc = "Git info at cursor" },
    },
  },
  {
    "echasnovski/mini.diff",
    version = false,
    cond = not vim.g.vscode,
    config = function()
      require('mini.diff').setup()
    end,
  },
  {
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
        -- your configuration comes here
        -- for example
        enabled = true,  -- if you want to enable the plugin
        message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
        date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
        virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
    },
  }
}
