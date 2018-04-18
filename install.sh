#!/bin/bash
cd $(dirname $(realpath $0)); source install_source.sh


l bin                                   bin

d                                       ${XDG_CONFIG_HOME:-$HOME/.config}
l config/cdm                            ${XDG_CONFIG_HOME:-$HOME/.config}/cdm
l config/compton.conf                   ${XDG_CONFIG_HOME:-$HOME/.config}/compton.conf
l config/git                            ${XDG_CONFIG_HOME:-$HOME/.config}/git
l i3                                    ${XDG_CONFIG_HOME:-$HOME/.config}/i3
l config/j4status                       ${XDG_CONFIG_HOME:-$HOME/.config}/j4status
l config/py3blocks                      ${XDG_CONFIG_HOME:-$HOME/.config}/py3blocks
l config/redshift.conf                  ${XDG_CONFIG_HOME:-$HOME/.config}/redshift.conf
l config/sway                           ${XDG_CONFIG_HOME:-$HOME/.config}/sway

l env.sh                                ${XDG_CONFIG_HOME:-$HOME/.config}/env.sh

d                                       .emacs.d
l emacs.d/config                        .emacs.d/config
l emacs.d/init.el                       .emacs.d/init.el

d                                       .gnupg
l gnupg/gpg.conf                        .gnupg/gpg.conf
l gnupg/gpg-agent.conf                  .gnupg/gpg-agent.conf

l prompt                                .prompt

l Xdefaults                             .Xdefaults

l zshrc                                 .zshrc
