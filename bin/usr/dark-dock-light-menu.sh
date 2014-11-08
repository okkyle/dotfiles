#/bin/sh
defaults write NSGlobalDomain AppleInterfaceStyle Light
defaults write NSGlobalDomain AppleInterfaceStyle Dark
killall Dock
sleep 3
defaults remove NSGlobalDomain AppleInterfaceStyle
killall 2BUA8C4S2C.com.agilebits.onepassword-osx-helper
