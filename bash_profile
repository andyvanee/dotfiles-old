#!/bin/sh

# Bash settings
export HISTSIZE=5000
export HISTIGNORE="&:ls:ll:la:exit"

# grep recursively for the term in the current directory 
gp() {
  grep -Rn $1 .
}

# cd + short ls
cl() {
    [ -n "{$1}" ] && cd $1
    ls -G
}

# Move stuff to the trash
function dump() {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      mv "$path" ~/.Trash/"$dst"
    fi
  done
}

# cwd+newline prompt
PS1='\n\e[1;31m\w\e[m\n$ '

# cd to some common directories
alias D='c ~/Desktop'
alias P='c ~/Projects'

# Command Shortcuts
alias ll='ls -lpG'
alias la='ls -alpG'
alias l='ls -G'

alias em='emacs'
alias be='bundle exec'

alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

alias gwstart='git instaweb --httpd=webrick'
alias gwstop='git instaweb --httpd=webrick --stop'

# Environment

export EDITOR=emacs

export NODE_PATH=/usr/local/lib/node_modules

export PATH=\
$HOME/local/node/bin:\
/usr/local/bin:\
/usr/local/sbin:\
$HOME/bin:\
$HOME/src/go/bin:\
$HOME/local/bin:\
$HOME/src/google_appengine:\
$HOME/Library/Haskell/bin:\
$HOME/Dropbox/a/scripts:\
$HOME/.rbenv/bin:\
$PATH

# Run on startup

# Set up my server aliases
CONFIGS=~/Dropbox/a
source $CONFIGS/servers.sh

# Set up rbenv
eval "$(rbenv init -)"
