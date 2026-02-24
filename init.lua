-- ==========================================================================
-- 1. LAZY.NVIM BOOTSTRAP
-- ==========================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- ==========================================================================
-- 2. GENERAL SETTINGS
-- ==========================================================================
local set = vim.o
local g = vim.g

g.mapleader = ' '

set.mouse = ""
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.number = true
set.relativenumber = true
set.updatetime = 300
set.fileformat = "unix"
set.swapfile = false
set.signcolumn = "yes"
set.whichwrap = "h,l"

-- ==========================================================================
-- 3. PLUGIN SPECS
-- ==========================================================================
require("lazy").setup({
  -- Colorscheme
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      g.gruvbox_material_background = "hard"
      g.gruvbox_material_better_performance = 1
      vim.cmd("colorscheme gruvbox-material")
    end,
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = { "markdown", "markdown_inline", "lua", "vim", "vimdoc", "javascript", "typescript", "vue", "rust", "solidity", "diff", "bash", "json" },
        highlight = { enable = true },
      })
    end,
  },

  -- File explorer & fuzzy finder
  { "scrooloose/nerdtree" },
  { "ctrlpvim/ctrlp.vim" },

  -- LSP / Completion
  { "neoclide/coc.nvim", branch = "release" },

  -- Language support
  { "posva/vim-vue" },
  { "tomlion/vim-solidity" },

  -- AI completion
  { "github/copilot.vim" },
},{
  rocks = { enabled = false },
})

-- ==========================================================================
-- 4. KEYBINDINGS & CONFIG
-- ==========================================================================

g.copilot_no_tab_map = true

g.ctrlp_custom_ignore = {
  dir = [[\v[\/](\.(git|hg|svn|buildozer)|node_modules|target|compiled|dist)$]],
  file = [[\v\.(o|pyc|lock)$]]
}

g.coc_global_extensions = {
  'coc-tsserver',
  'coc-eslint',
  'coc-json',
  '@yaegassy/coc-volar',
  'coc-rust-analyzer',
}

local map = vim.keymap

vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})

-- Window navigation
map.set('n', '<C-j>', '<C-w>j')
map.set('n', '<C-k>', '<C-w>k')
map.set('n', '<C-h>', '<C-w>h')
map.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
map.set('n', '<C-n>', ':NERDTreeToggle<CR>')

-- CoC
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
map.set("i", '<TAB>', 'coc#pum#visible() ? coc#pum#confirm() : "<TAB>"', opts)
map.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
map.set("n", "<C-y>", '<Plug>(coc-rename)', { silent = true })
map.set("n", "<leader>j", "<Plug>(coc-diagnostic-prev)", { silent = true })
map.set("n", "<leader>k", "<Plug>(coc-diagnostic-next)", { silent = true })
map.set("n", "t", ":call CocActionAsync('doHover')<CR>", { silent = true })

-- Copilot
map.set('i', '<C-b>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
