#!/bin/bash
# LAST UPDATE: TUESDAY, 17 MARCH 2026 10:33 A.M. (UTC)

set -e

# --- ROS2 Version ---
ROS_VERSION="jazzy"


# --- Colors ---
C_CYAN="\e[1;36m"
C_GREEN="\e[1;32m"
C_RESET="\e[0m"


# --- Scripts ---
# Step 1 (Setup locale)
echo -e "${C_CYAN}[Step 1/6] Configuring Locales...${C_RESET}"
locale
sudo apt update && sudo apt install locales -y
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale

# Step 2 (Enable required repositories)
echo -e "${C_CYAN}[Step 2/6] Enabling Universe Repository...${C_RESET}"
sudo apt install software-properties-common -y
sudo add-apt-repository universe -y

# Step 3 (Add ROS2 repository)
echo -e "${C_CYAN}[Step 3/6] Installing ROS 2 APT Source Tool...${C_RESET}"
sudo apt update && sudo apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb

# Step 4 (Update and upgrade)
echo -e "${C_CYAN}[Step 4/6] Updating System Packages...${C_RESET}"
sudo apt update
sudo apt upgrade -y

# Step 5 (Install ROS2 Jazzy)
echo -e "${C_CYAN}[Step 5/6] Installing ROS 2 ${ROS_VERSION} (Desktop)...${C_RESET}"
sudo apt install ros-${ROS_VERSION}-desktop -y
echo -e "${C_GREEN}Installation ${ROS_VERSION} Complete!${C_RESET}"

# Step 6 (Install Colcon)
echo -e "${C_CYAN}[Step 6/6] Installing Colcon...${C_RESET}"
sudo apt update
sudo apt install python3-colcon-common-extensions -y
echo -e "${C_GREEN}Installation colcon Complete!${C_RESET}"

# After installation (Creating ROS2 workspace)
echo -e "${C_CYAN}Creating ROS2 workspace...${C_RESET}"
cd Desktop/
mkdir ros2_ws
cd ros2_ws
mkdir src
colcon build
echo -e "${C_CYAN}Creating ROS2 workspace Complete!...${C_RESET}"

# Testing ROS2
echo -e "${C_GREEN}Running Talker demo ( Ctrl+C to stop )...${C_RESET}"
source /opt/ros/${ROS_VERSION}/setup.bash
ros2 run demo_nodes_cpp talker
