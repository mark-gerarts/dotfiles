#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

OS="debian"
grep openSUSE /etc/issue > /dev/null && OS="OpenSUSE"

FORCE=false
[[ $* == *--force* ]] && FORCE=true

install_system_packages() {
    common_packages=(
        "git"
        "ripgrep"
        "emacs"
        "docker"
        "docker-compose"
        "sbcl"
        "rlwrap"
        "chromium"
    )
    os_specific_packages=(
        "firefox"
        "pass"
    )
    if [ $OS = "OpenSUSE" ]; then
        os_specific_packages=(
            "MozillaFirefox"
            "password-store"
            "docker-compose-switch"
        )
    fi

    packages=("${common_packages[@]}" "${os_specific_packages[@]}")

    for package in "${packages[@]}"; do
        if [ $OS = "OpenSUSE" ]; then
            rpm -q "$package" > /dev/null || sudo zypper in --no-confirm --no-recommends "$package"
        else
            dpkg -l "$package" > /dev/null || sudo apt install -y "$package"
        fi
    done
}

configure_system() {
    if $FORCE; then
        sudo visudo -c -f "$SCRIPT_DIR/etc/sudoers.d/custom-sudoers" > /dev/null \
            && sudo cp "$SCRIPT_DIR/etc/sudoers.d/custom-sudoers" /etc/sudoers.d/custom-sudoers \
            && sudo chmod 440 /etc/sudoers.d/custom-sudoers
    fi
}

create_symlinks() {
    if [ $OS = "OpenSUSE" ]; then
        ln -sf "$SCRIPT_DIR/.bash_aliases" "$HOME/.alias"
    else
        ln -sf "$SCRIPT_DIR/.bash_aliases" "$HOME/.bash_aliases"
    fi

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

    [ ! -d "$HOME/.npm-packages" ] && mkdir "$HOME/.npm-packages"
    ln -sf "$SCRIPT_DIR/.npmrc" "$HOME/.npmrc"

    [ -d "$HOME/.scripts" ] && rm -r "$HOME/.scripts"
    ln -sf "$SCRIPT_DIR/.scripts" "$HOME/.scripts"

    ln -sf "$SCRIPT_DIR/.pylintrc" "$HOME/.pylintrc"

    ln -sf "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"

    ln -sf "$SCRIPT_DIR/.sbclrc" "$HOME/.sbclrc"
}

setup_vscode() {
    if code -v &> /dev/null; then
        # Get any extensions that are part of the repo but not yet installed, and install them.
        INSTALLED_EXTENSIONS=$(code --list-extensions | sort)
        ALL_EXTENSIONS=$(sort "$SCRIPT_DIR/.config/Code/User/extensions.list")
        EXTENSIONS_TO_INSTALL=$(comm -13 <(echo "$INSTALLED_EXTENSIONS") <(echo "$ALL_EXTENSIONS"))
        [ -n "${EXTENSIONS_TO_INSTALL// }" ] && echo "$EXTENSIONS_TO_INSTALL" | xargs -n 1 code --install-extension

        # Update the extensions list if there are any extensions installed but not yet part of the repo.
        code --list-extensions > "$SCRIPT_DIR/.config/Code/User/extensions.list"
    fi
}

setup_doom_emacs() {
    [ -d "$HOME/.doom.d" ] && rm -r "$HOME/.doom.d"
    ln -s "$SCRIPT_DIR/.doom.d" "$HOME/.doom.d"

    if [ ! -f "$HOME/.emacs.d/bin/doom" ]
    then
        git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.emacs.d"
        "$HOME/.emacs.d/bin/doom" sync
    fi
}

install_system_packages
configure_system
create_symlinks
setup_vscode
setup_doom_emacs
