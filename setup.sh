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

# Install neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim


# Install vim setup dependencies
python2 -m pip install --user --upgrade pynvim
python3 -m pip install --user --upgrade pynvim
npm install -g neovim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cargo install bat
cargo install devicon-lookup

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

sudo apt-get install -y silversearcher-ag

