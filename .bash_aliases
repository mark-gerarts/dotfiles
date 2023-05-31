export PATH=/home/mark/.npm-packages/bin:$PATH
export PATH=/home/mark/.local/bin:$PATH

alias ll="ls -vlAh --color=auto --group-directories-first"
alias ..="cd .."
alias u="cd .."
alias uu="cd ../.."
alias uuu="cd ../../.."
alias cd..="cd .."

alias docker-composer="docker compose"
alias docker-compose="docker compose"

alias sl="ls"
alias it="git"
alias gti="git"
alias gut="git"
alias glg="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(blue)- [%an]%C(reset)%C(bold yellow)%d%C(reset)'"
alias gls="glg"
alias spp="\$HOME/.scripts/spp.sh"

alias poweroff="[[ -z \"${CONTAINER_ID}\" ]] && sudo poweroff || distrobox-host-exec /sbin/poweroff"
alias reboot="[[ -z \"${CONTAINER_ID}\" ]] && sudo reboot || distrobox-host-exec /sbin/reboot"

alias cclip="xclip -selection clipboard"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias sbcl="rlwrap sbcl"

alias todos="vim ~/.todos.md"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias node-repl="noderepl"
noderepl() {
    FILE_CONTENTS="$(< "$1" )"
    node -i -e "$FILE_CONTENTS"
}

export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
BYELLOW='\[\e[1;33m\]'
BWHITE='\[\e[1;37m\]'
function smile_prompt
{
  if [ "$?" -eq "0" ]; then
    SC="${GREEN}:)"
  else
    SC="${RED}:("
  fi
  if [ $UID -eq 0 ]; then
    UC="${RED}"
  else
    UC="${BYELLOW}"
  fi
  #hostname color
  HC="${BYELLOW}"
  #regular color
  RC="${BWHITE}"
  #default color
  DF='\[\e[0m\]'
  PS1="[${UC}\u${RC}@${HC}\h${RC}:\w${DF}] ${SC}${DF} "

  [[ $(type -t __vte_prompt_command) == function ]] && __vte_prompt_command
}
PROMPT_COMMAND="smile_prompt"

HISTCONTROL=ignoredups:erasedups
HISTSIZE=20000
HISTFILESIZE=20000

# Save to bash history on every prompt.
shopt -s histappend
# TODO: this doesn't seem to work properly in combination with smile_prompt
PROMPT_COMMAND="$PROMPT_COMMAND;history -a;"

# Allow bookmarking directories:
# $ mark @name
# $ cd @name
# $ cd @<tab> # List all available bookmarks
# Credit: https://news.ycombinator.com/item?id=35122780
mkdir -p ~/.marks/
export CDPATH=.:~/.marks/
function mark { ln -sr "$(pwd)" ~/.marks/"$1"; }
