;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(autoload 'clmemo "clmemo" "ChangeLog memo mode." t)
;;;; □ あなたの ChangeLog メモファイルへのパス
(setq clmemo-file-name "~/.emacs.d/data/clmemo.txt")
;;;; □ 好きなキーへバインド
;;(global-set-key "\C-xM" 'clmemo)

(setq clmemo-buffer-function-list
        '(clmemo-insert-region))

(setq clmemo-time-string-with-weekday t)

(setq clmemo-subtitle-char "[")
(setq clmemo-subtitle-punctuation-char '(" [" . "]"))

(defadvice clmemo-get-title (after clmemo-get-title-with-time () activate)
  (setq ad-return-value (concat (format-time-string "%H:%M ") ad-return-value)))

(add-hook
 'change-log-mode-hook
 (lambda ()
   (setq outline-regexp "\\(^[0-9A-Za-z]\\|[\t][*]\\)")
   (outline-minor-mode t)))

; item-headerに空白があっても色をつける
(defface my-clmemo-item-header-face
  '((((class color) (background light))
     (:background "black" :foreground "skyblue"))
    (((class color) (background dark))
     (:background "black" :foreground "skyblue"))
    (t
     (:bold t)))
  "Face for highlighting item header.")
(add-hook 'change-log-mode-hook
          '(lambda()
         (highlight-regexp "\\* *.+:" "my-clmemo-item-header-face")))

(add-to-list 'auto-mode-alist (cons  "clmemo.txt" 'change-log-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; clgrep
;;;
(autoload 'clgrep "clgrep" "ChangeLog grep." t)
(autoload 'clgrep-item "clgrep" "ChangeLog grep." t)
(autoload 'clgrep-item-header "clgrep" "ChangeLog grep for item header" t)
(autoload 'clgrep-item-tag "clgrep" "ChangeLog grep for tag" t)
(autoload 'clgrep-item-notag "clgrep" "ChangeLog grep for item except for tag" t)
(autoload 'clgrep-item-nourl "clgrep" "ChangeLog grep item except for url" t)
(autoload 'clgrep-entry "clgrep" "ChangeLog grep for entry" t)
(autoload 'clgrep-entry-header "clgrep" "ChangeLog grep for entry header" t)
(autoload 'clgrep-entry-no-entry-header "clgrep" "ChangeLog grep for entry except entry header" t)
(autoload 'clgrep-entry-tag "clgrep" "ChangeLog grep for tag" t)
(autoload 'clgrep-entry-notag "clgrep" "ChangeLog grep for tag" t)
(autoload 'clgrep-entry-nourl "clgrep" "ChangeLog grep entry except for url" t)
(add-hook 'clmemo-mode-hook
          '(lambda () (define-key clmemo-mode-map "\C-c\C-g" 'clgrep)))
