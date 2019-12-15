#!/bin/bash

## Bootstrap configuration based on Ubuntu

GIT_USER_NAME=""
GIT_USER_EMAIL=""

NODE_VERSION="10.16.0"

CURRENT_PATH=`pwd`

# Add required ppa respositories
sudo apt-add-repository ppa:kgilmer/regolith-stable
sudo apt-add-repository ppa:mozillateam/firefox-next

# Update system packages
sudo apt update
sudo apt upgrade -y

# Install i3 based desktop
sudo apt install -y regolith-desktop
ln -s $CURRENT_PATH/regolith ~/.config

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
ln $CURRENT_PATH/.zshrc ~

# Install and configure node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
nvm install $NODE_VERSION
exec $CURRENT_PATH/node/global-packages.sh

# Install and configure VS Code
sudo snap install code
exec $CURRENT_PATH/vs-code/extensions.sh
ln $CURRENT_PATH/vs-code/keybindings.json .config/Code/User
ln $CURRENT_PATH/vs-code/settings.json .config/Code/User
ln -s $CURRENT_PATH/vs-code/snippets .config/Code/User

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

# Install Micro text editor
sudo snap install micro

# Install Gimp
sudo apt install -y gimp

# Install Inkspace
sudo apt install -y inkspace

# Install Flameshot
sudo apt install -y flameshot

# Install Simplescreenrecorder
sudo apt install -y simplescreenrecorder

# Install Spotify
sudo snap install spotify

# Misc
mkdir -p $CURRENT_PATH/Projects/{Freelance,Personal}
ln $CURRENT_PATH/wallpaper.jpg ~/Pictures