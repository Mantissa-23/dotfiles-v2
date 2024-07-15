-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Environment-dependent config
if vim.g.vscode then

else
  -- Line numbers please
  vim.wo.number = true

  -- Set wrap and linebreak. Yeah I know this is a weird preference, but it's what I like.
  vim.wo.wrap = true
  vim.wo.linebreak = true

  -- Terminal gui colors
  vim.o.termguicolors = true

  -- Rulers at 80, 120
  vim.o.colorcolumn = "80,120"

  -- two semicolons to escape
  vim.keymap.set('i', '<;;>', '<Esc', { desc = 'Composite escape with ;;' })

  -- Natural split navigation
  vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

  -- Natural soft wrap navigation
  vim.keymap.set({'n', 'v'}, 'j', 'gj')
  vim.keymap.set({'n', 'v'}, 'k', 'gk')
end

-- Both!

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable [Enter to continue] messages
vim.o.cmdheight = 0
--vim.o.shm = 'a'

-- Do not exit visual mode when indenting
vim.keymap.set('v', '<', '<gv', { noremap = true})
vim.keymap.set('v', '>', '>gv', { noremap = true})

-- Init lazyvim
require("lazy").setup({
  spec = {
    -- Non-vscodium plugins- I.e. the "IDE" stuff
    { -- My favorite colorscheme :)
      "luisiacc/gruvbox-baby",
      cond = not vim.g.vscode,
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme gruvbox-baby]])
      end,
    },
    { -- For syntax highlighting
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
    { -- If no editorconfig is present, guess the indentation of a file when we open it
      "nmac427/guess-indent.nvim",
      cond = not vim.g.vscode,
      event = "BufRead",
      config = function() require('guess-indent').setup {} end,
    },
    { -- Add lines to denote indent depth
      "lukas-reineke/indent-blankline.nvim",
      cond = not vim.g.vscode,
      main = "ibl",
      opts = {
        indent = {
          char = "▏",
        },
        scope = {
          char = "▍"
        },
      },
    },
    { -- File explorer
      "nvim-tree/nvim-tree.lua",
      cond = not vim.g.vscode,
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
      },
      config = function()
        require("nvim-tree").setup {}
      end,
    },
    { -- Fuzzy finder
      'nvim-telescope/telescope.nvim',
      cond = not vim.g.vscode,
      branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys = {
        { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>", desc = "Find files" },
        { "<leader>fs", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Search (ripgrep) everything" },
      },
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      cond = not vim.g.vscode,
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
    { -- Which Key
      "folke/which-key.nvim",
      cond = not vim.g.vscode,
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 200

        -- Just name categories here; assign keys elsewhere
        require("which-key").register({
          f = {
            name = "Find",
            c = { "<cmd>e $HOME/.config/nvim/init.lua<cr>", "Open nvim init.lua" },
          },
          i = {
            name = "Insert",
            t = { "<cmd>r!date -Is<cr>", "Insert current timestamp, UNIX only" },
          }
        }, { prefix = "<leader>" })
      end,
      opts = {
      }
    },
    { -- Automatic enclosures
      'windwp/nvim-autopairs',
      cond = not vim.g.vscode,
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equalent to setup({}) function
    },
    -- "All" plugins- QoL and editor shortcut stuff
    { -- cs, vs, ds, ys all 
      "kylechui/nvim-surround",
      version = "*",
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({

        })
      end,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = {
  --   colorscheme = {
  --     "gruvbox-baby",
  --     cond = not vim.g.vscode,
  --   }
  -- },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
