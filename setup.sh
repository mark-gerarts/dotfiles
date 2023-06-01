#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

FORCE=false
[[ $* == *--force* ]] && FORCE=true

install_system_packages() {
    packages=(
        "docker"
        "docker-compose"
        "flatpak"
        "gnome-software-plugin-flatpak"
        "vim"
        "git"
        "distrobox"
    )

    for package in "${packages[@]}"; do
        dpkg -l "$package" > /dev/null || sudo apt install -y "$package"
    done

    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

install_flatpaks() {
    if flatpak --version &> /dev/null; then
        cat "$SCRIPT_DIR/flatpak-apps.list" | xargs -n 1 flatpak install -y
    fi
}

configure_system() {
    if $FORCE; then
        sudo visudo -c -f "$SCRIPT_DIR/etc/sudoers.d/custom-sudoers" > /dev/null \
            && sudo cp "$SCRIPT_DIR/etc/sudoers.d/custom-sudoers" /etc/sudoers.d/custom-sudoers \
            && sudo chmod 440 /etc/sudoers.d/custom-sudoers

        echo "DefaultTimeoutStopSec=10s" | sudo tee -a /etc/systemd/user.conf
    fi
}

create_symlinks() {
    ln -sf "$SCRIPT_DIR/.bash_aliases" "$HOME/.bash_aliases"

    ln -sf "$SCRIPT_DIR/.eslintrc.json" "$HOME/.eslintrc.json"

    [ ! -d "$HOME/.ssh" ] && mkdir "$HOME/.ssh"
    ln -sf "$SCRIPT_DIR/.ssh/config" "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"

    [ ! -d "$HOME/.config/Code/User" ] && mkdir -p "$HOME/.config/Code/User"
    ln -sf "$SCRIPT_DIR/.config/Code/User/settings.json" "$HOME/.config/Code/User/settings.json"
    ln -sf "$SCRIPT_DIR/.config/Code/User/keybindings.json" "$HOME/.config/Code/User/keybindings.json"

    [ ! -d "$HOME/.config/bat" ] && mkdir -p "$HOME/.config/bat"
    ln -sf "$SCRIPT_DIR/.config/bat/config" "$HOME/.config/bat/config"

    ln -sf "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"

    [ -d "$HOME/.scripts" ] && rm -r "$HOME/.scripts"
    ln -sf "$SCRIPT_DIR/.scripts" "$HOME/.scripts"

    ln -sf "$SCRIPT_DIR/.pylintrc" "$HOME/.pylintrc"

    ln -sf "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"

    ln -sf "$SCRIPT_DIR/.sbclrc" "$HOME/.sbclrc"

    [ ! -d "$HOME/.pulsar" ] && mkdir "$HOME/.pulsar"
    ln -sf "$SCRIPT_DIR/.pulsar/config.cson" "$HOME/.pulsar/config.cson"
    ln -sf "$SCRIPT_DIR/.pulsar/keymap.cson" "$HOME/.pulsar/keymap.cson"
}

install_system_packages
configure_system
create_symlinks
install_flatpaks
