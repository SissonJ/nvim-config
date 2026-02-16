return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'rebelot/kanagawa.nvim'
  use 'ctrlpvim/ctrlp.vim'
  use 'scrooloose/nerdtree'
  use 'posva/vim-vue'
  use 'ivanceras/rust-vim-setup'
  use 'rust-lang/rust.vim'
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'dense-analysis/ale'
  use 'github/copilot.vim'
  use 'vimsence/vimsence'
  use 'zbirenbaum/copilot.lua'
  use 'nvim-lua/plenary.nvim'
  use { "tomlion/vim-solidity" }
  use ({
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main", -- Specify branch explicitly
    dependencies = {
      { "github/copilot.vim" }, -- Or { "zbirenbaum/copilot.lua" }
      { "nvim-lua/plenary.nvim", branch = "master" }, -- For essential functions
    },
    build = "make tiktoken", -- Only required on MacOS/Linux
    opts = {
      -- Add any custom configuration options here
    },
  })
  use({
    'yetone/avante.nvim',
    run = 'make', -- Builds the shared libraries for the agent
    requires = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- Optional, for icons
      "HakonHarnes/img-clip.nvim",   -- For pasting images (CSS/UI work)
    },
    config = function()

    require('avante').setup({
	  provider = "gemini",
	  providers = {
	    gemini = {
	      model = "gemini-3-pro-preview", -- Your Pro model
	      -- Use extra_request_body for parameters like temperature
	      extra_request_body = {
		temperature = 1.0,
	      },
	    },
	  },
	})
	end
  })
end)
