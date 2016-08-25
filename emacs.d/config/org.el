;;; configure org-mode

(setq org-agenda-files (quote ("~/org/")))

(add-hook 'before-save-hook
          #'gofmt-before-save)
