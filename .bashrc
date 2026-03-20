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

config() {
    # Define prompt segments
    declare -ag segments=(identity timestamp path prompt)
    declare -ag dynamics=(identity prompt)

    # Define custom colors
    declare -g color_primary="2;245;153;46"     #f5992e
    declare -g color_secondary="2;120;92;234"   #785cea
    declare -g color_slate="2;112;128;144"      #708090

    declare -g glyph_badge_right=""

    # Define prompt variables
    PS1=""
    PS2="→ "
    PROMPT_DIRTRIM=2
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWDIRTYSTATE=1

    # Preserve prompt command (i.e. not to break VTE)
    if [[ $PROMPT_COMMAND != *__print_blank* ]]; then
        PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }__print_blank"
    fi
}

init() {
    for segment in "${segments[@]}"; do
        # Compute function name
        renderer="render_$segment"

        # Skip segments without renderers
        if ! declare -F "$renderer" > /dev/null; then continue; fi

        if [[ "${dynamics[*]}" =~ $segment ]]; then
            # Evaluate every time
            PS1+="\$($renderer) "
        else
            # Evaluate only once
            PS1+="$($renderer) "
        fi
    done
}

# --- Render function ---
render_identity() {
    local label color

    if is_git; then
        label="@ $(get_git_project)"
        color=$color_secondary
    else
        label="\$ $HOSTNAME"
        color=$color_primary
    fi

    make_badge " $label" "$color"
}

render_timestamp() {
    make_label "\T"
}

render_path() {
     printf "%s" "$(make_label " \w" "$color_slate")"
}

render_prompt() {
    local color

    if is_git; then
        color=$color_secondary
    else
        color=$color_primary
    fi

    printf "\n%s%s " "$(make_label " ┗━━━▶" "$color")" "$C_RESET"
}


# --- render helper func ---
make_label() {
    local content=$1
    local color=$2

    # Prevent null content
    if [[ -z $content ]]; then return 1; fi

    printf "\001\033[38;%sm\002" "$color"
    printf "%b" "$content"
}

make_badge() {
    local content=$1
    local color=$2
    local ansi_sequence

    # Prevent null content
    if [[ -z $content ]]; then return 1; fi

    ansi_sequence=$(is_bg_filled "$color" true)

    # Rendering logic
    printf "\001\033[%sm\002" "$ansi_sequence"
    printf "%b" "$content"
    printf "\001\033[0m\002"
    printf "%s" "$(make_label "$glyph_badge_right" "$color")"
}

is_bg_filled() {
    local color=$1  
    local is_filled=${2:-false}

    if $is_filled; then printf "30;48;"; fi
    printf "$color"
}

get_git_project() {
    # Skip execution if `git` is not available
    if ! command -v git > /dev/null 2>&1; then return 1; fi

    # Get the top-level directory of the Git repository
    if git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
        # Get the current branch name
        local branch_name=$(git rev-parse --abbrev-ref HEAD)

        # Return the directory basename (repo name) and branch name
        printf "%s (%s)" "${git_root##*/}" "$branch_name"
    fi
}

# --- ROS2 helper func ---
colcon_pkg_sync() { 
    if colcon build --symlink-install --packages-select "$@"; then
        source install/setup.bash
        echo -e "${C_GREEN}[+] Built and synced:${C_RESET} $*"
    fi
}

# Prepend blank line except after startup or clear
__print_blank() { [[ -n $__was_printed ]] && echo; __was_printed=1; }

# --- Aliases ---
# General Aliases
alias clear="command clear; unset __was_printed"
alias update='sudo apt update && sudo apt upgrade -y'
alias reload='source ~/.bashrc && echo "Terminal reloaded"'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'

# ROS2 Aliases
alias ws='cd ~/Desktop/ros2_ws'
alias cb='colcon build'
alias cbps='colcon_pkg_sync'

is_git() { [[ -n $(get_git_project) ]]; }


# --- ROS2 Setup ---
source /opt/ros/jazzy/setup.bash
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
WS_SETUP="$HOME/Desktop/ros2_ws/install/setup.bash"
if [[ -f "$WS_SETUP" ]]; then
    source "$WS_SETUP"
else
    echo -e "${C_RED}[!]${C_RESET} Workspace setup missing: $WS_SETUP"
fi

config && init