# dotfiles

Dotfiles. Do what you want with that

# Wait, what the globe are all these files ?

+ `bin/core` gets the main scripts
+ `bin/usr` gets the custom scripts (mainly used by alias of all sorts)
+ `symfiles` every file/folder with a `.symlink` extension in there will be symlinked in `$HOME` 
+ `useful-conf` some stuff that can't really be automated by some ways

# Installation

Clone the repo and do :

```bash
./runmah
```

And boom !

# Plugins used

+ **ZSH**: [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
+ **tmux**: [powerline](https://github.com/Lokaltog/powerline)


# Stuff to do

- [ ] Add some package managers
    + [ ] npm
    + [ ] rbenv/ruby-build
    + [ ] Homebrew
- [ ] Try to embrace brewcask