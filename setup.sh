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
        "bat"
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
            "libicu72"
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

    # Setup NPM
    [[ ! -d "$HOME/.nvm" ]] && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    node -v &> /dev/null || (nvm install 18 && nvm use --delete-prefix 18)

    # Setup dotnet
    DOTNET_SDK=dotnet-sdk-7.0
    if [ $OS = "OpenSUSE" ] && ! rpm -q $DOTNET_SDK > /dev/null; then
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        wget https://packages.microsoft.com/config/opensuse/15/prod.repo
        sudo mv prod.repo /etc/zypp/repos.d/microsoft-prod.repo
        sudo chown root:root /etc/zypp/repos.d/microsoft-prod.repo
        sudo zypper install $DOTNET_SDK
    fi
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

    [ -d "$HOME/.scripts" ] && rm -r "$HOME/.scripts"
    ln -sf "$SCRIPT_DIR/.scripts" "$HOME/.scripts"

    ln -sf "$SCRIPT_DIR/.pylintrc" "$HOME/.pylintrc"

    ln -sf "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"

    ln -sf "$SCRIPT_DIR/.sbclrc" "$HOME/.sbclrc"

    [ ! -d "$HOME/.pulsar" ] && mkdir "$HOME/.pulsar"
    ln -sf "$SCRIPT_DIR/.pulsar/config.cson" "$HOME/.pulsar/config.cson"
    ln -sf "$SCRIPT_DIR/.pulsar/keymap.cson" "$HOME/.pulsar/keymap.cson"
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

install_system_packages
configure_system
create_symlinks
setup_vscode
