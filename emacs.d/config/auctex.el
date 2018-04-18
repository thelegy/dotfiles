;;; package configuration: auctex

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(setq-default
 preview-scale-function 1.3
 TeX-master nil
 )

(setq
 preview-auto-cache-preamble t
 TeX-auto-save t
 TeX-parse-self t
 TeX-PDF-mode t

 ;; German Quotations
 TeX-open-quote "\"`"
 TeX-close-quote "\"'"
 )

;; Expand mathmode

(setq
 LaTeX-math-list
 (quote
  (
   ("_" LaTeX-math-partial)
   )
  )
 )
