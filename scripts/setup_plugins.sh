#!/bin/bash
# LAST UPDATE: WEDNESDAY, 15 JULY 2026 06:43 A.M. (UTC)

set -e

echo "[Plugins] Installing zsh plugins..."
mkdir -p "$ZSH_DIR"

# List of plugins to clone
PLUGINS=(
  "zsh-users/zsh-history-substring-search"
  "zsh-users/zsh-autosuggestions"
  "zsh-users/zsh-syntax-highlighting"
)

for repo in "${PLUGINS[@]}"; do
  plugin_name=$(basename "$repo")
  if [ ! -d "$ZSH_DIR/$plugin_name" ]; then
    git clone "https://github.com/$repo" "$ZSH_DIR/$plugin_name"
  else
    echo "[Plugins] $plugin_name already installed, skipping."
  fi
done