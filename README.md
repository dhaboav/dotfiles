# dotfiles

A central repository for Linux configurations and automated installation scripts.

## 🛠 Directory Overview

`bashrc.d/` This directory contains modularized scripts that are sourced by the main `.bashrc` file:

* aliases.sh: Custom shortcuts and command aliases.
* commons.sh: Shared system variables, helper functions, and color definitions.
* gui.sh    : Terminal customization and UI-related settings.
* ros.sh    : Environment configurations and dependencies required for ROS 2.

`install.scripts/` This directory contains scripts to installing things:

* install_ros.sh: An executable script to install ROS2 and its required packages.

## 🚀 Installation Steps

To set up these dotfiles on a new system, follow the steps below:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/dhaboav/dotfiles.git
   ```

2. **Backup and Link the Configuration:**

   First, backup existing `.bashrc` for safety net:
   ```bash
   mv ~/.bashrc ~/.bashrc.bak
   ```

   Create a symbolic link from the repository to home directory:
   ```bash
   ln -s ~/dotfiles/.bashrc ~/.bashrc
   ```

3. **Apply Changes:**
    ```bash
    source ~/.bashrc
    ```
