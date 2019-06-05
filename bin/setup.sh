#!/usr/bin/env bash

LOGO='
 ██████╗  █████╗ ███╗   ███╗██╗███████╗███╗   ██╗   ███████╗██╗  ██╗
 ██╔══██╗██╔══██╗████╗ ████║██║██╔════╝████╗  ██║   ██╔════╝██║  ██║
 ██║  ██║███████║██╔████╔██║██║█████╗  ██╔██╗ ██║   ███████╗███████║
 ██║  ██║██╔══██║██║╚██╔╝██║██║██╔══╝  ██║╚██╗██║   ╚════██║██╔══██║
 ██████╔╝██║  ██║██║ ╚═╝ ██║██║███████╗██║ ╚████║██╗███████║██║  ██║
 ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚══════╝╚═╝  ╚═══╝╚═╝╚══════╝╚═╝  ╚═╝
'

function main() {
  echo $LOGO
  # First things first, asking for sudo credentials
  ask_for_sudo
  # homebrew
  install_homebrew
  install_packages_with_brewfile
  # oh-my-zsh
  install_oh_my_zsh
  # Symlink all dotfiles
  symlink_dotfiles
  # Python
  install_pip_packages
  # nvm
  install_nvm
}

function allDone() {
  success "All done! Exiting..."
  exit
}

function ask_for_sudo() {
  info "Prompting for sudo password"
  if sudo --validate; then
    # Keep-alive
    while true; do
      sudo --non-interactive true
      sleep 10
      kill -0 "$$" || exit
    done 2>/dev/null &
    success "Sudo password updated"
  else
    print_error "Sudo password update failed"
    exit 1
  fi
}

function install_oh_my_zsh() {
  info "Cloning oh-my-zsh.."
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

  ZSH_CUSTOM="~/Documents/dotfiles/zsh-custom"

  info "Cloning spaceship prompt"
  git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

  info "Cloning k"
  git clone https://github.com/supercrabtree/k $ZSH_CUSTOM/plugins/k

  info "Cloning zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

  zsh=$(which zsh)
  chsh -s "$zsh"
}

function install_homebrew() {
  info "Homebrew"
  substep "Install homebrew..."

  if is_exists "brew"; then
    success "brew already installed"
  else
    substep "Installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    success "Successfully Installed"
  fi
}

function install_packages_with_brewfile() {
  BREW_FILE_PATH="/macos.brewfile"
  info "Installing packages within ${BREW_FILE_PATH}"
  if brew bundle check --file="$BREW_FILE_PATH" &>/dev/null; then
    success "Brewfile's dependencies are already satisfied "
  else
    if brew bundle --file="$BREW_FILE_PATH"; then
      success "Brewfile installation succeeded"
    else
      error "Brewfile installation failed"
      exit 1
    fi
  fi
}

function setup_macOS_defaults() {
  info "Updating macOS defaults"

  current_dir=$(pwd)
  cd ${DOTFILES_REPO}/macos/setup-defaults.sh
  if bash defaults.sh; then
    cd $current_dir
    success "macOS defaults updated successfully"
  else
    cd $current_dir
    print_error "macOS defaults update failed"
    exit 1
  fi
}

function install_pip_packages() {
  pip_packages=(audioread beets discogs-client pyacoustid pylast requests)
  info "Installing pip packages \"${pip_packages[*]}\""

  pip3_list_outcome=$(pip3 list)
  for package_to_install in "${pip_packages[@]}"; do
    if echo "$pip3_list_outcome" |
      grep --ignore-case "$package_to_install" &>/dev/null; then
      info "\"${package_to_install}\" already exists"
    else
      if pip3 install "$package_to_install"; then
        info "Package \"${package_to_install}\" installation succeeded"
      else
        print_error "Package \"${package_to_install}\" installation failed"
        exit 1
      fi
    fi
  done

  success "pip packages successfully installed"
}

function symlink_dotfiles() {
  info "Symlink dotfiles"
  for file in $(
    ls .. -a -I .git -I . -I .. | grep "^\."
  ); do
    ln -s $file ~/$file
    substep "Symlinked $file"
  done
}

function install_nvm() {
  info "NVM"

  substep "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

}

#########
# Utils #
#########
function coloredEcho() {
  local exp="$1"
  local color="$2"
  local arrow="$3"
  if ! [[ $color =~ '^[0-9]$' ]]; then
    case $(echo $color | tr '[:upper:]' '[:lower:]') in
    black) color=0 ;;
    red) color=1 ;;
    green) color=2 ;;
    yellow) color=3 ;;
    blue) color=4 ;;
    magenta) color=5 ;;
    cyan) color=6 ;;
    white | *) color=7 ;; # white or invalid color
    esac
  fi
  tput bold
  tput setaf "$color"
  echo "$arrow $exp"
  tput sgr0
}

function info() {
  coloredEcho "$1" blue "========>"
}

function substep() {
  coloredEcho "$1" magenta "===="
}

function success() {
  coloredEcho "$1" green "========>"
}

function error() {
  coloredEcho "$1" red "========>"
}

# is_exists returns true if executable $1 exsts in $PATH
is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}

main "$0"
