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
map.set("n", "t", "vim.fn.CocActionAsync('doHover')", {silent = true})
vim.keymap.set('i', '<C-b>', 'copilot#Accept("\\<CR>")', {expr = true, replace_keycodes = false })
