return {
  { -- Colorscheme
    "morhetz/gruvbox",
    cond = not vim.g.vscode,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
      vim.g.gruvbox_contrast_dark = "hard"
      vim.g.gruvbox_contrast_light = "hard"
    end,
    keys = {
      { "<leader>C", function()
        vim.o.background = (vim.o.background == "dark" and "light" or "dark")
      end, desc = "Toggle Between Dark/Light Mode"}
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      local function isRecording ()
        local reg = vim.fn.reg_recording()
        if reg == "" then return "" end -- not recording
        return "⏺ " .. reg
      end

      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'gruvbox',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          }
        },
        sections = {
          lualine_a = { {
            isRecording,
            color = { bg = '#cc241d', fg = '#ebdbb2' },
          } },
          lualine_b = {'mode'},
          lualine_c = {'filename', 'diagnostics'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress', 'searchcount'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      })
    end
  },
  --[[
  { -- Modeline/Statusline/Airline/Whatever
    "echasnovski/mini.statusline",
    version = false,
    cond = not vim.g.vscode,
    lazy = false,
    config = function()
      require('mini.statusline').setup()
    end,
  },
  ]]
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
  { -- Detect indentation depth automatically
    "tpope/vim-sleuth",
    cond = not vim.g.vscode,
  },
}
