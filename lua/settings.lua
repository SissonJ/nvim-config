
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
