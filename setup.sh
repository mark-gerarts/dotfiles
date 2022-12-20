#/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ln -sf $SCRIPT_DIR/.bash_aliases $HOME/.bash_aliases

ln -sf $SCRIPT_DIR/.eslintrc.json $HOME/.eslintrc.json

[ ! -d "$HOME/.ssh" ] && mkdir $HOME/.ssh
ln -sf $SCRIPT_DIR/.ssh/config $HOME/.ssh/config
chmod 600 $HOME/.ssh/config

[ ! -d "$HOME/.config/Code/User" ] && mkdir -p $HOME/.config/Code/User
ln -sf $SCRIPT_DIR/.config/Code/User/settings.json $HOME/.config/Code/User/settings.json
ln -sf $SCRIPT_DIR/.config/Code/User/keybindings.json $HOME/.config/Code/User/keybindings.json

[ ! -d "$HOME/.config/bat" ] && mkdir -p $HOME/.config/bat
ln -sf $SCRIPT_DIR/.config/bat/config $HOME/.config/bat/config

ln -sf $SCRIPT_DIR/.gitconfig $HOME/.gitconfig

[ ! -d "$HOME/.npm-packages" ] && mkdir $HOME/.npm-packages
ln -sf $SCRIPT_DIR/.npmrc $HOME/.npmrc

ln -sf $SCRIPT_DIR/.scripts $HOME/.scripts

ln -sf $SCRIPT_DIR/.pylintrc $HOME/.pylintrc

ln -sf $SCRIPT_DIR/.vimrc $HOME/.vimrc

if code -v &> /dev/null
then
    # Get any extensions that are part of the repo but not yet installed, and install them.
    INSTALLED_EXTENSIONS=$(code --list-extensions)
    ALL_EXTENSIONS=$(cat $SCRIPT_DIR/.config/Code/User/extensions.list)
    EXTENSIONS_TO_INSTALL=$(comm -13 <(echo "$INSTALLED_EXTENSIONS") <(echo "$ALL_EXTENSIONS"))
    [ ! -z "${EXTENSIONS_TO_INSTALL// }" ] && echo "$EXTENSIONS_TO_INSTALL" | xargs -n 1 code --install-extension

    # Update the extensions list if there are any extensions installed but not yet part of the repo.
    code --list-extensions > $SCRIPT_DIR/.config/Code/User/extensions.list
fi
