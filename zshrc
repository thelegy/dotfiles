###################
###   .zshrc    ###
###by Jan Beinke###
###################


# Feel free to use, change and create more,
# I would also encourage you to report me
# any bugs or problems, you have with this.

# This file comes with abolutely no warrenty,
# and it is provided as-is.


# Now, let's come to the good stuff:


###############
###Autoloads###
###############

# want to use regex later on
autoload -U regexp-replace


#############
###Globals###
#############

# the path should be set correctly
export PATH=~/.local/bin:~/bin:${PATH}

## Editor
# provide a range of fallbacks
                              export EDITOR="vi"
hash nano  >/dev/null 2>&1 && export EDITOR="nano"
hash vim   >/dev/null 2>&1 && export EDITOR="vim"
hash emacs >/dev/null 2>&1 && export EDITOR="emacs -nw"

## Terminal
# provide a terminal, that works almost everywhere
export TERM="rxvt"

#############
###Options###
#############

# need that for the prompt
setopt promptsubst

# flow control semms kinda strange, we don't need that
unsetopt flow_control


#################
###Keybindings###
#################

# create table of all keys.
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[C-Left]="^[Od"
key[C-Right]="^[Oc"
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

bindkey ${key[C-Left]} emacs-backward-word
bindkey ${key[C-Right]} emacs-forward-word
bindkey ${key[Home]} vi-beginning-of-line
bindkey ${key[End]} vi-end-of-line
bindkey ${key[Delete]} delete-char

####################
###Command Prompt###
####################

function command_prompt_init() {

  local promptPath="${HOME}/.prompt/prompt.py"

  local color=true

  local static_left="%(!.%F{red}.%F{green})%n%f@%F{yellow}%m%f:%~/"
  local static_left_noc=${static_left}
  regexp-replace static_left_noc '%([fb]|[FB]\{\w+\})' ''

  if ! ${color}; then
    static_left=${static_left_noc}
  fi

  # PS1 to fall back
  PS1='['${static_left}'] $ %E'

  PROMPT='$('${promptPath}' --width ${COLUMNS} --lastReturnCode $? 2>/dev/null || echo "'${PS1}'")'

}

command_prompt_init

###################
###Miscellaneous###
###################

# GPGAgent
# ========
if hash gpg-connect-agent; then
  # Start the gpg-agent if not already running
  if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
    gpg-connect-agent /bye >/dev/null 2>&1
  fi

  # Set SSH to use gpg-agent
  unset SSH_AGENT_PID
  if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
  fi

  # Set GPG TTY
  GPG_TTY=$(tty)
  export GPG_TTY

  # Refresh gpg-agent tty in case user switches into an X session
  gpg-connect-agent updatestartuptty /bye >/dev/null
fi

# SSHAgent
# ========
ssh-add -l >/dev/null || alias ssh='ssh-add -l >/dev/null || ssh-add && unalias ssh; ssh'

###########
###Alias###
###########

# Reload zshrc
alias reconfigure='source ~/.zshrc'

#####################
###Config for work###
#####################

alias urdesktop="rdesktop -k de -d AD -u ${USER} -g 1280x1024 -r disk:share=/local/share -x l vm-mit.cs.upb.de"
alias rklist="KRB5CCNAME=FILE:/tmp/rootkrb_${UID}_root klist"
alias rkinit="KRB5CCNAME=FILE:/tmp/rootkrb_${UID}_root kinit -f ${USER}/root@CS.UNI-PADERBORN.DE"
alias rksu="KRB5CCNAME=FILE:/tmp/rootkrb_${UID}_root ksu"
alias rssh="KRB5CCNAME=FILE:/tmp/rootkrb_${UID}_root ssh -l root"
alias rscp="KRB5CCNAME=FILE:/tmp/rootkrb_${UID}_root scp -o USER=root"


# Local Variables:
# mode: sh
# End:
