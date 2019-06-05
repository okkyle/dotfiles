#!/usr/bin/env bash

# Load utils
. $(cd $(dirname $0) && pwd)/utils.sh

LOGO='
 ██████╗  █████╗ ███╗   ███╗██╗███████╗███╗   ██╗   ███████╗██╗  ██╗
 ██╔══██╗██╔══██╗████╗ ████║██║██╔════╝████╗  ██║   ██╔════╝██║  ██║
 ██║  ██║███████║██╔████╔██║██║█████╗  ██╔██╗ ██║   ███████╗███████║
 ██║  ██║██╔══██║██║╚██╔╝██║██║██╔══╝  ██║╚██╗██║   ╚════██║██╔══██║
 ██████╔╝██║  ██║██║ ╚═╝ ██║██║███████╗██║ ╚████║██╗███████║██║  ██║
 ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚══════╝╚═╝  ╚═══╝╚═╝╚══════╝╚═╝  ╚═╝

1. Install CLI tools
2. Symlink files
3. Install brew packages
4. Install nvm
5. Finishing touches
'

xcode_select_install() {
  print_title "CLI tools"
  print_message "xcode-select --install..."

  xcode-select -p >/dev/null 2>&1

  if [ $? == 0 ]; then
    print_warning "Already exist"
    exit 0
  else
    xcode-select --install >/dev/null 2>&1
    while :; do
      xcode-select -p >/dev/null 2>&1
      if [ $? == 0 ]; then
        print_success "Installed CLI tools!"
        sleep 60
        break
      fi
      sleep 30
    done
  fi
}

function doIt() {
  # Install CLI tools
  xcode_select_install

  # Symlink all dotfiles
  print_title "Symlink dotfiles"
  for file in $(
    ls .. -a -I .git -I . -I .. | grep "^\."
  ); do
    ln -s $file ~/$file
    print_message "Symlinked $file"
  done

  # Brew
  $(cd $(dirname $0) && pwd)/brew.sh

}

read -p "Let's go? (y/n)" -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  print_message "LET'S GOOOOO 🔥"
  doIt
else
  print_message "Alright then. 👋"
fi
