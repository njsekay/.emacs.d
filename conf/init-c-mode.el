;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; C
;;;
(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-set-style "gnu")
             (setq c-basic-offset 4)))
;;;
;;; GTK+ / GDK
;;; gtk keywords
;;;
(font-lock-add-keywords 'c-mode
                        '(("\\<Gtk[A-Z][A-Za-z]*" . 'font-lock-type-face)))
(font-lock-add-keywords 'c-mode
                        '(("\\<Gdk[A-Z][A-Za-z]*" . 'font-lock-type-face)))
;;;
;;; GNU なスタイル / 自動でカッコの前にスペースを入れる
;;;
(require 'cc-mode)
(defun my-insert-parens-with-space (arg)
  (interactive "*P")
  (let* ((spacep (not (or (string-match "[( \t\n]" (char-to-string (char-before)))
                          (c-in-literal)
                          arg))))
    (if spacep (insert " "))
    (self-insert-command (prefix-numeric-value arg))))

(define-key c-mode-map "\(" 'my-insert-parens-with-space)
(define-key c-mode-map "\{" 'my-insert-parens-with-space)
(define-key c++-mode-map "\(" 'my-insert-parens-with-space)
(define-key c++-mode-map "\{" 'my-insert-parens-with-space)
(define-key c-mode-base-map "\C-cc" 'compile)


;;;; ',' を ', ' にする関数を c-mode-map にも追加
(when (not (functionp 'insert-comma))
  (defun insert-comma (arg)
    (interactive "*P")
    (let* ((ch (char-after))
           (spacep (not (or (eq ch ? )
                            (c-in-literal)
                            arg))))
      (self-insert-command (prefix-numeric-value arg))
      (if spacep (insert " ")))))


(define-key c-mode-map "," 'insert-comma)
(define-key c++-mode-map "," 'insert-comma)
;;;; □アウトラインマイナーモード
(add-hook 'c-mode-hook
          (lambda ()
            ;; アウトラインモード関係
            (make-local-variable 'outline-regexp)
            ;; (i)   `/***  '
            ;; (ii)  `;;;; '
            ;; (iii) `;;;;; '
            (setq outline-regexp "^\\/\\*\\* .* \\*\\*\\/$\\|^;;;; \\|^;;;;; ")
            ))
(add-hook 'c-mode-hook 'outline-minor-mode)
;;;; ヘッダの補完
(add-hook 'c-mode-common-hook
          (function (lambda ()
                      (require 'cpp-complt)
                      (define-key c-mode-map [mouse-2]
                        'cpp-complt-include-mouse-select)
                      (define-key c-mode-map "#"
                        'cpp-complt-instruction-completing)
                      (define-key c-mode-map "\C-c#"
                        'cpp-complt-ifdef-region)
                      (cpp-complt-init))))
(setq cpp-complt-standard-header-path
      '(
        "/usr/include/"
        ))
;; (require 'c-includes)

(setq which-function t)
(global-set-key "\C-c\C-f" 'info-lookup-symbol)
