# Dotfiles setup

Dotfiles & system config with included setup script. Usage:

```sh
cd $HOME \
  && git clone git@github.com-personal:mark-gerarts/dotfiles-ubuntu.git dotfiles \
  && cd dotfiles \
  && chmod +x setup.sh \
  && ./setup.sh --force \
  && ./.distrobox/setup.sh
```

Subsequent runs do not require `--force`.

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
cat flatpak-apps.list | xargs -n 1 flatpak install
```
