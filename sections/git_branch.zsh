#
# Git branch
#
# Show current git branch

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GIT_BRANCH_SHOW="${SPACESHIP_GIT_BRANCH_SHOW=true}"
SPACESHIP_GIT_BRANCH_ASYNC="${SPACESHIP_GIT_BRANCH_ASYNC=false}"
SPACESHIP_GIT_BRANCH_PREFIX="${SPACESHIP_GIT_BRANCH_PREFIX="$SPACESHIP_GIT_SYMBOL"}"
SPACESHIP_GIT_BRANCH_SUFFIX="${SPACESHIP_GIT_BRANCH_SUFFIX=""}"
SPACESHIP_GIT_BRANCH_COLOR="${SPACESHIP_GIT_BRANCH_COLOR="magenta"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_git_branch() {
  [[ $SPACESHIP_GIT_BRANCH_SHOW == false ]] && return

  vcs_info

  local git_current_branch="$vcs_info_msg_0_"
  [[ -z "$git_current_branch" ]] && return

  git_current_branch="${git_current_branch#heads/}"
  git_current_branch="${git_current_branch/.../}"

  local git_name_length_pre=18
  local git_name_length_post=8
  local zero='%([BSUbfksu]|([FK]|){*})'
  local git_current_branch_length=${#${(S%%)git_current_branch//$~zero/}}

  if (( $git_current_branch_length > ($git_name_length_pre + $git_name_length_post + 1) )); then
    local git_current_branch_pre="%$git_name_length_pre>…>$(git_current_branch)%>>"
    # local git_current_branch_pre="%$git_name_length_pre>…>$(git_current_branch)%>>"
    if (( $git_name_length_post > 0 )); then
      local git_current_branch_post="…${git_current_branch:(-$git_name_length_post)}"
      local git_current_branch_post="${git_current_branch:(-$git_name_length_post)}"
      git_current_branch="$git_current_branch_pre$git_current_branch_post"
    else
      git_current_branch="$git_current_branch_pre"
    fi
  fi

  spaceship::section \
    --color "$SPACESHIP_GIT_BRANCH_COLOR" \
    "$SPACESHIP_GIT_BRANCH_PREFIX$git_current_branch$SPACESHIP_GIT_BRANCH_SUFFIX"
}
