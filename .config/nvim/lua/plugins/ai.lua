return {
  {
    "olimorris/codecompanion.nvim",
    config = true,
    lazy = false,
    opts = {
      strategies = {
        chat = {
          adapter = "ollama",
          model = "Qwen2.5-Coder:3B",
          keymaps = {
            send = {
              modes = { n = "<C-s>", i = "<C-s>" },
            },
            close = {
              modes = { n = "<Nop>", i = "<Nop>" }
            }
          }
        },
        inline = {
          adapter = "ollama",
          model = "Qwen2.5-Coder:3B",
        },
      },
      adapters = {
        ollama_deepseek_r1 = {
          name = "ollama",
          model = "Qwen2.5-Coder:3B",
        }
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "AI Chat" },
      { "<leader>aa", "<cmd>CodeCompanion<cr>", desc = "AI Prompt" },
    }
  },
}
