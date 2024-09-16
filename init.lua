require('plugins')

vim.cmd("colorscheme kanagawa")

local set = vim.o
set.mouse = false
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.number = true
set.relativenumber = true
set.updatetime = 300
set.fileformat = unix
set.swapfile = false
set.whichwrap = h,l

local setg = vim.g
setg.rustfmt_autosame = 1
setg.rustfmt_emit_files = 1
setg.rustfmt_fail_silently = 0
setg.ale_sign_column_always = 1
setg.ale_fixers = { javascript= {'eslint', 'stylelint'},typescript= {'eslint'},vue={'eslint', 'stylelint'},css={'eslint', 'stylelint'},scss={'eslint', 'stylelint'}} 
setg.ale_linters = { javascript= {'eslint', 'stylelint'},typescript= {'eslint'},vue={'eslint', 'stylelint'},css={'eslint', 'stylelint'},scss={'eslint', 'stylelint'} }
setg.ale_fix_on_save = 1
setg.ale_lint_on_save = 1
setg.ctrlp_custom_ignore = {dir = [['\v[\/](\.(git|hg|svn|buildozer)|node_modules|target|compiled|dist)$']], file = 'lock'}
setg.copilot_no_tab_map = true
setg.mapleader = ' '
setg.coc_global_extensions = {
  'coc-tsserver', 
  'coc-eslint', 
  'coc-json', 
  '@yaegassy/coc-volar', 
  'coc-rust-analyzer',
}
-- 'coc-prettier', 
-- 'coc-yank', 
-- 'coc-snippets', 
-- 'coc-highlight', 
-- 'coc-lists', 'coc-git', 'coc-fzf-preview', 'coc-dictionary', 'coc-docker', 'coc-deno', 'coc-calc'}

local map = vim.keymap
map.set('n', ':W', ':w')
map.set('n', ':Wq', ':wq')
map.set('n', '<C-j>', '<C-w>j')
map.set('n', '<C-k>', '<C-w>k')
map.set('n', '<C-h>', '<C-w>h')
map.set('n', '<C-l>', '<C-w>l')
map.set('n', '<C-n>', ':NERDTreeToggle<CR>')

local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
map.set("i", '<TAB>', 'coc#pum#visible() ? coc#pum#confirm() : "<TAB>"', opts)
map.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
map.set("n", "<C-y>", '<Plug>(coc-rename)', {silent = true})
map.set("n", "<C-i>", "<Plug>(coc-diagnostic-prev)", {silent = true})
map.set("n", "<C-I>", "<Plug>(coc-diagnostic-next)", {silent = true})
map.set("n", "t", ":call CocActionAsync('doHover')<CR>", {silent = true})
vim.keymap.set('i', '<C-b>', 'copilot#Accept("\\<CR>")', {expr = true, replace_keycodes = false })
map.set("n", "<leader>a", "print('hello')", {silent = true})
