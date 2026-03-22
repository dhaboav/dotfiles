# LAST UPDATE: SUNDAY, 22 MARCH 2026 06:13 A.M. (UTC)

case $- in 
    *i*) ;; 
    *) return;; 
esac

HISTCONTROL=ignoreboth
shopt -s histappend checkwinsize
HISTSIZE=100
HISTFILESIZE=100

source $HOME/dotfiles/bashrc.d/aliases.sh
source $HOME/dotfiles/bashrc.d/commons.sh
source $HOME/dotfiles/bashrc.d/gui.sh
source $HOME/dotfiles/bashrc.d/ros.sh
