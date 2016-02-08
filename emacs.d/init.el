(load "~/.emacs.d/config/defuns")

;;;; package.el
(require 'package)

(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

;;;; load configuration files

(config 'global-keybindings)
(config 'mouse-interface)
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
(package 'sr-speedbar)
(package 'helm)
(package 'tramp)

;;;; macros

;;;; global settings
(setq-default
 tab-width 2
 TeX-master nil
 preview-scale-function 1.3
 )

(setq
 TeX-auto-save t
 TeX-parse-self t
 time-stamp-pattern nil
 )

(set-default
 'indicate-empty-lines t)

(add-hook
 'before-save-hook 'time-stamp)
(add-hook
 'before-save-hook 'whitespace-cleanup)

;;;; Packages and Mode-configs

