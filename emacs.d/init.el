(load "~/.emacs.d/config/defuns")

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

(config 'theme)

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
 'before-save-hook 'time-stamp)
(add-hook
 'before-save-hook 'whitespace-cleanup)


;;;; global key bindings
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;;;; Packages and Mode-configs

;;;;; nyan-mode
(with-eval-after-load "nyan-mode-autoloads"
	(nyan-mode)
  )

;;;;; undo-tree
(with-eval-after-load "undo-tree-autoloads"
	(global-undo-tree-mode t)
	(setq undo-tree-visualizer-relative-timestamps t)
	(setq undo-tree-visualizer-timestamps t)
  )

;;;;; smart-tabs-mode
(with-eval-after-load "smart-tabs-mode-autoloads"
	(setq-default indent-tabs-mode nil)
	(smart-tabs-insinuate
   'c
   'c++
   'javascript
   )
  )

;;;;; AUCTeX
(with-eval-after-load "auctex-autoloads"
	(add-hook 'LaTeX-mode-hook 'visual-line-mode)
	(add-hook 'LaTeX-mode-hook 'flyspell-mode)
	(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
	(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
	(setq
   TeX-PDF-mode t
   preview-auto-cache-preamble t
   )
  )
