return {
  { -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    cond = not vim.g.vscode,
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>", desc = "Find files" },
      { "<c-p>", "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>", desc = "Find files" },
      { "<leader>fs", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Search (ripgrep) everything" },
    },
  },
  { -- Use fzf native and build automatically from source
    'nvim-telescope/telescope-fzf-native.nvim',
    cond = not vim.g.vscode,
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  },
}
