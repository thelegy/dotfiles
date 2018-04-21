;;; package configuration: elpy

(elpy-enable)

(if (package-installed-p 'flycheck)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  )
