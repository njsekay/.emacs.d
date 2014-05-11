;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

(setq ssl-certificate-verification-policy 1)

(global-set-key "\C-x\C-m" 'wl)