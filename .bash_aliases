#
# Docker
#
alias docker-composer="docker-compose"
alias dcup="docker-compose up -d"
alias dcstop="docker-compose stop"
alias dcexec="docker exec -it --user=$(id -u):$(id -g) -w /var/www/html"

#
# General
#

alias poweroff='sudo poweroff'
alias reboot='sudo reboot'
alias ll='ls -lhAF --color=always'
alias ls="ls -CF"
alias sl="ls"
alias cd..="cd .."
alias fhere="find . -name"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias prettyjson="python -m json.tool"
alias yt3="youtube-dl --extract-audio --audio-format mp3 --output \"%(title)s.%(ext)s\""

# xclip
alias cclip='xclip -selection clipboard'

#
# Vagrant
#

alias vg-reset="vagrant halt && vagrant up && vagrant ssh"
alias vg-up="vagrant up && vagrant ssh"

#
# Git
#

alias it="git"
alias gti="git"
alias gpr="git pull --rebase"
alias gmn="git merge --no-ff"
alias gsp="git stash pop"
# git log graph
alias glg="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(blue)- [%an]%C(reset)%C(bold yellow)%d%C(reset)'"
# glg for all branches
alias glga="git log --branches --remotes --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(blue)- [%an]%C(reset)%C(bold yellow)%d%C(reset)'"
alias gls="glg"
# Example: diffcount develop...feature/branch
alias diffcount="git rev-list --left-right --count"
alias git-latest-tag="git describe --abbrev=0 --tags"
alias leaderboard="git shortlog -sn"
alias spp="~/.spp.sh"

#
# SSH
#

alias ssh-dev1="ssh mgerarts@dev01.nascom-ops.net"
alias ssh-dev2="ssh mgerarts@dev02.nascom-ops.net"
alias ssh-dev3="ssh mgerarts@dev03.nascom-ops.net"
alias ssh-bender="ssh mgerarts@bender.nascomdev.be"

#
# Symfony
#
alias bc="bin/console"
alias bcc="bin/console cache:clear"
alias phpspec="vendor/bin/phpspec"
# Copies a regex to the clipboard that can be used to search a translation file for (mostly) untranslated strings.
alias untranslated="echo -n \"<target.*>[^\s]*\.[^\s]*</target>\" | cclip | echo \"Copied to clipboard!\""
alias untranslated-csv="echo -n \";(\\\"|)[^\s]*\.[^\s]*\" | cclip | echo \"Copied to clipboard!\""

#
# Drupal
#
alias drupal="vendor/bin/drupal"

#
# Lisp
#
alias sbcl ="rlwrap sbcl"

#
# Docker
#
alias docker-composer="docker-compose"
