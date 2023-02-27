#!/bin/sh

# Install all required packages
sudo apt-get update
curl -LJO https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo dpkg -i ./nvim-linux64.deb
sudo apt-get install -f
sudo apt-get install zip git python3 golang-go gdu ripgrep -y
# lazygit
# bottom

# Install win32yank (comment out the lines below if you are not used wsl2)
curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/

# Copy AstroNvim config
if [ ! -d ~/.config/nvim ]; then
  git clone -b v2.11.8 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
fi

# Copy custom config
if [ ! -d ~/.config/nvim/lua/user ]; then
  mkdir ~/.config/nvim/lua/user
  cp -r ./init.lua ~/.config/nvim/lua/user/init.lua
fi

nvim --headless -c "autocmd User PackerComplete quitall"
