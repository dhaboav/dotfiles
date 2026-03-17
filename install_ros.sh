#!/bin/bash
# LAST UPDATE: TUESDAY, 17 MARCH 2026 17:50 P.M. (UTC)
# ROS2: https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debs.html
# URDF: 
# GZ: https://gazebosim.org/docs/latest/ros_installation/

set -e

# --- ROS2 Version ---
ROS_VERSION="jazzy"
WS_PATH="Desktop/ros2_ws"


# --- Colors ---
C_CYAN="\e[1;36m"
C_GREEN="\e[1;32m"
C_RESET="\e[0m"


# --- Scripts ---
# Step 1 (Setup locale)
echo -e "${C_CYAN}[Step 1/8] Configuring Locales...${C_RESET}"
sudo apt update && sudo apt install locales -y
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# Step 2 (Enable required repositories)
echo -e "${C_CYAN}[Step 2/8] Enabling Universe Repository...${C_RESET}"
sudo apt install software-properties-common -y
sudo add-apt-repository universe -y

# Step 3 (Add ROS2 repository)
echo -e "${C_CYAN}[Step 3/8] Installing ROS 2 APT Source Tool...${C_RESET}"
sudo apt update && sudo apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb

# Step 4 (Update and upgrade)
echo -e "${C_CYAN}[Step 4/8] Updating System Packages...${C_RESET}"
sudo apt update
sudo apt upgrade -y

# Step 5 (Install ROS2 Jazzy)
echo -e "${C_CYAN}[Step 5/8] Installing ROS 2 ${ROS_VERSION} (Desktop)...${C_RESET}"
sudo apt install ros-${ROS_VERSION}-desktop -y
echo -e "${C_GREEN}Installation ${ROS_VERSION} Complete!${C_RESET}"

# Step 6 (Install Colcon)
echo -e "${C_CYAN}[Step 6/8] Installing Colcon...${C_RESET}"
sudo apt update
sudo apt install python3-colcon-common-extensions -y
echo -e "${C_GREEN}Installation colcon Complete!${C_RESET}"

# Step 7 (Add URDF package)
echo -e "${C_CYAN}[Step 7/8] Installing urdf package...${C_RESET}"
sudo apt update
sudo apt install ros-${ROS_VERSION}-urdf-tutorial -y
echo -e "${C_GREEN}Installation urdf package Complete!${C_RESET}"

# Step 8 (Install Gazebo)
echo -e "${C_CYAN}[Step 8/8] Installing Gazebo...${C_RESET}"
sudo apt update
sudo apt install ros-${ROS_VERSION}-ros-gz -y
echo -e "${C_GREEN}Installation gazebo Complete!${C_RESET}"

# After installation (Creating ROS2 workspace)
echo -e "${C_CYAN}Creating ROS2 workspace...${C_RESET}"
mkdir ${WS_PATH}/src
cd ${WS_PATH}
colcon build
echo -e "${C_CYAN}Creating ROS2 workspace Complete!...${C_RESET}"

# Testing ROS2
echo -e "${C_GREEN}Running Talker demo ( Ctrl+C to stop )...${C_RESET}"
source /opt/ros/${ROS_VERSION}/setup.bash
ros2 run demo_nodes_cpp talker
