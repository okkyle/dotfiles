#!/bin/bash
# From https://github.com/beetbox/beets/issues/2967#issuecomment-465818544
echo -e $1 | cut -c 3- | rev | cut -c 2- | rev | tr -d '\n' | xargs -0 osascript ~/.dotfiles/bin/usr/iTunesrefresh.scpt