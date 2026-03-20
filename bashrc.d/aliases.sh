# General
alias clear="command clear; unset __was_printed"
alias update='sudo apt update && sudo apt upgrade -y'
alias reload='source ~/.bashrc && echo "Terminal reloaded"'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'

# ROS2
alias ws='cd ~/Desktop/ros2_ws'
alias cb='colcon build'
alias cbps='colcon_pkg_sync'
