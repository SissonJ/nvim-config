// move config to correct dir
mkdir -p ~/.config/nvim
mv nvim-config/* ~/.config/nvim/
// Install nvim
sudo apt install -y neovim
// Install packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

// Open nvim and run :PackerSync
// Restart nvim
