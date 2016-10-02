(load "~/.emacs.d/config/defuns")

;;;; package.el
(require 'package)

(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

;;;; load configuration files

(config
 'backup
 'custom
 'global-keybindings
 'global-settings
 'mouse-interface
 'org
 'sh-mode
 'splash-screen
 'theme
 )

;;;; make sure packages are installed and configure them

(if (version< emacs-version "24.4")
    (message "is before 24.4")
  (package
   'magit
   'smart-tabs-mode
   )
  )

(package
 'ample-zen-theme
 'auctex
 'go-mode
 'helm
 'lua-mode
 'org
 'salt-mode
 'scad-mode
 'scad-preview
 'smart-tabs-mode
 'sr-speedbar
 'tramp
 'w3
 )
