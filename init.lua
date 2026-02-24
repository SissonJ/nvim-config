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
  { "scrooloose/nerdtree" },
  { "ctrlpvim/ctrlp.vim" },
},{
  rocks = { enabled = false },
})

-- ==========================================================================
-- 4. KEYBINDINGS & CONFIG
-- ==========================================================================

g.ctrlp_custom_ignore = {
  dir = [[\v[\/](\.(git|hg|svn|buildozer)|node_modules|target|compiled|dist)$]],
  file = [[\v\.(o|pyc|lock)$]]
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
