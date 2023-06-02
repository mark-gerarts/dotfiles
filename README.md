# Dotfiles setup

Dotfiles & system config with included setup script. Usage:

```sh
cd $HOME \
  && git clone git@github.com-personal:mark-gerarts/dotfiles.git dotfiles \
  && cd dotfiles \
  && ./setup.sh --force \
```

Subsequent runs do not require `--force`.

## Steps on fresh installation

After having done the initial setup above, perform the following manual steps (untill automated):

- `sudo usermod -aG docker mark`
- Relog
- `cd ~/dotfiles/.distrobox/ && ./setup.sh`
- `sudo vim /etc/default/grub` -> change timeout/splash etc

Install keyboard layout (can also be automated):

- https://qwerty-fr.org/
- `sudo apt install ./qwerty-fr*` 

Gnome setup:

- Tweak tool
  - Keyboard & Mouse -> Additional layout options -> Caps lock is ctrl
  - Windows titlebars -> Check max/minimize
- Nautilus
  - Set to list view and zoom out
  - Show hidden files
- GNOME software
  - Uninstall extensions
  - Uninstall other unused software
- Terminal
  - Shortcuts -> Switch to next/previous -> Alt left/right
  - Profiles -> Font size to 12; Color scheme to dark; disable limit scrollback
  - Clone default profile, set name to "distrobox", set "distrobox enter X" as command
- Settings
  - Multitasking -> Disable hot corner
  - Keyboard -> shortcuts
    - Home folder Ctrl+E
    - gnome-terminal Ctrl+Alt+T "gnome-terminal --profile Distrobox"
    - gnome-terminal Super+Enter "gnome-terminal"
    - "Switch windows" to Alt-Tab
- Extension manager
  - Blur my shell
  - Dash to dock
- Dash to dock
  - Transparent
  - Make smaller
  - Remove trash icon, unpin defaults
  - Uncheck show overview on startup

## VSCode

To export VSCode extensions:

```bash
code --list-extensions | sort > .distrobox/extensions.list
```

## Flatpaks

To export installed flatpak apps:

```bash
flatpak list --app | awk -F '\t' '{print $2}' > flatpak-apps.list
```

To install all synced apps:

```bash
cat flatpak-apps.list | xargs -n 1 flatpak install -y
```

## TODO

- setup.sh apt install command is broken
- Enable qwerty-fr
