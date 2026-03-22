# LAST UPDATE: SUNDAY, 22 MARCH 2026 06:13 A.M. (UTC)

# Functions and setup related to ROS2 development
colcon_pkg_sync() {
  if colcon build --symlink-install --packages-select "$@"; then
    source install/setup.bash
  fi
}

source /opt/ros/jazzy/setup.bash
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
WS_SETUP="$HOME/Desktop/ros2_ws/install/setup.bash"
if [[ -f "$WS_SETUP" ]]; then
  source "$WS_SETUP"
fi
