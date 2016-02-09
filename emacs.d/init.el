(load "~/.emacs.d/config/defuns")

;;;; package.el
(require 'package)

(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

;;;; load configuration files

(config 'backup)
(config 'global-keybindings)
(config 'global-settings)
(config 'mouse-interface)
(config 'sh-mode)
(config 'splash-screen)
(config 'theme)

;;;; make sure packages are installed and configure them

(if (version< emacs-version "24.4")
    (message "is before 24.4")
  (progn
    (package 'magit)
    (package 'smart-tabs-mode)
    )
  )

(package 'auctex)
(package 'helm)
(package 'sr-speedbar)
(package 'tramp)
