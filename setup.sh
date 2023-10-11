#!/bin/bash

# set -e

# Apt packages
sudo apt update
sudo apt install -y \
    alacritty\
    autojump\
    fd-find\
    fish\
    fzf\
    htop\
    jq\
    lf\
    pipx\
    ripgrep\
    tailscale\
    tig\
    tldr\
    tmux\
    vim\

# docker

# User binaries
mkdir -p ~/.local/bin

# Lazygit
if [[ ! -f ~/.local/bin/lazygit ]]; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar -C /tmp -xvf /tmp/lazygit.tar.gz lazygit
    sudo install /tmp/lazygit ~/.local/bin
fi

# Vim
mkdir -p ~/.vimswap
if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "Open vim and run PlugUpdate"
    read
fi

# Tmux
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "Open tmux and run <prefix> + I"
    read
fi

# Python
if [[ ! -d ~/.pyenv ]]; then
    curl https://pyenv.run | bash
    pyenv doctor
fi


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
