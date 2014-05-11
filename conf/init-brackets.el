;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(load "brackets")
;; blackets.elはC-modeの時に使いたいのでこうする
(add-hook 'c-mode-hook
          '(lambda()
             (progn
               (define-key c-mode-map "{" 'insert-braces)
               (define-key c-mode-map "(" 'insert-parens)
               (define-key c-mode-map "\"" 'insert-double-quotation)
               (define-key c-mode-map "[" 'insert-brackets)
               (define-key c-mode-map "\C-c}" 'insert-braces-region)
               (define-key c-mode-map "\C-c)" 'insert-parens-region)
               (define-key c-mode-map "\C-c]" 'insert-brackets-region)
               (define-key c-mode-map "\C-c\"" 'insert-double-quotation-region)
               )))

;; cperl-modeの時もこんな感じ
(add-hook 'cperl-mode-hook
          '(lambda()
             (progn
               (define-key cperl-mode-map "{" 'insert-braces)
               (define-key cperl-mode-map "(" 'insert-parens)
               (define-key cperl-mode-map "\"" 'insert-double-quotation)
               (define-key cperl-mode-map "[" 'insert-brackets)
               (define-key cperl-mode-map "\C-c}" 'insert-braces-region)
               (define-key cperl-mode-map "\C-c)" 'insert-parens-region)
               (define-key cperl-mode-map "\C-c]" 'insert-brackets-region)
               (define-key cperl-mode-map "\C-c\"" 'insert-double-quotation-region)
               )))

;; lisp-modeの時もこれだけ
(add-hook 'emacs-lisp-mode-hook
          '(lambda()
             (progn
               (define-key emacs-lisp-mode-map "(" 'insert-parens)
               (define-key emacs-lisp-mode-map "\"" 'insert-double-quotation)
               (define-key emacs-lisp-mode-map "\C-c)" 'insert-parens-region)
               )))

;; emacs-lisp-modeの時はこれだけ
(add-hook 'lisp-mode-hook
          '(lambda()
             (progn
               (define-key lisp-mode-map "(" 'insert-parens)
               (define-key lisp-mode-map "\"" 'insert-double-quotation)
               (define-key lisp-mode-map "\C-c)" 'insert-parens-region)
               )))

(add-hook 'nxml-mode-hook
          '(lambda()
             (progn
               (define-key c-mode-map "{" 'insert-braces)
               (define-key c-mode-map "(" 'insert-parens)
               (define-key c-mode-map "\"" 'insert-double-quotation)
               (define-key c-mode-map "[" 'insert-brackets)
               (define-key c-mode-map "\C-c}" 'insert-braces-region)
               (define-key c-mode-map "\"" 'insert-double-quotation)
               (define-key c-mode-map "\C-c)" 'insert-parens-region)
               (define-key c-mode-map "\C-c]" 'insert-brackets-region)
               (define-key c-mode-map "\C-c\"" 'insert-double-quotation-region)
               )))