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

To sync VSCode extensions:

```bash
code --list-extensions | sort > .distrobox/extensions.list
```
