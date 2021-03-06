;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; here's my yasnippet's configuration
(require 'yasnippet)
;; (require 'helm-c-yasnippet)


(setq helm-c-yas-space-match-any-greedy t) ;[default: nil]
(global-set-key (kbd "C-c y") 'helm-c-yas-complete)
(yas--initialize)
(yas-load-directory "~/.emacs.d/elisp/yasnippets-rails/rails-snippets")

;; (add-to-list 'yas-extra-mode-hooks 'ruby-mode-hook)
;; (add-to-list 'yas-extra-mode-hooks 'cperl-mode-hook)

;; (setq yas-trigger-key (kbd "C-i"))
;; (setq yas/next-field-key (kbd "TAB"))

(yas-global-mode 1)
;; (yas-minor-mode 1)

;; (define-key yas-minor-mode-map (kbd "C-i") 'yas/trigger-key)
(custom-set-variables '(yas-trigger-key "C-i"))
;; (global-set-key (kbd "C-i") 'yas/expand)
(setq yas/also-auto-indent-first-line t)




;; (define-key yas-keymap [(tab)] 'yas-expand)
;; (yas-global-mode 1)
