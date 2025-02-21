return {
  { -- Which Key
    "folke/which-key.nvim",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons" },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 200

      -- Just name categories here; assign keys elsewhere
      require("which-key").add({
        { "<leader>c", group = "Config" },
        { "<leader>ci", "<cmd>e $HOME/.config/nvim/init.lua<cr>", desc = "Open nvim init.lua" },
        { "<leader>cs", "<cmd>Git --git-dir=$HOME/.git-dotfile/ --work-tree=$HOME status<cr>", desc = "Dotfile ctatus" },
        { "<leader>cc", "<cmd>Git --git-dir=$HOME/.git-dotfile/ --work-tree=$HOME commit<cr>", desc = "Dotfile commit" },
        { "<leader>cp", "<cmd>Lazy<cr>", desc = "Open plugin manager" },
        { "<leader>i", group = "Insert" },
        { "<leader>it", "<cmd>r!date -Is<cr>", desc = "Insert current timestamp, UNIX only" },
        { '<leader>fc', '<cmd>let @/ = ""<cr>', desc = "Reset Search" },
        { "S", group = "Quick Actions" },
      })
    end,
    opts = {
    }
  },
}
