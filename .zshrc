# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# EXPORTS
# Dotfiles easy-access
export DOTFILES=$HOME/.dotfiles
# Default shell (I know this is a bit redundant inside a .zshrc buuuut)
export SHELL=/bin/zsh
# Homebrew cask parameters
export HOMEBREW_CASK_OPTS="--appdir=/Applications --fontdir=/Library/Fonts"
# Custom folder for oh-my-zsh
export ZSH_CUSTOM=$DOTFILES/zsh-custom

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$PATH:$DOTFILES/bin/usr"
export GOPATH="$HOME/.go"
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export EDITOR='vim'
export TERM=xterm-256color

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

eval "$(rbenv init -)"

# Set name of the theme to load.
ZSH_THEME="spaceship"
# ZSH_THEME="eramdam"

plugins=(
# OSX specific stuff
osx
# Copies the current pwd to clipboard
copydir
# Copies a file content in clipboard
copyfile
# cp with progress using rsync
cp
# plugin for http://sprunge.us/
sprunge
# Fish-like autosuggestions
zsh-autosuggestions
# ssh-agent forwarding/credentials
ssh-agent
emoji
# jump around
z
)

# PULL THE LEVER ON OH-MY-ZSH 🔥
source $ZSH/oh-my-zsh.sh
# Source k and z 🔥
source $DOTFILES/bin/core/k/k.sh

# Enable ssh-agent forwarding
zstyle :omz:plugins:ssh-agent agent-forwarding on


# Sweet emoji for each session
session_emoji=`random_emoji fruits`
# session_emoji=''
# Change the window/tab title with current path + session's emoji
precmd () {
  tab_label=${PWD/${HOME}/\~} # use 'relative' path
  echo -ne "\e]2;${tab_label}\a" # set window title to full string
  echo -ne "\e]1;${session_emoji} ${tab_label}\a" # set tab title to rightmost 24 characters
}
title() {}

# Don't spam history w/ "clear"
HIST_IGNORE_SPACE="clear"
DISABLE_AUTO_UPDATE="false"
# DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="false"

#############
## ALIASES ##
#############

# A nice clock because why not? 
alias clock="${DOTFILES}/bin/usr/tty-clock -bsC 4"

# Relaunch your shell, quick'n'easy
alias reshell='exec $SHELL -l'

# Go back to the root of a git repo
alias groot='cd $(git rev-parse --show-cdup)'
# Open Github.app
alias gh="github ."

# VSCode
alias c="code"
alias cc="code ."

# thefuck => wtf
alias wtf='$(thefuck $(fc -ln -1))'

# k is the new l, yo
alias l="k --no-vcs -h"
alias ll="k --no-vcs -ah"
alias lg="k -ah"

# Outputs an ordered list of the sizes of folder/files in the current path
alias sort-sizes="du -h --max-depth=1 | sort -h"

# Upgrades the node version
alias upgrade-node="nvm install node --reinstall-packages-from=node"

# SPACESHIP
SPACESHIP_PROMPT_ORDER=(
  user
  dir
  exec_time
  line_sep
  git
  exit_code
  char
)

export SPACESHIP_PROMPT_SYMBOL='»'
export SPACESHIP_PROMPT_ADD_NEWLINE=false
export SPACESHIP_GIT_BRANCH_PREFIX=``
export SPACESHIP_GIT_PREFIX="%{$fg[magenta]%}<"
export SPACESHIP_GIT_SUFFIX="%{$fg[magenta]%}>%{$reset_color%} "
export SPACESHIP_TIME_SHOW=true
export SPACESHIP_GIT_STATUS_COLOR='magenta'
export SPACESHIP_GIT_BRANCH_COLOR='magenta'
export SPACESHIP_GIT_STATUS_PREFIX=''
export SPACESHIP_GIT_STATUS_SUFFIX=''