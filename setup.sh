#!/usr/bin/env bash


# System-wise settings
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

cat ./.zshrc >> ~/.zshrc
cp -R ./.config ~/

# Install oh my tmux
./tmux.sh
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf
cp ./.tmux.conf.local ~

# Install Python3
sudo apt-get install -y python-dev python-pip python3-dev
sudo apt-get install -y python3-setuptools
sudo easy_install3 pip

# Install Node.js
curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
sudo bash n lts

mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
npm install -g n

# Install redis
sudo apt-get install -y redis-server

# Create ssh key
ssh-keygen -t rsa