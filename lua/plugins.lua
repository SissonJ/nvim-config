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
end)
