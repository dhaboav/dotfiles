# dotfiles

A central repository for Linux configurations and automated installation scripts.

## 🛠 Directory Overview

`bashrc.d/` This directory contains modularized scripts that are sourced by the main `.bashrc` file:

* aliases.sh: Custom shortcuts and command aliases.
* commons.sh: Shared system variables, helper functions, and color definitions.
* gui.sh    : Terminal customization and UI-related settings.
* ros.sh    : Environment configurations and dependencies required for ROS 2.

`install.scripts/` This directory contains scripts to installing things:

* conf_bash.sh: An executable script to install the JetBrainsMono Nerd font and configure a customized .bashrc.
* install_ros.sh: An executable script to install ROS2 and its required packages.

    *Note*: You need to add `chmod +x` permission for this directory, or it will not work.

## 🚀 Installation Steps

To set up these dotfiles on a new system, follow the steps below:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/dhaboav/dotfiles.git
   ```

2. **Configure bash:**

    **Run the script to automatically configure:**
    ```bash
    dotfiles/install.scripts/conf_bash.sh
    ```

    or manually

    1. **First, backup existing `.bashrc` for safety net:**
        ```bash
        mv ~/.bashrc ~/.bashrc.bak
        ```

    2. **Create a symbolic link from the repository to home directory:**
        ```bash
        ln -s ~/dotfiles/.bashrc ~/.bashrc
        ```

    3. **Apply Changes:**
        ```bash
        source ~/.bashrc
        ```
