require('config.lazy')

-- Environment-dependent config
if vim.g.vscode then
else
  -- Line numbers please
  vim.wo.relativenumber = true
  vim.wo.number = true

  -- Set wrap and linebreak. Yeah I know this is a weird preference, but it's what I like.
  vim.wo.wrap = true
  vim.wo.linebreak = true
  vim.o.tabstop = 2

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
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })

-- Open helpfiles vertically
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  command = 'wincmd L',
})

-- Debind keys we use for quick actions
vim.keymap.set('n', 's', '<Nop>', { noremap = true })
vim.keymap.set('n', 'S', '<Nop>', { noremap = true })

-- Bind escape to exit terminal 

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  change_detection = {
    notify = false
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = {},
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
