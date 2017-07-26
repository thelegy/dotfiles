#!/bin/bash
cd $(dirname $(realpath $0)); source install_source.sh


l bin                                   bin

d                                       ${XDG_CONFIG_HOME:-.config}
l config/cdm                            ${XDG_CONFIG_HOME:-.config}/cdm
l config/compton.conf                   ${XDG_CONFIG_HOME:-.config}/compton.conf
l config/git                            ${XDG_CONFIG_HOME:-.config}/git
l i3                                    ${XDG_CONFIG_HOME:-.config}/i3
l config/j4status                       ${XDG_CONFIG_HOME:-.config}/j4status
l config/redshift.conf                  ${XDG_CONFIG_HOME:-.config}/redshift.conf
l config/sway                           ${XDG_CONFIG_HOME:-.config}/sway

d                                       .emacs.d
l emacs.d/config                        .emacs.d/config
l emacs.d/init.el                       .emacs.d/init.el

d                                       .gnupg
l gnupg/gpg.conf                        .gnupg/gpg.conf
l gnupg/gpg-agent.conf                  .gnupg/gpg-agent.conf

l prompt                                .prompt

l Xdefaults                             .Xdefaults

l zshrc                                 .zshrc
