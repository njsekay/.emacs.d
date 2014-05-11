;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(autoload 'lookup "lookup" nil t)
(autoload 'lookup-region "lookup" nil t)
(autoload 'lookup-pattern "lookup" nil t)
;;;; □ キーバインドの設定
(define-key ctl-x-map "l" 'lookup)      ; C-x l - lookup
(define-key ctl-x-map "y" 'lookup-region) ; C-x y - lookup-region
(define-key ctl-x-map "\C-y" 'lookup-pattern) ; C-x C-y - lookup-pattern
(put 'narrow-to-region 'disabled nil)

;; Please add these lines in your .emacs(_emacs).
;;
;; (setq send-mail-function 'smtpmail-send-it)
;; (setq smtp-default-server "ybbsmtp.mail.yahoo.co.jp")
;; (setq smtp-service "smtp")
;; (setq smtp-local-domain "yahoo.co.jp")
;; (setq smtp-debug-info t)
;; (autoload 'smtpmail-send-it "smtpmail")
;; (setq user-full-name "fmrkk280")
;; (setq smtp-debug-info t)
;;;; □ set up W3
;; (setq browse-url-browser-function 'browse-url-w3m)
(defun w3m-browse-url-other-window (url &optional newwin)
  (interactive "s")
  (w3m-browse-url url t))

(setq browse-url-browser-function
      '(("jde_meta" . w3m-browse-url-other-window)
    (".*" . w3m-browse-url)
; or if you prefer:
;   (".*" . browse-url-mozilla)
))