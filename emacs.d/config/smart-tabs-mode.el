;;; package configuration: smart-tabs-mode
(with-eval-after-load "smart-tabs-mode-autoloads"
	(setq-default indent-tabs-mode nil)
	(smart-tabs-insinuate
   'c
   'c++
   'javascript
   )
  )
