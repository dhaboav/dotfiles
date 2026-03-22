# LAST UPDATE: SUNDAY, 22 MARCH 2026 06:13 A.M. (UTC)

config() {
  # Define prompt segments
  declare -ag segments=(identity timestamp path prompt)
  declare -ag dynamics=(identity prompt)
  declare -g glyph_badge_right=""

  # Define prompt variables
  PS1=""
  PS2="→ "
  PROMPT_DIRTRIM=2
  export GIT_PS1_SHOWUNTRACKEDFILES=1
  export GIT_PS1_SHOWDIRTYSTATE=1

  # Preserve prompt command (i.e. not to break VTE)
  if [[ $PROMPT_COMMAND != *__print_blank* ]]; then
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }__print_blank"
  fi
}

init() {
  for segment in "${segments[@]}"; do
    # Compute function name
    renderer="render_$segment"

    # Skip segments without renderers
    if ! declare -F "$renderer" >/dev/null; then continue; fi

    if [[ "${dynamics[*]}" =~ $segment ]]; then
      # Evaluate every time
      PS1+="\$($renderer) "
    else
      # Evaluate only once
      PS1+="$($renderer) "
    fi
  done
}

# --- Render function ---
render_identity() {
  local label color

  if is_git; then
    label="@ $(get_git_project)"
    color=$color_secondary
  else
    label="\$ $HOSTNAME"
    color=$color_primary
  fi

  make_badge " $label" "$color"
}

render_timestamp() {
  make_label "\T"
}

render_path() {
  printf "%s" "$(make_label " \w" "$color_slate")"
}

render_prompt() {
  local color

  if is_git; then
    color=$color_secondary
  else
    color=$color_primary
  fi

  printf "\n%s%s " "$(make_label " ┗━━━▶" "$color")" "$color_reset"
}

# --- render helper func ---
make_badge() {
  local content=$1
  local color=$2
  local ansi_sequence

  # Prevent null content
  if [[ -z $content ]]; then return 1; fi

  ansi_sequence=$(is_bg_filled "$color" true)

  # Rendering logic
  printf "\001\033[%sm\002" "$ansi_sequence"
  printf "%b" "$content"
  printf "\001\033[0m\002"
  printf "%s" "$(make_label "$glyph_badge_right" "$color")"
}

is_bg_filled() {
  local color=$1
  local is_filled=${2:-false}

  if $is_filled; then printf "30;48;"; fi
  printf "$color"
}

get_git_project() {
  # Skip execution if `git` is not available
  if ! command -v git >/dev/null 2>&1; then return 1; fi

  # Get the top-level directory of the Git repository
  if git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
    # Get the current branch name
    local branch_name=$(git rev-parse --abbrev-ref HEAD)

    # Return the directory basename (repo name) and branch name
    printf "%s (%s)" "${git_root##*/}" "$branch_name"
  fi
}

is_git() { [[ -n $(get_git_project) ]]; }

# Prepend blank line except after startup or clear
__print_blank() {
  [[ -n $__was_printed ]] && echo
  __was_printed=1
}

config && init
