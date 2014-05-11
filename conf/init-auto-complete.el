;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;C-sでインクリメンタルサーチできるようになったのでac-anything.elは不要とする
(when (require 'auto-complete-config nil t)
  (global-auto-complete-mode t)
  (setq ac-dwim t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (setq-default ac-sources '(ac-source-slime-simple ac-source-abbrev ac-source-words-in-buffer ac-source-yasnippet ac-source-words-in-same-mode-buffers ac-source-symbols))
  (setq ac-auto-start t)
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)
  (set-face-background 'ac-selection-face "steelblue")
  (set-face-background 'ac-candidate-face "skyblue")
  (global-set-key "\M-/" 'ac-start)
  (require 'rcodetools)
  (add-hook 'ruby-mode-hook
            (lambda ()
              (setq ac-omni-completion-sources '(("\\.\\=" ac-source-rcodetools)))))
  (ac-config-default)
  (require 'ac-slime)
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
  )



