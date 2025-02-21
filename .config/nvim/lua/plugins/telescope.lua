return {
  { -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    cond = not vim.g.vscode,
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<c-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find files" },
      { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find files" },
      { "<leader>fD", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", desc = "Search diagnostics" },
      { "<leader>fs", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Search (ripgrep) everything" },
      { "<leader>fhf", "<cmd>lua require('telescope.builtin').find_files({hidden=true, ignore=false})<cr>", desc = "Find hidden files" },
      { "<leader>fhs", "<cmd>lua require('telescope.builtin').live_grep({hidden=true, ignore=false})<cr>", desc = "Hidden Full text search" },
    },
  },
  { -- Use fzf native and build automatically from source
    'nvim-telescope/telescope-fzf-native.nvim',
    cond = not vim.g.vscode,
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  },
}
