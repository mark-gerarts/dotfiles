# Dotfiles

## Initial setup

Install Ansible:

```sh
apt install ansible git
```

Install the required plugins:

```sh
ansible-galaxy install gantsign.visual-studio-code \
  && ansible-galaxy collection install community.general
```

Clone this repo to the expected location:

```sh
git clone git@github.com:mark-gerarts/dotfiles.git /home/mark/dotfiles
```

## Usage

```sh
ansible-playbook /home/mark/dotfiles/playbook.yml --ask-become-pass
```

## Todos

- Install some remaining packages (aws/azure/gcloud/...)
- Automate https://qwerty-fr.org/
- Automate gnome setup:
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
    - Caffeine
    - PaperWM?
    - Transparent
    - Make smaller
    - Remove trash icon, unpin defaults
    - Uncheck show overview on startup
