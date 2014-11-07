#/bin/sh
defaults write NSGlobalDomain AppleInterfaceStyle Dark
killall Dock
sleep 3
defaults remove NSGlobalDomain AppleInterfaceStyle
