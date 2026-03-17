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
# Step 1 (Install URDF)
echo -e "${C_CYAN}[Step 1/2] Installing urdf package...${C_RESET}"
sudo apt update
sudo apt install ros-${ROS_VERSION}-urdf-tutorial -y

# Step 1 (Install Gazebo)
echo -e "${C_CYAN}[Step 2/2] Installing Gazebo...${C_RESET}"
sudo apt install ros-${ROS_VERSION}-ros-gz -y
echo -e "${C_CYAN}Installing URDF and Gazebo Completed!...${C_RESET}"
