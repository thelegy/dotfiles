;;; configure backup and auto-save places

(setq backup-path "~/.emacs.d/backup")

(if (not (file-exists-p (directory-file-name backup-path)))
    (make-directory (directory-file-name backup-path))
  )

(setq
 backup-directory-alist `((".*" . ,(directory-file-name backup-path)))
 auto-save-file-name-transforms `((".*" ,(directory-file-name backup-path) t))
 auto-save-list-file-prefix (directory-file-name backup-path)
 )
