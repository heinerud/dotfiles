#!/bin/bash

# set -e

# Apt packages
sudo apt update
sudo apt install -y \
    alacritty\
    tailscale\
    vim\
    tmux\
    fish\
    autojump\
    jq\
    ripgrep\
    tig\
    tldr\
    htop\
    fd-find\
    fzf\
    autojump\

# lazygit \
# lf
# docker
# pyenv
# tpm

# pipx

# Vim
mkdir -p ~/.vimswap

if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


if [[ ! -d ~/.pyenv ]]; then
    curl https://pyenv.run | bash
    pyenv doctor
fi


# Binaries
mkdir -p ~/.local/bin

if [[ ! -f ~/.local/bin/fd ]]; then
    ln -s $(which fdfind) ~/.local/bin/fd
fi


# Oh My Fish
if [[ ! -d ~/.local/share/omf ]]; then
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi

echo "omf install \
    agnoster\
    autojump\
    fzf\
    pyenv\
    colored-man-pages\
    " | fish

echo "omf theme agnoster" | fish


# Configurations
for f in $(git ls-files); do
    if [[ $f != $(basename $0) ]]; then
        ln -vfs $PWD/$f ~/$f
    fi
done


echo Fonts...
