# LAST UPDATE: SUNDAY, 22 MARCH 2026 06:13 A.M. (UTC)

declare -g color_primary="2;245;153;46"   # f5992e
declare -g color_secondary="2;120;92;234" # 785cea
declare -g color_slate="2;112;128;144"    # 708090
declare -g color_reset=$'\e[0m'           # White
declare -g color_error=$'\e[1;31m'        # Red

make_label() {
  local content=$1
  local color=$2

  # Prevent null content
  if [[ -z $content ]]; then return 1; fi

  printf "\001\033[38;%sm\002" "$color"
  printf "%b" "$content"
}
