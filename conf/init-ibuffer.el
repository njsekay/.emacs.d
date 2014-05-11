;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(require 'ibuffer)
;;;; 表示の設定
(setq ibuffer-formats
      '((mark modified read-only " " (name 30 30)
              " " (size 6 -1) " " (mode 16 16) " " filename)
        (mark " " (name 30 -1) " " filename)))
;;;; 文字コードを表示する
(setq ibuffer-formats '((mark modified read-only (coding 15 15) " " (name 30 30)
                              " " (size 6 -1) " " (mode 16 16) " " filename)
                        (mark (coding 15 15) " " (name 30 -1) " " filename)))
(ibuffer-define-column
;;;; ibuffer-formats に追加した文字
 coding
 ;; 一行目の文字
 (:name " coding ")
 ;; 以下に文字コードを返す関数を書く
 (if (coding-system-get buffer-file-coding-system 'mime-charset)
     (format " %s" (coding-system-get buffer-file-coding-system 'mime-charset))
   " undefined"
   ))
(global-set-key "\C-x\C-b" 'ibuffer)
