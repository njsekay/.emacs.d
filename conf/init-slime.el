;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; SLIMEのロード
(require 'slime)
;; (slime-setup '(slime-repl slime-fancy slime-banner))

(add-hook 'lisp-mode-hook (lambda ()
                            (slime-mode t)
                            (show-paren-mode)))

(setq slime-net-coding-system 'utf-8-unix)
(setq inferior-lisp-program "sbcl --noinform")
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

(define-key slime-mode-map "\C-c\C-i" 'auto-complete)

;; (when (require 'slime nil t)
;;   ;; (setq inferior-lisp-program "sbcl")
;;   ;; (slime-setup '(slime-repl slime-fancy slime-banner))
;;   ;; (setq slime-net-coding-system 'utf-8-unix)
;;   (require 'ac-slime)
;;   (add-hook 'slime-mode-hook 'set-up-slime-ac)
;;   (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
;;   (eval-after-load "auto-complete"
;;     '(add-to-list 'ac-modes 'slime-repl-mode)))




