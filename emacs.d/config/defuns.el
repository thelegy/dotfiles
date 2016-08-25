;;; Global function definitions

;; Function for loading configuration files
(defun config (&rest confnames)
  (dolist (confname confnames)
    (load
     (concat "~/.emacs.d/config/" (symbol-name confname))
     'noerror
     )
    )
  )

;; Function for installing and configuring packages
(defun package (&rest packages)
  (dolist (package packages)
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
  )
