#!/bin/sh

# Install all required packages
sudo apt-get update
sudo apt-get install zip git lua5.4 python3 golang-go gdu ripgrep -y

# Install neovim
curl -sLo /tmp/nvim.deb https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo dpkg -i /tmp/nvim.deb
sudo apt-get install -f

# Install bottom
curl -sLo /tmp/bottom.deb https://github.com/ClementTsang/bottom/releases/download/0.8.0/bottom_0.8.0_amd64.deb
sudo dpkg -i /tmp/bottom.deb
sudo apt-get install -f

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf /tmp/lazygit.tar.gz -C /usr/local/bin lazygit

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

nvim --headless -c  'autocmd User PackerComplete qall' -c 'sleep 100' -c 'silent PackerSync' -c 'sleep 100' -c 'qall'
nvim --headless -c 'TSInstall bash css dockerfile go graphql html javascript json lua markdown php phpdoc scss tsx twig typescript vue yaml' -c 'sleep 30' -c 'qall'
