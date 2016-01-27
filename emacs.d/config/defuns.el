;;; Global function definitions

;; Function for loading configuration files
(defun config (confname)
  (load
   (concat "~/.emacs.d/config/" (symbol-name confname))
   'noerror
   )
  )

;; Function for installing and configuring packages
(defun package (pkg)
  (if (not (package-installed-p pkg))
      (package-install pkg)
    )
  (if (package-installed-p pkg)
      (config pkg)
    )
  )
