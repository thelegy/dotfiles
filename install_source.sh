# DSL Definition for installation of dotfiles

#########
# Setup #
#########

# Get the path descibed by $1 relative to $2 and store it in a variable with the name of $3
get_path() {
  local pwd="$PWD"
  [ -n "$2" ] && cd "$2"
  eval ${3:=path}="$(realpath --no-symlinks "$1" 2>/dev/null)"
  cd "$pwd"
  if [ -z "${!3}" ]; then
    echo "ERROR: \"$1\" is no suitable value for \$${3:-path}" >&2
    return 1
  fi
}

############
# Commands #
############

# Create a symlink at $2 (relative to $HOME) pointing to $1 ($relative to $PWD)
l() {
  local source target

  get_path "$1" . source || return 1
  get_path "$2" "$HOME" target || return 2

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "The file \"$target\" exists and is not a symlink"
    return 3
  fi

  echo "Link $target -> $source"
  ln -sTf "$(realpath --relative-base="$(dirname "$target")" "$source")" "$target"
}

# Create a directory at $1 (relative to $HOME)
d() {
  local directory

  get_path "$1" "$HOME" directory || return 1

  echo "Create Directory $directory"
  mkdir "$directory" 2> /dev/null || true
}
