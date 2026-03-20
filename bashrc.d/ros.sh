# --- Colors ---
C_GREEN=$'\e[1;38;2;51;255;51m'
C_BLUE=$'\e[1;38;2;9;208;248m'
C_RED=$'\e[1;31m'
C_RESET=$'\e[0m'

# Functions and setup related to ROS2 development
colcon_pkg_sync() { 
    if colcon build --symlink-install --packages-select "$@"; then
        source install/setup.bash
        echo -e "${C_GREEN}[+] Built and synced:${C_RESET} $*"
    fi
}

source /opt/ros/jazzy/setup.bash
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
WS_SETUP="$HOME/Desktop/ros2_ws/install/setup.bash"
if [[ -f "$WS_SETUP" ]]; then
    source "$WS_SETUP"
else
    echo -e "${C_RED}[!]${C_RESET} Workspace setup missing: $WS_SETUP"
fi
