#!/usr/bin/env bash

# Load utils
. $(cd $(dirname $0) && pwd)/utils.sh

print_title "Homebrew"
print_message "Install homebrew..."

if is_exists "brew"; then
  print_warning "brew already installed"
else
  print_message "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  print_success "Successfully Installed"
fi

# Make sure we're up-to-date
brew update
brew upgrade

# Install useful formulaes
brew install chromaprint
brew install cmatrix
brew install coreutils
brew install diff-so-fancy
brew install git
brew install git-extras
brew install htop
brew install httpie
brew install kubernetes-cli
brew install lame
brew install mackup
brew install mas
brew install neofetch
brew install peco
brew install pngpaste
brew install pngquant
brew install python
brew install python@2
brew install python3
brew install rbenv
brew install ssh-copy-id
brew install thefuck
brew install theora
brew install trash
brew install tree
brew install unar
brew install wget
brew install wifi-password
brew install youtube-dl
brew install zsh

# Install 3rd party apps
brew cask install adobe-creative-cloud
brew cask install alfred
brew cask install anydesk
brew cask install appcleaner
brew cask install audio-hijack
brew cask install caprine
brew cask install contexts
brew cask install couleurs
brew cask install dash
brew cask install discord
brew cask install divvy
brew cask install dropbox
brew cask install figma
brew cask install firefox
brew cask install flux
brew cask install fork
brew cask install front
brew cask install google-chrome
brew cask install handbrake
brew cask install irccloude
brew cask install istat-menus
brew cask install java
brew cask install keybase
brew cask install numi
brew cask install quicklook-json
brew cask install rocket
brew cask install slack
brew cask install the-unarchiver
brew cask install transmit
brew cask install visual-studio-code
brew cask install vlc
brew cask install xscope

# App Store
# Xcode
mas install 497799835
# Gappli
mas install 768053424
# IPinator
mas install 959111981
# Pixave
mas install 924891282

# Cleanup after ourselves
brew cleanup
