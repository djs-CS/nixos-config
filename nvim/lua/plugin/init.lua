local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
--
local plugins = {
  {
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    lazy = false,
    enabled = not vim.g.vscode,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = not vim.g.vscode,
    config = function()
      vim.cmd("colorscheme catppuccin")
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          normal = "<leader>sa",
          delete = "<leader>sd",
          change = "<leader>sr",
        }, -- Configuration here, or leave empty to use defaults
      })
    end
  }, {
  "nvim-tree/nvim-tree.lua",
  enabled = not vim.g.vscode,
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    --disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true
    --  setup using defaults
    require("nvim-tree").setup()
  end,
}, {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "lua", "go", "javascript", "typescript", "json", "yaml", "markdown", "markdown_inline", "html", "css", "scss", "svelte" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
  enabled = not vim.g.vscode,
}, {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  enabled = not vim.g.vscode,
  config = function()
    require("lualine").setup()
  end
}, {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = true,
}, {
  "backdround/improved-ft.nvim",
  version = "*",
  lazy = false,
  config = function()
    local ft = require("improved-ft")
    ft.setup({
      -- Maps default f/F/t/T/;/, keys
      -- default: false
      use_default_mappings = true,
      -- Ignores case of interactively given characters.
      -- default: false
      ignore_user_char_case = true,
      -- Takes a last jump direction into account during repetition jumps.
      -- default: false
      use_relative_repetition = true,
    })
  end
}
}

local opts = {}

require("lazy").setup(plugins, opt)
