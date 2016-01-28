;;; Global function definitions

;; Function for loading configuration files
(defun config (confname)
  (load
   (concat "~/.emacs.d/config/" (symbol-name confname))
   'noerror
   )
  )

;; Function for installing and configuring packages
(defun package (package)
  (if (not (package-installed-p package))
      (progn
        (package-refresh-contents)
        (package-install package)
        )
    )
  (if (package-installed-p package)
      (config package)
    )
  )
