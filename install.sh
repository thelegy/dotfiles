#!/bin/bash
cd $(dirname $(realpath $0)); source install_source.sh


l bin                                   bin

d                                       .config
l config/compton.conf                   .config/compton.conf
l config/git                            .config/git
l config/j4status                       .config/j4status
l config/redshift.conf                  .config/redshift.conf

d                                       .emacs.d
l emacs.d/config                        .emacs.d/config
l emacs.d/init.el                       .emacs.d/init.el

d                                       .gnupg
l gnupg/gpg.conf                        .gnupg/gpg.conf
l gnupg/gpg-agent.conf                  .gnupg/gpg-agent.conf

l i3                                    .i3

l prompt                                .prompt

l Xdefaults                             .Xdefaults

l zshrc                                 .zshrc
