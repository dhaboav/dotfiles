#!/bin/bash
# LAST UPDATE: WEDNESDAY, 15 JULY 2026 06:43 A.M. (UTC)
# ROS2: https://docs.ros.org/en/lyrical/Installation/Ubuntu-Install-Debs.html
# GZ: https://gazebosim.org/docs/latest/ros_installation/

set -e

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/../config.sh"

# --- ROS2 Version ---
ROS_VERSION="lyrical"
WS_PATH="$HOME/Desktop/ros2_ws"

# --- Steps ---
# Step 1 (Configuring locale)
echo "[Step 1/6] Configuring Locales..."
sudo apt update && sudo apt install locales software-properties-common -y
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# Step 2 (Adding ROS2 repo to our system)
echo "[Step 2/6] Adding ROS2 Repository..."
sudo add-apt-repository universe -y
sudo apt update && sudo apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb

# Step 3 (Installing ROS2 and Colcon)
echo "[Step 3/6] Installing ROS2 and colcon..."
sudo apt update && sudo apt upgrade -y
sudo apt install ros-${ROS_VERSION}-desktop python3-colcon-common-extensions -y

# Step 4 (Installing other packages for ROS2. E.g. urdf and gazebo)
echo "[Step 4/6] Installing urdf and gazebo..."
sudo apt update && sudo apt upgrade -y
sudo apt install ros-${ROS_VERSION}-urdf-tutorial ros-${ROS_VERSION}-ros-gz -y

# Step 5 (Creating ROS2 workspace)
echo "[Step 5/6] Creating ROS2 workspace..."
mkdir -p "${WS_PATH}/src"
cd "${WS_PATH}"
colcon build

# Step 6 (Adding ROS2 setup to shell)
echo "[Step 6/6] Creating zsh file..."
cat << EOF > "$ZSH_DIR/.zsh_ros2"
# --- ROS2 ENVIRONMENT ---
source /opt/ros/${ROS_VERSION}/setup.zsh
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
WS_SETUP="$WS_PATH/install/setup.zsh"
if [[ -f "\$WS_SETUP" ]]; then
  source "\$WS_SETUP"
fi

alias ws='cd ~/Desktop/ros2_ws'
alias cb='colcon build'
alias cbps='colcon_pkg_sync'
EOF

# --- Post steps ---
echo "[Post] Running Talker demo ( Ctrl+C to stop )......"
source /opt/ros/${ROS_VERSION}/setup.zsh
ros2 run demo_nodes_cpp talker
