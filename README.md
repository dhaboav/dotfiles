# My Dotfiles

Minimalist configuration for **ROS 2 Jazzy** terminal and other installation.

## ✨ Features
* **TrueColor Palette:** Custom `#33FF33` (Green) and `#09D0F8` (Blue) for a modern look.
* **Custom Prompt:** A clean, two-line prompt showing a simplified navigation path.
* **ROS 2 Integration:** Automatic sourcing for ROS 2 Jazzy.

## 🛠 Installation

To set this up on a new system, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/dhaboav/dotfiles.git
   ```

2. **Create the Symbolic Link:**

    **Note:** This links the file in this folder to your home directory. If you already have a *.bashrc*, back it up first.
    ```bash
    mv ~/.bashrc ~/.bashrc.backup
    ln -s ~/dotfiles/.bashrc ~/.bashrc
    ```

3. **Apply Changes:**
    ```bash
    source ~/.bashrc
    ```
