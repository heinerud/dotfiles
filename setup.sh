#!/bin/bash

set -e

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

if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


if [[ ! -d ~/.pyenv ]]; then
    curl https://pyenv.run | bash
    pyenv doctor
fi


mkdir -p ~/.local/bin
mkdir -p ~/.vimswap

if [[ ! -f ~/.local/bin/fd ]]; then
    ln -s $(which fdfind) ~/.local/bin/fd
fi


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

echo Links to config files...

echo Fonts...
