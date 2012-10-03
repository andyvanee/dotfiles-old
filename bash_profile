#!/bin/sh

########################################################################
# Imports
########################################################################

CONFIGS=~/Dropbox/a

source $CONFIGS/servers.sh      # Server aliases

# Create a data URL from an image
# (works for other file types too, if you tweak the Content-Type afterwards)
dataurl() {
    echo "data:image/${1##*.};base64,$(openssl base64 -in "$1")" | tr -d '\n'
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    python -m SimpleHTTPServer $port
}

########################################################################
# Custom Key Bindings
########################################################################
# http://stackoverflow.com/questions/994563/integrate-readlines-kill-ring-and-the-x11-clipboard

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

########################################################################
# Shell defaults
########################################################################

# Immediately add a trailing slash when autocompleting symlinks to directories
set mark-symlinked-directories on

# Colored cwd+newline prompt
PS1='\n\e[1;31m\w\e[m\n$ '

export EDITOR=mg
export HISTSIZE=5000
export HISTIGNORE="&:ls:ll:la:exit"

########################################################################
# Paths
########################################################################

export NODE_PATH=/usr/local/lib/node_modules

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/Dropbox/a/scripts:$PATH

########################################################################
# Shortened Commands
########################################################################

# File & Folder interactions

# cd and short list
cl() {
    [ -n "{$1}" ] && cd $1
    ls -G
}

alias ll='ls -lpG'
alias la='ls -alpG'
alias l='ls -G'
# cd to some common directories
alias D='cl ~/Desktop'
alias P='cl ~/Projects'
alias fs="stat -f \"%z bytes\""

# function subl(){
#     open "${1:-.}" -a "Sublime Text 2"
# }

function e(){
    open "${1:-.}" -a "/Applications/TextEdit.app"
}

# Git shortcuts
alias gpul='git pull'
alias gpsh='git push -u origin master'
alias gc='git commit -a'
alias gst='git status'

# Applications
alias t='python ~/Dropbox/a/scripts/t.py --task-dir ~/tasks --list tasks'

alias gwstart='git instaweb --httpd=webrick'
alias gwstop='git instaweb --httpd=webrick --stop'

# Package Management and Environment
alias be='bundle exec'

# Get OS X Software Updates, update Homebrew itself, and upgrade installed Homebrew packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Run on startup
# Set up rbenv
eval "$(rbenv init -)"
