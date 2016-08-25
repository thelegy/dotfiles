;;; global settings

(setq-default
 indicate-empty-lines t
 tab-width 2
 )

(setq
 time-stamp-pattern nil
 )

(add-hook
 'before-save-hook 'time-stamp)
(add-hook
 'before-save-hook 'whitespace-cleanup)
