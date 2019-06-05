#!/usr/bin/env bash

# Load utils
. $(cd $(dirname $0) && pwd)/utils.sh

print_title "NVM"

print_message "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
