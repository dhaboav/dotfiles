#!/bin/bash
# LAST UPDATE: SUNDAY, 22 MARCH 2026 06:13 A.M. (UTC)
# ROS2: https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debs.html
# GZ: https://gazebosim.org/docs/latest/ros_installation/

set -e

source $HOME/dotfiles/bashrc.d/commons.sh

# --- ROS2 Version ---
ROS_VERSION="jazzy"
WS_PATH="Desktop/ros2_ws"

# --- Steps ---
# Step 1 (Configuring locale)
printf "%s\n%s" "$(make_label "[Step 1/5] Configuring Locales..." "$color_primary")" "$color_reset"
sudo apt update && sudo apt install locales software-properties-common -y
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# Step 2 (Adding ROS2 repo to our system)
printf "%s\n%s" "$(make_label "[Step 2/5] Adding ROS2 Repository..." "$color_primary")" "$color_reset"
sudo add-apt-repository universe -y
sudo apt update && sudo apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb

# Step 3 (Installing ROS2 and Colcon)
printf "%s\n%s" "$(make_label "[Step 3/5] Installing ROS2 and colcon..." "$color_primary")" "$color_reset"
sudo apt update && sudo apt upgrade -y
sudo apt install ros-${ROS_VERSION}-desktop python3-colcon-common-extensions -y

# Step 4 (Installing other packages for ROS2. E.g. urdf and gazebo)
printf "%s\n%s" "$(make_label "[Step 4/5] Installing urdf and gazebo..." "$color_primary")" "$color_reset"
sudo apt update && sudo apt upgrade -y
sudo apt install ros-${ROS_VERSION}-urdf-tutorial ros-${ROS_VERSION}-ros-gz -y

# Step 5 (Creating ROS2 workspace)
printf "%s\n%s" "$(make_label "[Step 5/5] Creating ROS2 workspace..." "$color_primary")" "$color_reset"
mkdir ${WS_PATH}/src
cd ${WS_PATH}
colcon build

# --- Post steps ---
printf "%s\n%s" "$(make_label "[Post] Running Talker demo ( Ctrl+C to stop )......" "$color_primary")" "$color_reset"
source /opt/ros/${ROS_VERSION}/setup.bash
ros2 run demo_nodes_cpp talker
