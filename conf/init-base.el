;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;; BASE SETTING
;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; DEFAULT FRAME SETTING
;;;
;;; 文字色、背景色、カーソルの種類・色・高さ等を設定
;;;
;; (setq initial-frame-alist
;;       (append (list '(foreground-color . "Snow")
;;             ;; '(background-color . "gray11")
;;             ;; '(background-color . "black")
;;             ;; '(border-color . "tan4")
;;             '(vertical-scroll-bars . nil) ;;スクロールバーはいらない
;;             '(width . 60)
;;             '(height . 40)
;;             '(top . 30)
;;             '(left . 40)
;;             ;; '(cursor-type . box)      ; 種類
;;             ;; '(cursor-color . "firebrick") ; 色
;;             ;; '(cursor-height . 1)      ; 高さ
;;             ;; '(alpha . (70 100 100 100))
;;             )
;;           initial-frame-alist))

;; (setq default-frame-alist initial-frame-alist)

;; 透明度の下限 (15%)
;; (setq frame-alpha-lower-limit 15)
;; (setq frame-alpha-lower-limit 0.15)

;; デフォルトの透明度を設定する (85%)
(add-to-list 'default-frame-alist '(alpha . 98))

;; カレントウィンドウの透明度を変更する (85%)
(set-frame-parameter nil 'alpha 98)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; FONT SETTING
;;;
; EMACS23 用設定
;; (COND ( (STRING-MATCH "^23\." EMACS-VERSION)
;;         (COND (WINDOW-SYSTEM
;;                (SET-FONTSET-FONT (FRAME-PARAMETER NIL 'FONT)
;;                                  'JAPANESE-JISX0208
;;                                  '("IPAGOTHIC" . "UNICODE-BMP"))
;;                ))))
(when window-system
  (progn
    (set-default-font "Migu 1M-11")
    (set-fontset-font (frame-parameter nil 'font)
                      'japanese-jisx0208
                      '("Migu 1M-11" . "unicode-bmp"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; FONT LOCK SETTING
;;;
;; color-theme.el
(when (require 'color-theme)
  (color-theme-initialize)
  ;; color-theme-solorized.el
  (when (require 'color-theme-solarized)
    ;; (color-theme-solarized-light)
    (color-theme-solarized-dark)
    ))

(eval-after-load "font-lock"
  (dolist (face '(font-lock-function-name-face
                  font-lock-string-face
                  message-header-to))
    (make-face-bold face)))

(eval-after-load "message"
  (dolist (face '(message-header-to
                  message-header-cc))
    (make-face-bold face)))

;; (when (require 'color-theme)
;;   (color-theme-initialize)
;;   ;; color-theme-solorized.el
;;   (when (require 'color-theme-sanityinc-solarized)
;;     ;; (color-theme-sanityinc-solarized-light)
;;     (color-theme-sanityinc-solarized-dark)
;;     ))



;; (global-font-lock-mode t)
;; (add-hook 'font-lock-mode-hook '(lambda ()
;;   ;; (set-face-foreground 'font-lock-builtin-face "papaya whip")           ;;
;;   ;; (set-face-foreground 'font-lock-comment-face "NavajoWhite3")          ;; コメント色
;;   ;; (set-face-foreground 'font-lock-string-face  "gray11")                ;; 文字列色
;;   ;; (set-face-background 'font-lock-string-face "snow")                   ;; 文字列背景色
;;   ;; (set-face-foreground 'font-lock-keyword-face "firebrick")             ;; 予約語色
;;   ;; (set-face-foreground 'font-lock-constant-face "DarkGoldenrod1")       ;; クラス色
;;   ;; (set-face-foreground 'font-lock-function-name-face "SteelBlue2")      ;; 関数色
;;   (set-face-underline-p 'font-lock-function-name-face t)                ;; 関数に下線
;;   ;; (set-face-foreground 'font-lock-variable-name-face "show")            ;; オブジェクト,変数色
;;   ;; (set-face-foreground 'font-lock-type-face "chartreuse4")              ;; メソッド色
;;   ;; (set-face-foreground 'font-lock-warning-face "red3")                  ;;
;;   (set-face-bold-p 'font-lock-function-name-face t)
;;   (set-face-bold-p 'font-lock-warning-face t)
;; ))

(custom-set-faces '(flymake-errline ((((class color)) (:background "firebrick"))))
                  '(flymake-warnline ((((class color)) (:background "IndianRed")))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; リージョンを色付きにする
;;;
;; (setq transient-mark-mode 1)
;; (set-face-background 'region "RosyBrown1")
;; (set-face-foreground 'region "black")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MODELINE SETTING
;;;
;; (set-face-bold-p 'modeline t) ;; ボールドオン
;; (set-face-underline-p 'modeline t) ;;下線オン
;; (set-face-foreground 'modeline "Black")
;; (set-face-background 'modeline "burlywood4")
;; (set-border-color "pink")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; モードラインに日時を表示する
;;;
(setq display-time-24hr-format t)
 (setq display-time-day-and-date t)
 (setq display-time-string-forms
   '(month "/" day "(" dayname ") " 24-hours ":" minutes))
 (display-time)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; モード関連付け
;;;
(setq auto-mode-alist
      (append '(("\\.\\(C$\\|cc$\\|cpp$\\|hpp$\\)" . c++-mode)
                ("\\.\\(c$\\|h$\\|mth$\\|met$\\)" . c-mode)
                ("\\.cs$" . csharp-mode)
;;                 ("\\.aspx$" . html-mode)
                ("\\.java" . malabar-mode)
                ("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode)
;;                 ("\\.\\(html$\\|htm$\\)" . html-helper-mode)
                ("\\.\\(xs$\\|rng$\\|xhtml$\\|xml$\\|xsl$\\|html$\\|rhtml$\\)" . nxml-mode)
                ("\\.wl$" . lisp-mode)
                ("\\.\\(folders$\\|addres$\\|.*rc$\\)" . shell-script-mode)
                ("keys" . shell-script-mode)
                ("Gemfile" . ruby-mode)
                ("Rakefile" . ruby-mode)
                ) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 日本語環境
;;;
(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8-unix)

;; (set-language-environment "Japanese")
;; (if (equal (getenv "LANG") "ja_JP.UTF-8")
;;   (progn
;;     (cond ((<= emacs-major-version 21)
;;       (require 'un-define)))
;;     (set-default-coding-systems 'utf-8)
;;     (set-buffer-file-coding-system 'utf-8-unix)
;;     (set-terminal-coding-system 'utf-8)
;;     (set-keyboard-coding-system 'utf-8))
;;   (progn
;;     (set-default-coding-systems 'euc-jp)
;;     (set-buffer-file-coding-system 'euc-jp-unix)
;;     (set-terminal-coding-system 'euc-jp)
;;     (set-keyboard-coding-system 'euc-jp)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; キーバインド変更
;;;
(global-set-key "\C-m"  'newline-and-indent)    ;; 改行と同時にインデントを合わせる
(global-set-key "\C-j"  'newline)               ;; 改行
(global-set-key "\C-x?" 'help-command)          ;; ヘルプを表示
(global-set-key "\C-h"  'delete-backward-char)  ;; Back Space
(global-set-key "\C-x*" 'query-replace-regexp)  ;; 正規表現で置換
(global-set-key "\M-g"  'goto-line)             ;; 行指定移動
(global-set-key "\C-xm" 'mew)                    ;; Wanderlustの起動
(global-set-key [S-mouse-2] 'browse-url-at-mouse)
(global-set-key "\C-c\C-j" 'browse-url-at-point)
;; (global-set-key "\C-c2" 'navi2ch)               ;; navi2ch起動
(global-set-key "\C-c3" 'w3m)                   ;; w3m起動
(setq-default dabbrev-case-fold-search t)       ;;大文字小文字の区別なしにabbrevの展開をしてくれるようになる

;; (global-set-key "\M-o" 'dabbrev-expand)
;; (global-set-key "\M- " 'expand-abbrev)


;;;; □ アウトラインマイナーモードのキーバインド
;; (GLOBAL-SET-KEY "\C-C\C-O\C-T" 'HIDE-BODY)    ;; 隠蔽されているものすべてを表示する
;; (GLOBAL-SET-KEY "\C-C\C-O\C-A" 'SHOW-ALL)     ;; すべてのボディ行を隠蔽する
;; (GLOBAL-SET-KEY "\C-C\C-O\C-D" 'HIDE-SUBTREE) ;; 特定の見出しの下位の見出しとボディを隠蔽する
;; (GLOBAL-SET-KEY "\C-C\C-O\C-S" 'SHOW-SUBTREE) ;; 特定の見出しの下位の見出しとテキストを表示する
;; (GLOBAL-SET-KEY "\C-C\C-O\C-N" 'OUTLINE-NEXT-VISIBLE-HEADING) ;;次の見出しに移動する
;; (GLOBAL-SET-KEY "\C-C\C-O\C-P" 'OUTLINE-PRIVIOUS-VISIBLE-HEADING) ;; 前の見出しに移動する
;; (GLOBAL-SET-KEY "\C-C\C-O\C-F" 'OUTLINE-FORWARD-SAME-LEVEL) ;; 同一レベルの次の見出しに移動する
;; (GLOBAL-SET-KEY "\C-C\C-O\C-B" 'OUTLINE-BACKWARD-SAME-LEVEL) ;; 同一レベルの前の見出しに移動する
;; (GLOBAL-SET-KEY "\C-C\C-O\C-U" 'OUTLINE-UP-HEADING) ;; 1個上の見出しレベルに移動する
;; (GLOBAL-SET-KEY "\C-C\C-O\C-L" 'HIDE-LEAVES) ;; 特定の見出しのボディとその下位の見出し全部のボディを隠蔽する
;; (GLOBAL-SET-KEY "\C-C\C-O\C-K" 'SHOW-BRANCHES) ;; 見出しのボディとその下位のすべての見出しの全ボディを表示する
;; (GLOBAL-SET-KEY "\C-C\C-O\C-I" 'SHOW-CHILDREN) ;; 特定の見出しのすぐ下のレベルの見出しを表示する(ボディテキストは含まない)

(defvar my-changecase-type 0 "0:upcase 1:capitalize 2:downcase")
(defun my-changecase-word (cnt)
  "Change previous word Upcase->Downcase->Capitalize."
  (interactive "p")
  (if (not (eq last-command 'my-changecase-word))
      (setq my-changecase-type 0))
  (cond ((= my-changecase-type 0)
     (upcase-word (- cnt))
     (setq my-changecase-type 1))
    ((= my-changecase-type 1)
     (capitalize-word (- cnt))
     (setq my-changecase-type 2))
    (t
     (downcase-word (- cnt))
     (setq my-changecase-type 0))))
(global-set-key "\C-cu" 'my-changecase-word)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; GC-CONS-THRESHOLDの設定
;;; 値 (初期設定では 400,000) を大きくすると、
;;; ガベッジコレクションの頻度が下がり、結果として EMACS の動作が速くなる
;;;
(setq gc-cons-threshold 5242880)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 起動時のメッセージを表示しない
;;;
(setq inhibit-startup-message t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 冒頭文章の消去
;;;
(setq initial-scratch-message nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Emacsからの質問を y/n で回答する
;;;
(fset 'yes-or-no-p 'y-or-n-p)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; タブの幅の設定
;;;
;(setq-default indent-tabs-mode t)    ;;インデントをすべてタブで行う
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)           ;;タブ幅4に設定

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 下線を表示する
;;;
(setq hl-line-face 'underline)
(global-hl-line-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; バックアップファイルを作らない
;;;
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; ビープ音も画面のフラッシュも解除する
;;;
(setq ring-bell-function '(lambda ()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; タブ, 全角スペースを表示する
;;;
(defface my-face-r-1 '((t (:background "gray15"))) nil)
(defface my-face-b-1 '((t (:background "gray"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;;(defvar my-face-r-1 'my-face-r-1)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     ;;("[\r]*\n" 0 my-face-r-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 対応する括弧へ移動 'C-X %'
;;;
(progn
  (defvar com-point nil
    "Remember com point as a marker. \(buffer specific\)")
  (set-default 'com-point (make-marker))
  (defun getcom (arg)
    "Get com part of prefix-argument ARG."
    (cond ((null arg) nil)
      ((consp arg) (cdr arg))
      (t nil)))
  (defun paren-match (arg)
    "Go to the matching parenthesis."
    (interactive "P")
    (let ((com (getcom arg)))
      (if (numberp arg)
      (if (or (> arg 99) (< arg 1))
          (error "Prefix must be between 1 and 99.")
        (goto-char
         (if (> (point-max) 80000)
         (* (/ (point-max) 100) arg)
           (/ (* (point-max) arg) 100)))
        (back-to-indentation))
    (cond ((looking-at "[\(\[{]")
           (if com (move-marker com-point (point)))
           (forward-sexp 1)
           (if com
           (paren-match nil com)
         (backward-char)))
          ((looking-at "[])}]")
           (forward-char)
           (if com (move-marker com-point (point)))
           (backward-sexp 1)
           (if com (paren-match nil com)))
          (t (error ""))))))
  (define-key ctl-x-map "%" 'paren-match))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 行末の余分なスペースを"M-X TRIM-BUFFER"で消去する
;;;
(defun trim-buffer ()
  "Delete excess whitespaces."
  (interactive)
  (save-excursion
    (goto-char (point-max))
    (delete-blank-lines)
    (while (re-search-backward "[ \t]+$" nil t)
      (replace-match "" nil nil))
    (when (y-or-n-p "Convert multiple spaces in this buffer to tabs?")
      (tabify (point-min) (point-max)))))
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 1行ずつスクロールさせる
;;;
(setq scroll-conservatively 35
       scroll-margin 0
       scroll-step 1)
(setq comint-scroll-show-maximum-output t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 保存後コンパイル
;;;
(add-hook 'after-save-hook
          (function (lambda ()
                      (if (string= (expand-file-name "~/.emacs.el")
                                   (buffer-file-name))
                          (save-excursion
                            (byte-compile-file "~/.emacs.el"))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 常にホームディレクトリから
;;;
(cd "~")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; DISPLAY FILENAME ON TITLEBAR
;;;
(setq frame-title-format "%b")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; NOT BLINK CURSOR
;;;
(blink-cursor-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; NOT DISPLAY TOOLBAR
;;;
(tool-bar-mode 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; メニューを表示させない。
;;;
(menu-bar-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; ISEARCH HILIGHT
;;;
(setq isearch-lazy-highlight-initial-delay 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 行数指定
;;;
(line-number-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 桁番号指定
;;;
(column-number-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; バッファの最後の行で NEXT-LINE しても新しい行を作らない
;;;
(setq next-line-add-newlines nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  バッファの最初の行で PREVIOUS-LINE しても、"BEGINNING-OF-BUFFER" と注意されないようにする。
;;;
(defun previous-line (arg)
  (interactive "p")
  (if (interactive-p)
      (condition-case nil
          (line-move (- arg))
        ((beginning-of-buffer end-of-buffer)))
    (line-move (- arg)))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; C-K(KILL-LINE) で行末の改行も含めて KILL する / C-K IS MODIFIED.
;;;
(defun kill-line-twice (&optional numlines)
  "Acts like normal kill except kills entire line if at beginning"
  (interactive "*p")
  (cond ((eobp) (signal 'end-of-buffer nil))
    ((or (bolp)
         (> numlines 1))
     (kill-line numlines))
    (t (kill-line))))
(global-set-key "\C-k" 'kill-line-twice)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; ホイールマウス
;;;
(setq mwheel-follow-mouse t)
(mwheel-install)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; マウスカーソルを編集中に消す
;;;
;;; 0=消さない それ以外=消えるまでの時間 (ミリ秒)
(setq w32-hide-mouse-timeout 1000)
;; nil=消さない t=キー入力でマウスカーソルが消える
(setq w32-hide-mouse-on-key t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 【】の色づけ
;;;
(show-paren-mode t)
(setq show-paren-style 'mixed)
;; (set-face-background 'show-paren-match-face "burlywood1")
;; (set-face-foreground 'show-paren-match-face "chocolate4")
(setq show-paren-style 'expression)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; C-CU を押すと、カーソルのすぐ左にある単語がすべて大文字になります。
;;;  もう一度 C-CU を押すと、最初の文字だけ大文字になります。
;;;  もう一度 C-CU を押すと、すべて小文字になります。
;;;  C-CU を押すたびに、これが繰り返されます。
;;;  MEADOWでは動かないらしい。
;;;
(defvar my-changecase-type 0 "0:upcase 1:capitalize 2:downcase")
(defun my-changecase-word (cnt)
  "Change previous word Upcase->Downcase->Capitalize."
  (interactive "p")
  (if (not (eq last-command 'my-changecase-word))
      (setq my-changecase-type 0))
  (cond ((= my-changecase-type 0)
     (upcase-word (- cnt))
     (setq my-changecase-type 1))
    ((= my-changecase-type 1)
     (capitalize-word (- cnt))
     (setq my-changecase-type 2))
    (t
     (downcase-word (- cnt))
     (setq my-changecase-type 0))))
(global-set-key "\C-cu" 'my-changecase-word)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; DISPLAY PICTURE
;;;
(auto-image-file-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 圧縮ファイルを読む
;;;
(auto-compression-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; インクリメンタルサーチ中に日本語を入力
;;;
(define-key isearch-mode-map "\C-k" 'isearch-edit-string)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 折り返しをやめる
;;;
(setq-default truncate-partial-width-windows t)
(setq-default truncate-lines t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 折り返し表示ON/OFF
;;;
(defun toggle-truncate-lines ()
  "折り返し表示をトグル動作します."
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))

(global-set-key "\C-cl" 'toggle-truncate-lines)  ; 折り返し表示ON/OFF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; リージョンに上書きで貼り付け(yank-overwrite-region)
;;;
(defun yank-overwrite-region () (interactive) (delete-region (mark) (point)) (yank))
(global-set-key [?\C-\S-y] 'yank-overwrite-region)

;; dired 時 z でファイルを開く
(defun dired-open ()
  (interactive)
  (let ((file (dired-get-filename)))
    (unless (file-directory-p file))
      ;; file がディレクトリでない場合
      (start-process "xdg-open" "diredxdg" "xdg-open" file)))
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map
              "z" 'dired-open)))

(defun xdg-open (filename)
  "Open file with specified application."
  (interactive "fOpen file: ")
  (when (stringp filename)
    (start-process "xdg-open" nil "xdg-open"
                   (expand-file-name filename))))
(global-set-key "\C-c\C-f" 'xdg-open)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; ediff関連のバッファを1つのフレームにまとめる
;;;
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 
;;;
;; (add-hook 'after-init-hook  (lambda() (eshell)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; sudo-ext
;;;
(server-start) ;  sudoeditで使う
(require 'sudo-ext)
