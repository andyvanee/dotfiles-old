#!/bin/sh

# Bash settings
export HISTSIZE=5000
export HISTIGNORE="&:ls:ll:la:exit"

# Functions

# grep recursively for the term in the current directory
preg() {
    grep -Rn $1 .
}

catp(){
    cat $1 | pbcopy
    cat $1
}

# cd + short ls
cl() {
    [ -n "{$1}" ] && cd $1
    ls -G
}

# Create a data URL from an image (works for other file types too, if you tweak the Content-Type afterwards)
dataurl() {
    echo "data:image/${1##*.};base64,$(openssl base64 -in "$1")" | tr -d '\n'
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Input

# Custom Key Bindings
## derived from http://stackoverflow.com/questions/994563/integrate-readlines-kill-ring-and-the-x11-clipboard

## You need to choose which clipboard to integrate with, OS X or X11:

shell_copy() {
    pbcopy # OS X
}
shell_yank() {
    pbpaste
}

## then wire up readline
_xdiscard() {
    echo -n "${READLINE_LINE:0:$READLINE_POINT}" | shell_copy
    READLINE_LINE="${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=0
}
_xkill() {
    echo -n "${READLINE_LINE:$READLINE_POINT}" | shell_copy
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}"
}
_xyank() {
    CLIP=$(shell_yank)
    COUNT=$(echo -n "$CLIP" | wc -c)
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${CLIP}${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(($READLINE_POINT + $COUNT))
}

bind -m emacs -x '"\eu": _xdiscard' # backwards kill from point
bind -m emacs -x '"\ek": _xkill'
bind -m emacs -x '"\ey": _xyank'


# Immediately add a trailing slash when autocompleting symlinks to directories
set mark-symlinked-directories on

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

alias gpull='git pull'
alias gpm='git push -u origin master'
alias gc='git commit -a'
alias gstat='git status'

alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

alias gwstart='git instaweb --httpd=webrick'
alias gwstop='git instaweb --httpd=webrick --stop'

# Get OS X Software Updates, update Homebrew itself, and upgrade installed Homebrew packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade'

# File size
alias fs="stat -f \"%z bytes\""

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

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
