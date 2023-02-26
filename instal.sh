#!/bin/sh

# Install all required packages
sudo apt-get update
curl -LJO https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo dpkg -i ./nvim-linux64.deb
sudo apt-get install -f
sudo apt-get install git python3 golang-go gdu ripgrep -y
# lazygit
# bottom

# Copy AstroNvim config
if [ ! -d ~/.config/nvim ]; then
  git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
fi

# Copy custom config
if [ ! -d ~/.config/nvim/lua/user ]; then
  mkdir ~/.config/nvim/lua/user
  cp -r ./init.lua ~/.config/nvim/lua/user/init.lua
fi

nvim --headless -c "autocmd User PackerComplete quitall"
