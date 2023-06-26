# Dotfiles setup

## Initial setup

Install Ansible:

```
apt install ansible
```

Install the required plugins:

```
ansible-galaxy install gantsign.visual-studio-code \
  && ansible-galaxy collection install community.general
```

First run of Ansible:

```
curl https://raw.githubusercontent.com/mark-gerarts/dotfiles/master/playbook.yml \
  | ansible-playbook --ask-become-pass
```

This will install the dotfiles repo to `/home/mark/dotfiles`, where
subequent runs can be started.

## Usage

```
ansible-playbook /home/mark/dotfiles/playbook.yml --ask-become-pass
```

