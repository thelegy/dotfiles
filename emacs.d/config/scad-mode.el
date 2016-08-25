;;; configure scad-mode

(defun scad-mode-after-change (begin end length)
  ;; update scad-preview-default-viewport
  (let ((vpr_reg "^[[:space:]]*\\$vpr[[:space:]]*=[[:space:]]*\\[\\([[:digit:]]+\\)[[:space:]]*,[[:space:]]*\\([[:digit:]]+\\)[[:space:]]*,[[:space:]]*\\([[:digit:]]+\\)\\][[:space:]]*;")
        (vpt_reg "^[[:space:]]*\\$vpt[[:space:]]*=[[:space:]]*\\[\\([[:digit:]]+\\)[[:space:]]*,[[:space:]]*\\([[:digit:]]+\\)[[:space:]]*,[[:space:]]*\\([[:digit:]]+\\)\\][[:space:]]*;")
        (vpd_reg "^[[:space:]]*\\$vpd[[:space:]]*=[[:space:]]*\\([[:digit:]]+\\)[[:space:]]*;")
        matches)
                                        ; process the vpd statement
    (if (string-match vpd_reg (buffer-string))
        (progn
          (push (string-to-number (match-string-no-properties 1 (buffer-string))) matches)
          )
      (progn
        (push 500 matches)
        )
      )

                                        ; process the vpr statement
    (if (string-match vpr_reg (buffer-string))
        (progn
          (push (string-to-number (match-string-no-properties 3 (buffer-string))) matches)
          (push (string-to-number (match-string-no-properties 2 (buffer-string))) matches)
          (push (string-to-number (match-string-no-properties 1 (buffer-string))) matches)
          )
      (progn
        (push 20 matches)
        (push 0 matches)
        (push 50 matches)
        )
      )

                                        ; process the vpt statement
    (if (string-match vpt_reg (buffer-string))
        (progn
          (push (string-to-number (match-string-no-properties 3 (buffer-string))) matches)
          (push (string-to-number (match-string-no-properties 2 (buffer-string))) matches)
          (push (string-to-number (match-string-no-properties 1 (buffer-string))) matches)
          )
      (progn
        (push 0 matches)
        (push 0 matches)
        (push 0 matches)
        )
      )

                                        ; set the default viewport
    (setq scad-preview-default-camera-parameters matches)
    )
  )

(defun scad-mode-custom()
  ;; add the per-buffer hooks
  (add-hook
               'after-change-functions
               'scad-mode-after-change
               t
               t)

  ;; call the scad-mode-after-change hook
  (scad-mode-after-change 0 0 0)

  ;; set some variables
  (setq
   tab-width 2
   c-basic-offset 2
   )
  )

;; add the global hook
(add-hook
 'scad-mode-hook
 'scad-mode-custom)
