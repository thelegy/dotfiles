###################
###   .zshrc    ###
###by Jan Beinke###
###################


#Feel free to use, change and create more,
#I would also encourage you to report me
#any bugs or problems, you have with this.

#This file comes with abolutely no warrenty,
#and it is provided as-is.


#Now, let's come to the good stuff:


#############
###Globals###
#############

#the path should be set correctly
export PATH=~/.local/bin:~/bin:$PATH

## Editor
#provide a range of fallbacks
                              export EDITOR="vi"
hash nano  >/dev/null 2>&1 && export EDITOR="nano"
hash vim   >/dev/null 2>&1 && export EDITOR="vim"
hash emacs >/dev/null 2>&1 && export EDITOR="emacs -nw"


#############
###Options###
#############

#flow control semms kinda strange, we don't need that
unsetopt flow_control
