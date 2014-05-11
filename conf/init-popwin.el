;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

(global-set-key "\C-xp" 'popwin:display-buffer)
(global-set-key "\C-xP" 'popwin:display-last-buffer)

;; (push '(dired-mode :position top) popwin:special-display-config)

(setq anything-samewindow nil)
(push '("*anything*" :height 20) popwin:special-display-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; the others
;; (add-to-list 'popwin:special-display-config '("*Help*"))

(setq popwin:special-display-config '(
                                      ("*Help*")
                                      ("*Compile-Log*" :height 10 :noselect t)
                                      ("*Completions*" :noselect t)
                                      ("*compilatoin*" :noselect t)
                                      ("*Occur*")
                                      ("*Kill Ring*")
                                      ("*slime-apropos*");; slime Apropos
                                      ("*slime-macroexpansion*");; slime Macroexpand
                                      ("*slime-description*");; slime Help
                                      ("*slime-compilation*" :noselect t);; slime Compilation
                                      ("*slime-xref*");; slime Cross-reference
                                      (sldb-mode :stick t);; slime Debugger
                                      (slime-repl-mode);; slime REPL
                                      (slime-connection-list-mode);; slime Connections
                                      ))