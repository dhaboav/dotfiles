#!/bin/bash
# LAST UPDATE: SUNDAY, 22 MARCH 2026 08:47 A.M. (UTC)

set -e

source $HOME/dotfiles/bashrc.d/commons.sh

# --- Setup ---
SOURCES="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
FONT_NAME="JetBrainsMonoNerdFontMono-Regular.ttf"
TMP_PATH="/tmp/JetBrainsMono"
FONT_PATH="$HOME/.local/share/fonts/"

# --- Steps ---
# Step 1 (Download the font)
printf "%s\n%s" "$(make_label "[Step 1/5]Downloading JetBrainsMono Nerd Font..." "$color_primary")" "$color_reset"
wget -q --show-progress "$SOURCES" -O ${TMP_PATH}.zip

# Step 2 (Extract the ZIP file)
printf "%s\n%s" "$(make_label "[Step 2/5]Extracting the ZIP file..." "$color_primary")" "$color_reset"
unzip -q ${TMP_PATH}.zip -d ${TMP_PATH}

# Step 3 (Installing the font to the system)
printf "%s\n%s" "$(make_label "[Step 3/5]Installing the font..." "$color_primary")" "$color_reset"
mkdir -p ${FONT_PATH}
cp ${TMP_PATH}/${FONT_NAME} ${FONT_PATH}
if [ -f "${FONT_PATH}/${FONT_NAME}" ]; then
  printf "%s\n%s" "$(make_label "Font installed successfully!" "$color_slate")" "$color_reset"
else
  printf "%s\n%s" "$(make_label "Font installation failed!" "$color_error")" "$color_reset"
  exit 1
fi

# Step 4 (Refreshing font cache)
printf "%s\n%s" "$(make_label "[Step 4/5]Refreshing font cache..." "$color_primary")" "$color_reset"
fc-cache -f -v

# Step 5 (Clean up)
printf "%s\n%s" "$(make_label "[Step 5/5]Cleaning up..." "$color_primary")" "$color_reset"
rm -rf ${TMP_PATH}.zip ${TMP_PATH}

# --- Post steps ---
# Configuring bashrc
printf "%s\n%s" "$(make_label "[Post Step]Configuring .bashrc..." "$color_primary")" "$color_reset"
cd .
mv ~/.bashrc ~/.bashrc.bak
ln -s ~/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc
