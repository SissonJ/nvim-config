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
set.signcolumn = "yes" -- Stop text shifting when diagnostics appear
set.whichwrap = "h,l"

-- ==========================================================================
-- 3. PLUGIN SPECS
-- ==========================================================================
require("lazy").setup({
  -- UI & Themes
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      g.gruvbox_material_background = "hard"
      g.gruvbox_material_better_performance = 1
      vim.cmd("colorscheme gruvbox-material")
    end,
  },
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
  { "scrooloose/nerdtree" },
  { "ctrlpvim/ctrlp.vim" },
  { "stevearc/dressing.nvim" }, -- Required for Avante UI
  { "nvim-tree/nvim-web-devicons" }, 

  -- Languages & CoC
  { "neoclide/coc.nvim", branch = "release" },
  { "posva/vim-vue" },
  { "tomlion/vim-solidity" },
  
  -- Note: ALE and Rust.vim removed. 
  -- CoC handles linting/formatting via coc-eslint and coc-rust-analyzer.
  -- Treesitter handles syntax highlighting.

  -- Copilot (Official)
  { "github/copilot.vim" },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      model = "auto",
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },

  -- Avante (The Agent)
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "HakonHarnes/img-clip.nvim",
    },
    config = function()
      require('avante').setup({
        provider = "gemini",
        providers = {
          gemini = {
            model = "gemini-2.0-flash-lite", 
            extra_request_body = {
              temperature = 1.0,
            },
          },
        },
        behaviour = {
          auto_suggestions = false, 
        },
      })
    end,
  },
},{
  rocks = { enabled = false },
})

-- ==========================================================================
-- 4. KEYBINDINGS & CONFIG
-- ==========================================================================

-- CoC Settings
g.copilot_no_tab_map = true

-- CtrlP Ignore settings
g.ctrlp_custom_ignore = {
  dir = [[\v[\/](\.(git|hg|svn|buildozer)|node_modules|target|compiled|dist)$]],
  file = [[\v\.(o|pyc|lock)$]]
}

-- CoC Extensions List (CoC will auto-install these)
g.coc_global_extensions = {
  'coc-tsserver',
  'coc-eslint',
  'coc-json',
  '@yaegassy/coc-volar', 
  'coc-rust-analyzer',
}

local map = vim.keymap

-- Fix for :W and :Wq typos (Use User Commands, not maps)
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})

-- Window Navigation
map.set('n', '<C-j>', '<C-w>j')
map.set('n', '<C-k>', '<C-w>k')
map.set('n', '<C-h>', '<C-w>h')
map.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
map.set('n', '<C-n>', ':NERDTreeToggle<CR>')

-- CoC Mappings
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

-- Tab for CoC completion
map.set("i", '<TAB>', 'coc#pum#visible() ? coc#pum#confirm() : "<TAB>"', opts)

-- CoC GoTo Definitions
map.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
map.set("n", "<C-y>", '<Plug>(coc-rename)', {silent = true})
map.set("n", "<leader>j", "<Plug>(coc-diagnostic-prev)", {silent = true})
map.set("n", "<leader>k", "<Plug>(coc-diagnostic-next)", {silent = true})
map.set("n", "t", ":call CocActionAsync('doHover')<CR>", {silent = true})

-- Copilot specific mapping (Control + b to accept)
map.set('i', '<C-b>', 'copilot#Accept("\\<CR>")', {expr = true, replace_keycodes = false })

-- Chat Mappings
map.set("n", "<leader>cc", ":CopilotChatToggle<CR>", {silent = true})
map.set("n", "<leader>cq", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { sticky = "#buffer" })
  end
end, {silent = true, noremap = true, desc = "CopilotChat - Quick chat"})

-- Avante Mappings
map.set("n", "<leader>aa", "<cmd>AvanteToggle<CR>", { silent = true, desc = "Avante: Toggle" })
map.set("v", "<leader>ah", "<cmd>AvanteAsk<CR>", { silent = true, desc = "Avante: Selection Ask" })
map.set("n", "<leader>ae", "<cmd>AvanteEdit<CR>", { silent = true, desc = "Avante: Direct Edit" })
