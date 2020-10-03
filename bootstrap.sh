#!/bin/bash

## Bootstrap configuration based on Ubuntu

GIT_USER_NAME="Brennedith Garcia"
GIT_USER_EMAIL="brennedith@pm.me"

NODE_VERSION="12.18.4"
DENO_VERSION="1.4.4"

# Update system packages
sudo apt update
sudo apt upgrade -y

# Install and configure git
sudo apt install -y git
git config --global user.name $GIT_USER_NAME
git config --global user.email $GIT_USER_EMAIL
git config --global core.excludesfile "~/.gitignore"
echo COMMIT_MSG > ~/.gitignore

# Install the fuck
sudo apt install -y python3-dev python3-pip python3-setuptools
sudo pip3 install thefuck

# Install and configure zsh and OhMyZsh
sudo apt install zsh curl
curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash
rm ~/.zshrc
ln $PWD/zshrc ~/.zshrc

# Install and configure node+deno
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
nvm install $NODE_VERSION

curl -fsSL https://deno.land/x/dvm/install.sh | bash
dvm install $DENO_VERSION

# Install and configure Neovim
sudo apt install neovim
ln -s $PWD/nvim ~/.config/nvim

# Install and configure touchegg
# TODO: Install touchegg
ln -s $PWD/touchegg ~/.config/touchegg

# Install and configure batcat
# TODO: Install batcat
# TODO: Configure batcat
