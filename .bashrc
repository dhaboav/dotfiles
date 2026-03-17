# --- Shell setup ---
[[ $- != *i* ]] && return
HISTCONTROL=ignoreboth
shopt -s histappend checkwinsize
HISTSIZE=1000
HISTFILESIZE=2000

# --- Colors ---
C_GREEN=$'\e[1;38;2;51;255;51m'
C_BLUE=$'\e[1;38;2;9;208;248m'
C_RED=$'\e[1;31m'
C_RESET=$'\e[0m'

# --- Prompt ---
set_ps1() {
    local p="${PWD#$HOME}"
    p="${p#/}"
    local formatted_path="> ${p//\// > }"
    PS1="\[${C_GREEN}\]┌── \u \[${C_BLUE}\]${formatted_path% > }\[${C_RESET}\]\n\[${C_GREEN}\]└───\$ \[${C_RESET}\]"
}
PROMPT_COMMAND=set_ps1


# --- Functions ---
colcon_pkg_sync() { 
    if colcon build --symlink-install --packages-select "$@"; then
        source install/setup.bash
        echo -e "${C_GREEN}[+] Built and synced:${C_RESET} $*"
    fi
}

safety_remove() {
    [[ $# -eq 0 ]] && { echo -e "${C_RED}[!]${C_RESET} No files specified."; return 1; }

    # Pre-check critical paths to fail fast
    for arg in "$@"; do
        local full_path
        full_path=$(realpath -m -- "$arg")
        if [[ "$full_path" =~ ^(/|/etc|$HOME)$ ]]; then
            echo -e "${C_RED}[!] Protection:${C_RESET} Refusing to trash $full_path"; return 1
        fi
    done

    if gio trash -- "$@"; then
        [[ $# -gt 1 ]] && printf "${C_RED}[X] Deleted:${C_RESET} %s\n" "$@" || echo -e "${C_RED}[X] Deleted:${C_RESET} $*"
    else
        echo -e "${C_RED}[!] Error:${C_RESET} gio trash failed."; return 1
    fi
}


# --- Aliases ---
# General Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias del='safety_remove'
alias reload='source ~/.bashrc && echo "Terminal reloaded"'

# ROS2 Aliases
alias ws='cd ~/Desktop/ros2_ws'
alias cb='colcon build'
alias cbps='colcon_pkg_sync'
[[ -x /usr/bin/dircolors ]] && eval "$(dircolors -b)"


# --- ROS2 Setup ---
source /opt/ros/jazzy/setup.bash
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
WS_SETUP="$HOME/Desktop/ros2_ws/install/setup.bash"
if [[ -f "$WS_SETUP" ]]; then
    source "$WS_SETUP"
else
    echo -e "${C_RED}[!]${C_RESET} Workspace setup missing: $WS_SETUP"
fi