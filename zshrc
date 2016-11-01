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

####################
###Dumb Terminals###
####################

# this is for dumb terminals mainly tramp
if [[ "$TERM" == "dumb" ]]; then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  PS1='$ '

  # return to leave the environment nearly untouched
  return
fi

###############
###Autoloads###
###############

# want to use regex later on
autoload -U regexp-replace


#############
###Globals###
#############

# the path should be set correctly
[ -d ~/.gem/ruby/2.3.0/bin ] && PATH=${PATH}:~/.gem/ruby/2.3.0/bin
PATH=~/.local/bin:~/bin:${PATH}
export PATH

## Editor
# provide a range of fallbacks
                              export EDITOR="vi"
hash nano  >/dev/null 2>&1 && export EDITOR="nano"
hash vim   >/dev/null 2>&1 && export EDITOR="vim"
hash emacs >/dev/null 2>&1 && export EDITOR="emacs -nw"

## Terminal
# provide a terminal, that works almost everywhere
if [ $TERM != "rxvt-unicode-256color" ]; then
  export TERM="rxvt-unicode"
fi

## Python virtual environment
# Python virtual environment will be handled by dedicated prompt code.
# We need to disable the legacy code here
export VIRTUAL_ENV_DISABLE_PROMPT=true

## Gopath
[ -d ${HOME}/.gopath ] && export GOPATH=${HOME}/.gopath

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
if hash gpg-agent; then
  eval $(gpg-agent --daemon)
fi

# SSHAgent
# ========
ssh-add -l >/dev/null || alias ssh='ssh-add -l >/dev/null || ssh-add && unalias ssh; ssh'

###########
###Alias###
###########

# Reload zshrc
alias reconfigure='source ~/.zshrc'

# list directory contents
alias la="ls -al"
alias ll="ls -l"

# Relief anger over missing permissions
alias asshole='sudo $(fc -ln -1)'
alias fu='sudo $(fc -ln -1)'
alias fuckyou='sudo $(fc -ln -1)'

#############################
###Source external scripts###
#############################

# added by travis gem
[ -f /home/jan/.travis/travis.sh ] && source /home/jan/.travis/travis.sh

# Local Variables:
# mode: sh
# End:
