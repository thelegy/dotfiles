## Path
# the path should be set correctly
add_path() {
  p="${1/#\~/$HOME}"
  if [ -d "$p" ]; then
    if ! egrep "(^|:)$p(:|$)" <<<"$PATH" >/dev/null; then
      case "$2" in
        "start") ;&
        "begin") PATH="$p:${PATH}"
                 ;;
        "end") ;&
        *) PATH="${PATH}:$p"
      esac
    fi
  fi
}

PATH=${ORIGINALPATH:=$PATH}

add_path "~/bin" start
add_path "~/bin/$(hostname)" start

for i in $( find ~/.gem/ruby/ -maxdepth 2 -name bin | sort -r ); do
  add_path "$i" end
done

export ORIGINALPATH
export PATH
unset -f add_path

## Editor
# provide a range of fallbacks
                               export EDITOR="vi"
command -v nano  >/dev/null && export EDITOR="nano"
command -v vim   >/dev/null && export EDITOR="vim"
command -v zile  >/dev/null && export EDITOR="zile"
command -v emacs >/dev/null && export EDITOR="emacs -nw"


## Gopath
[ ! -d "$GOPATH" ] && export GOPATH=${HOME}/.gopath
[ ! -d "$GOPATH" ] && export GOPATH=${HOME}/go
[ ! -d "$GOPATH" ] && unset GOPATH


# GPGAgent
# ========
if command -v gpg-agent >/dev/null; then
  variables="$(gpg-agent --daemon 2>/dev/null)"
  if [[ $? == 0 ]]; then
    eval "$variables"
  else
    # Start the gpg-agent if not already running
    if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
      gpg-connect-agent /bye >/dev/null 2>&1
    fi

    # Set SSH to use gpg-agent
    unset SSH_AGENT_PID
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
      export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket|sed -zr 's/^.*agent-socket:(\S+).*$/\1\n/')"
    fi

    # Set GPG TTY
    GPG_TTY=$(tty)
    export GPG_TTY

    # Refresh gpg-agent tty in case user switches into an X session
    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
  fi
  unset variables
fi


# SSHAgent
# ========
ssh-add -l >/dev/null 2>&1 || alias ssh='ssh-add -l >/dev/null || ssh-add && unalias ssh; ssh'
