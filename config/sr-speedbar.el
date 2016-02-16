;;; package configuration: sr-speedbar

(defun sr-speedbar-custom-toggle ()
  (interactive)
  (sr-speedbar-toggle)
  (when (sr-speedbar-exist-p)
    (sr-speedbar-select-window)
    )
  )

(setq sr-speedbar-skip-other-window-p t)

(global-set-key (kbd "<f5>") 'sr-speedbar-custom-toggle)
