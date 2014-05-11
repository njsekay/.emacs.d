;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(setq skk-tut-file "/usr/share/skk/SKK.tut")

(setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L")

;;;; 漢字変換 (skk) の設定
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)

(autoload 'skk-mode "skk" nil t)
(autoload 'skk-tutorial "skk-tut" nil t)
(autoload 'skk-check-jisyo "skk-tools" nil t)
(autoload 'skk-merge "skk-tools" nil t)
(autoload 'skk-diff "skk-tools" nil t)
;;;; "「"を入力したら"」"も自動で挿入
(setq skk-auto-insert-paren t)
;;;; 句読点は , . を使う
(setq skk-kuten-touten-alist
  '(
    (jp . ("。" . "、" ))
    (en . ("．" . "，"))
    ))
;;;; jp にすると「。、」を使います
(setq-default skk-kutouten-type 'jp)
;;;; @で挿入する日付表示を半角に
(setq skk-number-style nil)
;;;; 変換のときEnterを押しても確定のみで改行しない。
(setq skk-egg-like-newline t)
(setq skk-hiragana-cursor-color "pink")
