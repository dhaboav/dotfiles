#!/bin/bash
# LAST UPDATE: SUNDAY, 22 MARCH 2026 08:47 A.M. (UTC)

set -e

# --- Setup ---
SOURCES="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
TMP_PATH="/tmp/JetBrainsMono"
FONT_PATH="$HOME/.local/share/fonts/"

# --- Steps ---
# Step 1 (Download the font)
echo "[Step 1/5] Downloading JetBrainsMono Nerd Font..."
wget -q --show-progress "$SOURCES" -O ${TMP_PATH}.zip

# Step 2 (Extract the ZIP file)
echo "[Step 2/5] Extracting the ZIP file..."
unzip -q ${TMP_PATH}.zip -d ${TMP_PATH}

# Step 3 (Installing the font to the system)
echo "[Step 3/5] Installing the font..."
mkdir -p ${FONT_PATH}
cp ${TMP_PATH}/*.ttf ${FONT_PATH}
if [ -d "${FONT_PATH}" ]; then
  echo "Font installed successfully!"
else
  echo "Font installation failed!"
  exit 1
fi

# Step 4 (Refreshing font cache)
echo "[Step 4/5] Refreshing font cache..."
fc-cache -f -v

# Step 5 (Clean up)
echo "[Step 5/5] Cleaning up..."
rm -rf ${TMP_PATH}.zip ${TMP_PATH}
