;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; lisp-mode 色づけ
;;;
(defface my-face-elisp-macro
  '((t (:foreground "pale green"))) nil)
(defface my-face-elisp-subr
  '((t (:foreground "gold"))) nil)
(defface my-face-elisp-func
  '((t (:foreground "hot pink"))) nil)
(defun my-font-lock-elisp-macro (limit)
  (when (re-search-forward
         "['(]\\([^() \n]+\\)" limit t)
    (or (and (not (memq (get-text-property
                         0 'face (match-string 1))
                        '(font-lock-comment-face
                          font-lock-warning-face)))
             (condition-case nil
                 (symbol-function
                  (intern-soft
                   (match-string-no-properties 1)))
               (error nil)))
        (my-font-lock-elisp-macro limit))))
(defun my-font-lock-elisp-subr (limit)
  (when (re-search-forward
         "['(]\\([^() \n]+\\)" limit t)
    (or (and (not (memq (get-text-property
                         0 'face (match-string 1))
                        '(font-lock-comment-face
                          font-lock-warning-face)))
             (subrp
              (condition-case nil
                  (symbol-function
                   (intern-soft
                    (match-string-no-properties 1)))
                (error nil))))
        (my-font-lock-elisp-subr limit))))
(defun my-font-lock-elisp-func (limit)
  (when (re-search-forward
         "['(]\\([^() \n]+\\)" limit t)
    (or (and (not (memq
                   (get-text-property
                    0 'face (match-string 1))
                   '(font-lock-comment-face
                     font-lock-warning-face)))
             (byte-code-function-p
              (condition-case nil
                  (symbol-function
                   (intern-soft
                    (match-string-no-properties 1)))
                (error nil))))
        (my-font-lock-elisp-func limit))))
(font-lock-add-keywords
 'lisp-interaction-mode
 '((my-font-lock-elisp-macro 1 'my-face-elisp-macro t)) t)
(font-lock-add-keywords
 'lisp-interaction-mode
 '((my-font-lock-elisp-func 1 'my-face-elisp-func t)) t)
(font-lock-add-keywords
 'lisp-interaction-mode
 '((my-font-lock-elisp-subr 1 'my-face-elisp-subr t)) t)
(font-lock-add-keywords
 'emacs-lisp-mode
 '((my-font-lock-elisp-macro 1 'my-face-elisp-macro t)) t)
(font-lock-add-keywords
 'emacs-lisp-mode
 '((my-font-lock-elisp-func 1 'my-face-elisp-func t)) t)
(font-lock-add-keywords
 'emacs-lisp-mode
 '((my-font-lock-elisp-subr 1 'my-face-elisp-subr t)) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Emacs-Lisp-mode
;;; アウトラインマイナーモード
;;;
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            ;; タブではなくスペースを使う
            (setq indent-tabs-mode nil)
            ;; アウトラインモード関係
            (make-local-variable 'outline-regexp)
            ;; (i)   ';;; '
            ;; (ii)  ';;;; '
            ;; (iii) ';;;;; '
            (setq outline-regexp "^;;; \\|^;;;; \\|^;;;;; ")
            ))
(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)
