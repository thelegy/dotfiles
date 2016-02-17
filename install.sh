#! /bin/bash

# Inspired by https://github.com/rmm5t/dotfiles/blob/master/install.rb

# This is an idempotent script.
# It means that this script can be applied multiple times without changing
# the result beyond the initial application.
# Hint: You might want to visit https://en.wikipedia.org/wiki/Idempotence

# The blacklist, wich files need no symlinks in the home directory.
# Syntax is Regex.
BLACKLIST=(
  "^\."  # just in case :)
  "^install"
  "^LICENSE"
  "\.md$"
)


function is_blacklisted
# Check if $1 mathes one of the $BLACKLIST regexes
{
  local blacklistItem
  for blacklistItem in "${BLACKLIST[@]}"; do
    grep -E <<< "${1}" "${blacklistItem}" >/dev/null && return 0
  done
  return 1
}


function can_link
# Check if $1 is not existent or a link
{
  if [[ ! -e "${1}" ]] || [[ -L "${1}" ]]; then
    return 0
  fi
  echo "Already present: ${1}"
  return 1
}


function install
{
  local scriptPath
  local scriptRelPath
  local item
  local itemName
  local relPath
  local showWarning

  scriptPath="$(dirname $0)"

  showWarning=false

  # iterate over all the files and directories
  for item in ${scriptPath}/*; do
    itemName="${item##*/}"

    # check if we can safely add the symlink
    if ! is_blacklisted "${itemName}"; then
      if can_link "${HOME}/.${itemName}"; then

        relPath="$(realpath --relative-to=${HOME} ${item})"

        # actually add the symlink
        echo "Link ${HOME}/.${itemName} -> ${relPath}"
        ln -sTf "${relPath}" "${HOME}/.${itemName}"

      else
        # at least one link cannot be created safely
        showWarning=true
      fi
    fi
  done

  if ${showWarning}; then
    # at least one link cannot be created safely
    echo
    echo "Files or Directories already present must be deleted or moved"
    echo "prior to running this script again!"
  fi
}


# so please actually run
install
