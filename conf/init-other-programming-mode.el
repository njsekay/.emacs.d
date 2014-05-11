;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; yaml-mode
;;;
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; nxml
;;;
(add-hook 'nxml-mode-hook
          (lambda ()
            (setq auto-fill-mode -1)
            (setq nxml-slash-auto-complete-flag t)
            (setq nxml-child-indent 2)
            (setq indent-tabs-mode t)
            (setq tab-width 2)
            (define-key nxml-mode-map "\C-m" 'newline-and-indent)
            (setq nxml-attribute-indent 2)))

(defun nxml-custom-keybindings ()
    (define-key nxml-mode-map "\C-c\C-c" 'nxml-complete))

(add-hook 'nxml-mode-hook 'nxml-custom-keybindings)

;; (setq magic-mode-alist
;;       (cons '("<\\?xml " . nxml-mode)
;;             magic-mode-alist))

;; (setq magic-mode-alist
;;       (cons '("<!DOCTYPE" . nxml-mode)
;;             magic-mode-alist))

;; (add-hook 'nxml-mode-hook
;;           (lambda ()
;;             (setq nxml-slash-auto-complete-flag t)
;;             (setq nxml-child-indent 2)
;;             (setq indent-tabs-mode t)
;;             (setq tab-width 2)))
(custom-set-faces
 '(nxml-comment-content-face ((t (:foreground "yellow4"))))
 '(nxml-comment-delimiter-face ((t (:foreground "yellow4"))))
 '(nxml-delimited-data-face ((t (:foreground "lime green"))))
 '(nxml-delimiter-face ((t (:foreground "grey"))))
 '(nxml-element-local-name-face ((t (:foreground "yellow4"))))
 '(nxml-name-face ((t (:foreground "rosy brown"))))
 '(nxml-tag-slash-face ((t (:inherit nxml-name-face :foreground "grey")))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; CSS
;;;
(autoload 'css-mode "css-mode")
(setq cssm-indent-level 2)
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq css-environment-indent 4)


;; mode-info
(setq Info-directory-list
      (append
       Info-default-directory-list
       (list
        (expand-file-name "~/info")
;;         (expand-file-name "~/info/glibc-2.3.1")
;;         (expand-file-name "~/info/gnujdoc")
;;         (expand-file-name "~/info/perl5.000texi-j")
;;         (expand-file-name "~/info/ruby-1.4")
;;         "e:/unix/Meadow/1.15/info/"
        )
       ))
;; (require 'mi-config)
;; (define-key global-map "\M-\C-f" 'mode-info-describe-function)
;; (define-key global-map "\M-\C-v" 'mode-info-describe-variable)
;; (define-key global-map "\M-\C-h" 'mode-info-find-tag)
;; (require 'mi-fontify)