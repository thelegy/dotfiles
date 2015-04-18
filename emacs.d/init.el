;;;;;;;;;;;;;;;;;;;;;
;;;    init.el    ;;;
;;; by Jan Beinke ;;;
;;;;;;;;;;;;;;;;;;;;;


; Feel free to use, change and create more,
; I would also encourage you to report me
; any bugs or problems, you have with this.

; This file comes with abolutely no warrenty,
; and it is provided as-is.


; Now, let's come to the good stuff:


;; Turn off mouse interface as early as possible
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please...
(setq inhibit-startup-screen t)


;;;; package.el
(require 'package)

(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

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

(add-hook
	'before-save-hook 'time-stamp
)
