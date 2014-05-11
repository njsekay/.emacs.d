;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(require 'term+autoloads)
(eval-after-load 'term+
  '(progn
     (require 'xterm-256color)
     (require 'term+key-intercept)
     (require 'term+mode)
     (require 'term+mux)
     (require 'term+anything-shell-history)))

;; Find available shell
(defun skt:shell () 
  (or (executable-find "zsh") ;; bashユーザは一行下と入れ替え
      (executable-find "bash")
      (error "No shell program was found in your PATH...")))
 
;; Set shell-name 
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)
 
;; ;; Setup sufficient moji-codes for Mac
;; (setq system-uses-terminfo nil)
;; (prefer-coding-system 'utf-8)
;; (require 'ucs-normalize)
;; (setq file-name-coding-system 'utf-8-hfs)
;; (setq locale-coding-system 'utf-8-hfs)
 
;; Color settings for term
;; (setq term-default-bg-color "Black")
;; (autoload 'ansi-color-for-comint-mode-on "ansi-color"
;;   "Set `ansi-color-for-comint-mode' to t." t)
 
;; Binding key
(global-unset-key "\C-t")
(global-set-key "\C-t" '(lambda ()
                                (interactive)
                                (ansi-term shell-file-name)
                                (term+mux-new)))


;; (global-set-key "\C-c1" 'term+mux-new)

