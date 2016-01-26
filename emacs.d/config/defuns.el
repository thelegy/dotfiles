;;; Global function definitions

;; Function for loading configuration files
(defun config (confname)
  (load
   (concat "~/.emacs.d/config/" (symbol-name confname))
   'noerror
   )
  )
