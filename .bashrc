# .bashrc
# --- Shell setup ---
case $- in *i*) ;; *) return;; esac
HISTCONTROL=ignoreboth
shopt -s histappend checkwinsize
HISTSIZE=1000
HISTFILESIZE=2000

# --- Colors ---
GREEN="\[\033[1;38;2;51;255;51m\]"
BLUE="\[\033[1;38;2;9;208;248m\]"
RESET="\[\033[0m\]"

# --- Terminal customize ---
format_path() {
    local p="${PWD#$HOME}" # Remove /home/user
    p="${p#/}"             # Remove leading /
    echo "> ${p//\// > }"  # Replace all / with >
}

PS1="${GREEN}┌── \u ${BLUE}\$(format_path)${RESET}\n${GREEN}└───\$ ${RESET}"

# --- Aliases ---
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias reload='source ~/.bashrc && echo "terminal reloaded"'
[ -x /usr/bin/dircolors ] && eval "$(dircolors -b)"

# --- ROS2 Setup ---
source /opt/ros/jazzy/setup.bash
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
source ~/Desktop/ros2_ws/install/setup.bash
