#!/bin/bash
SOURCE="$( cd "$( dirname "$0" )" && pwd )"

# emacs-ish key bindings for OSX
ln -vf $SOURCE/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict

emacsdir=~/.emacs.d
if [ -e $emacsdir.backup ]
then
  rm -rf $emacsdir.backup
fi

if [ -e $emacsdir ]
then
  echo -n "mv:  "
  mv -v $emacsdir $emacsdir.backup
fi
ln -vs $SOURCE/emacs.d/ ~/.emacs.d
ln -vf  $SOURCE/mg ~/.mg
