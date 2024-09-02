#!/bin/bash

set -e

# TODO
# viddy: https://github.com/sachaos/viddy
# test with docker

function install-common {
    # vim-plugin-manager
    mkdir -p ~/.vimswap
    if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # tmux-plugin-manager
    if [[ ! -d ~/.tmux/plugins/tpm ]]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    uv tool install ruff

    # oh-my-fish
    if [[ ! -d ~/.local/share/omf ]]; then
        curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    fi
    echo "omf install \
        agnoster\
        colored-man-pages\
        fzf\
        " | fish
    echo "omf theme agnoster" | fish

    # config-files
    pushd config
    find . -type d | while read d; do
        mkdir -pv "$HOME/$d"
    done

    find . -type f | while read f; do
        ln -vfs "$PWD/$f" "$HOME/$f"
    done
    popd

    vim -c "PlugUpdate" -c ":qa"

    tmux run-shell ~/.tmux/plugins/tpm/bindings/install_plugins
    tmux send-keys 'Escape'
}

function install-font-hack {
    if [[ ! -d $1 ]]; then
        wget --directory-prefix /tmp \
            https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip
        unzip /tmp/Hack.zip -d $1
    fi
}

function common-packages {
    echo\
        alacritty\
        autojump\
        cmake\
        fish\
        fzf\
        highlight\
        jq\
        lf\
        ncdu\
        ripgrep\
        tailscale\
        tig\
        tldr\
        tmux\
        tree\
        vim\
        watch\
        wget
}

function install-mac {
    brew update

    brew install $(common-packages)

    brew install\
        fd\
        lazygit\
        uv\

    brew install --cask\
        audio-hijack\
        backblaze\
        calibre\
        docker\
        firefox\
        karabiner-elements\
        loopback\
        loupedeck\
        messenger\
        microsoft-remote-desktop\
        obsidian\
        scroll-reverser\
        slack\
        spotify\
        telegram

    install-common
    install-font-hack ~/Library/fonts/hack
}

function install-linux {
    sudo apt-get update
    sudo apt-get install -y \
        ca-certificates\
        curl\
        gnupg

    # Docker
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
        sudo gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch="$(dpkg --print-architecture)" \
      signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Tailscale
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/lunar.noarmor.gpg | \
        sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/lunar.tailscale-keyring.list | \
        sudo tee /etc/apt/sources.list.d/tailscale.list

    sudo apt-get update
    sudo apt-get install -y $(common-packages)
    sudo apt-get install -y \
        cifs-utils\
        docker-ce\
        docker-ce-cli\
        containerd.io\
        docker-buildx-plugin\
        docker-compose-plugin\
        fd-find\
        git\
        gnome-tweaks\
        htop\
        input-remapper\
        nethogs\
        remmina\
        thunderbird\
        traceroute\
        wl-clipboard\
        xclip

    mkdir -p ~/.local/bin
    if [[ ! -f ~/.local/bin/fd ]]; then
        ln -s $(which fdfind) ~/.local/bin/fd
    fi

    # lazygit
    if [[ ! -f ~/.local/bin/lazygit ]]; then
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar -C /tmp -xvf /tmp/lazygit.tar.gz lazygit
        sudo install /tmp/lazygit ~/.local/bin
    fi

    # uv
    curl -LsSf https://astral.sh/uv/install.sh | sh


    install-font-hack ~/.local/share/fonts/hack
    fc-cache -f -v

    install-common

    sudo tailscale up --ssh
}


if [ "$(uname)" == "Darwin" ]; then
    install-mac
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    install-linux
fi

echo
echo " - chsh -s \$(which fish)"
echo " - $ sudo docker run hello-world"

# TODO:
#  - ssh config
#  - ssh keys
