#!/bin/sh
':' //; exec "$(command -v nodejs || command -v node)" "$0" "$@"

let path = process.argv[2]
console.log({path})
path = path.split("'").length > 1 ? path.split("'")[1] : path

require('child_process').execSync(`osascript ~/.dotfiles/bin/usr/iTunesrefresh.scpt "${path}"`)