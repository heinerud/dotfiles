#!/usr/bin/bash

set -e

# Apt packages
sudo apt-get update
sudo apt-get install -y \
    ca-certificates\
    curl\
    gnupg\

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

# Spotify
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | \
    sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | \
    sudo tee /etc/apt/sources.list.d/spotify.list

# Tailscale
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/lunar.noarmor.gpg | \
    sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/lunar.tailscale-keyring.list | \
    sudo tee /etc/apt/sources.list.d/tailscale.list

sudo apt-get update
sudo apt-get install -y \
    alacritty\
    autojump\
    docker-ce\
    docker-ce-cli\
    containerd.io\
    docker-buildx-plugin\
    docker-compose-plugin\
    fd-find\
    fish\
    fzf\
    git\
    gnome-tweaks\
    highlight\
    htop\
    input-remapper\
    jq\
    lf\
    nethogs\
    pipx\
    remmina\
    ripgrep\
    spotify-client\
    tailscale\
    thunderbird\
    tig\
    tldr\
    tmux\
    traceroute\
    tree\
    vim\
    wget\
    wl-clipboard\
    xclip\


# User binaries
mkdir -p ~/.local/bin

if [[ ! -f ~/.local/bin/fd ]]; then
    ln -s $(which fdfind) ~/.local/bin/fd
fi


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
fi


# Tmux
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


# Python
if [[ ! -d ~/.pyenv ]]; then
    curl https://pyenv.run | bash
    pyenv doctor
fi

pipx install black
pipx install isort
pipx install pipenv


# Fish
if [[ ! -d ~/.local/share/omf ]]; then
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi

echo "omf install \
    agnoster\
    autojump\
    colored-man-pages\
    fzf\
    pyenv\
    " | fish

echo "omf theme agnoster" | fish


# Configurations
pushd config
find .* -type d | while read d; do
    mkdir -pv "$HOME/$d"
done

find .* -type f | while read f; do
    ln -vfs "$PWD/$f" "$HOME/$f"
done
popd


# Fonts
if [[ ! -d ~/.local/share/fonts/hack ]]; then
    wget --directory-prefix /tmp \
        https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip
    unzip /tmp/Hack.zip -d ~/.local/share/fonts/hack

    # Reload fonts
    fc-cache -f -v
fi

sudo tailscale up --ssh

vim \
    -c "PlugUpdate" \
    -c ":qa"

tmux run-shell ~/.tmux/plugins/tpm/bindings/install_plugins
tmux send-keys 'Escape'

echo
echo " - chsh -s \$(which fish)"
echo " - tmux: <prefix> + I"
echo " - $ pyenv doctor"
echo " - $ sudo docker run hello-world"

# TODO:
#  - ssh config
#  - ssh keys
