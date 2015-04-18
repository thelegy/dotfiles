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
