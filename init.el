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
;;; INIT SETTING
;;;
;;; w3m-el-snapshot, wl-beta, bbdbはaptitudeでインストール
;;;
;;;
;;;
;;;
;;;
;;;
;;;
;; common lisp
(require 'cl)

;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
	(dolist (path paths paths)
	  (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
		(add-to-list 'load-path default-directory)
		(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
			(normal-top-level-add-subdirs-to-load-path))))))

;; elispとconfディレクトリをサブディレクトリごとload-pathに追加
(add-to-load-path "elisp" "conf")

;; (defvar org-directory "")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;; GENERAL MODE SETTING
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
;; auto-install
;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; load environment variables
;;;
;; load environment variables
(exec-path-from-shell-initialize)
;; (let ((envs '("PATH" "GEM_PATH" "GEM_HOME" "VIRTUAL_ENV" "GOROOT" "GOPATH")))
;;   (exec-path-from-shell-copy-envs envs))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;; auto-install
;;;
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; sdic dictionary setting
;;;
(load "init-sdic")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; anything
;;;
;; (load "init-anything")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; helm
;;;
(load "init-helm")
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)
     ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; recentf-ext
;;;
(require 'recentf-ext)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; auto-save-buffers
;;;
;; (require 'auto-save-buffers)
;; (run-with-idle-timer 0.5 t 'auto-save-buffers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; multi-term Emacsから本格的にシェルを使う
;;; (install-elisp "http://www.emacswiki.org/emacs/download/multi-term.el")
;;;
;; (load "init-multi-term")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; git (Emacs Got Git)
;;;
;; (install-elisp "https://github.com/byplayer/egg/raw/master/egg.el")
(when (executable-find "git")
  (require 'egg nil t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; clmemo
;;;
(load "init-clmemo")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; dired
;;;
(load "init-dired")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; ibuffer
;;;
(load "init-ibuffer")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; ■ w3m
;;;
(load "init-w3m")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; abbrev
;;;
(quietly-read-abbrev-file)
(setq save-abbrevs t)
(setq abbrev-file-name "~/.abbrev_defs")
(define-key esc-map	 " " 'expand-abbrev) ;; M-SPC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; lookup
;;;
(load "init-lookup")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; text-adjust
;;;
;; (load "text-adjust")
;; (setq adaptive-fill-regexp "[ \t]*")
;; (setq adaptive-fill-mode t)
;; (setq text-adjust-touten-from nil)
;; (setq text-adjust-kuten-from nil)
(load "init-text-adjust")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; レジスタを一覧表示
;;;
(require 'list-register)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Brackets
;;;
(load "init-brackets")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; migemo ローマ字インクリメンタルサーチ
;;;
;; (auto-install-from-gist "457761")
(load "init-migemo")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; grep-edit
;;;
(load "init-grep-edit")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; elscreen
;;;
;; (load "init-elscreen")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; mew
;;;
;; (load "init-mew")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; wl
;;;
;; (load "init-wl")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; bbdb
;;;
;; (load "init-bbdb")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;; PROGRAMMING MODE SETTEING
;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;;
(load "init-lisp-mode")
(load "init-ruby-mode")
(load "init-javascript-mode")
(load "init-c-mode")
(load "init-c-sharp-mode")
(load "init-malabar-mode")
(load "init-perl-mode")
(load "init-other-programming-mode")
(load "init-coffee-mode")
(load "init-scss-mode")
(load "init-yaml-mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq navi2ch-board-enable-readcgi nil
;;		 navi2ch-board-use-subback-html nil)

;; ;;; ■ navi2ch
;; ;;;; □ 終了時に訪ねない
;; (setq navi2ch-ask-when-exit nil)
;; ;;;; □ スレのデフォルト名を使う
;; (setq navi2ch-message-user-name "")
;; ;;;; □ あぼーんがあったたき元のファイルは保存しない
;; (setq navi2ch-net-save-old-file-when-aborn nil)
;; ;;;; □ 送信時に訪ねない
;; (setq navi2ch-message-ask-before-send nil)
;; ;;;; □ kill するときに訪ねない
;; (setq navi2ch-message-ask-before-kill nil)
;; ;;;; □ バッファは 5 つまで
;; (setq navi2ch-article-max-buffers 5)
;; ;;;; □ navi2ch-article-max-buffers を超えたら古いバッファは消す
;; (setq navi2ch-article-auto-expunge t)
;; ;;;; □ Board モードのレス数欄にレスの増加数を表示する。
;; (setq navi2ch-board-insert-subject-with-diff t)
;; ;;;; □ Board モードのレス数欄にレスの未読数を表示する。
;; (setq navi2ch-board-insert-subject-with-unread t)
;; ;;;; □ 既読スレはすべて表示
;; (setq navi2ch-article-exist-message-range '(1 . 1000))
;; ;;;; □ 未読スレもすべて表示
;; (setq navi2ch-article-new-message-range '(1000 . 1))
;; ;;;; □ 3 ペインモードでみる
;; (setq navi2ch-list-stay-list-window t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; □ lsdb ( 現在は未使用 )
;; (require 'lsdb)
;;	 (lsdb-wl-insinuate)
;;	 (add-hook 'wl-draft-mode-hook
;;			   (lambda ()
;;				  (define-key wl-draft-mode-map "\M-\t" 'lsdb-complete-name)))
;;	 (add-hook 'wl-summary-mode-hook
;;			   (lambda ()
;;				 (define-key wl-summary-mode-map ":" 'lsdb-wl-toggle-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ■ mhc
(setq mhc-mailer-package 'wl)
(autoload 'mhc-mode "mhc" nil t)
(add-hook 'wl-summary-mode-hook 'mhc-mode)
(add-hook 'wl-folder-mode-hook 'mhc-mode)

(autoload 'mhc-wl-setup "mhc-wl")
(add-hook 'wl-init-hook 'mhc-wl-setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; color-moccur
;;;
;;; color-moccur: 検索結果をリストアップ
;; (install-elisp "http://www.emacswiki.org/emacs/download/color-moccur.el")
;; (install-elisp "http://www.emacswiki.org/emacs/download/moccur-edit.el")
(load "init-color-moccur")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; auto-save-buffers
;;;
;; (require 'auto-save-buffers)
;; (run-with-idle-timer 0.5 t 'auto-save-buffers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; gtags global
;;;
(load "init-gtags-mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; flymake-mode: 動的構文チェッカ
;;;
;; 要 flymake-jsl.el
;; http://d.hatena.ne.jp/kazu-yamamoto/20071029/1193651325
;; js-mode用のhookを用意
;; (when (executable-find "jsl")
;;	 (defun js-mode-hooks ()
;;	   ;; キーマップをセット
;;	   (setq flymake-jsl-mode-map 'js-mode-map)
;;	   ;; flymake-jslを起動するための設定
;;	   (when (require 'flymake-jsl nil t)
;;		 (setq flymake-check-was-interrupted t)
;;		 (flymake-mode t)))
;;	 ;; js-modeの起動時にhookを追加
;;	 (add-hook 'js-mode-hook 'js-mode-hooks))
;;;;  flymake for ruby
(load "init-flymake")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; flyspell-mode: 動的スペルチェッカ
;;;
;; スペルチェッカに aspell を使う
;; (when (executable-find "aspell")
;;	 (setq-default ispell-program-name "aspell"))
;;; ポップアップでスペル修正候補を表示する
;; 修正したい単語の上にカーソルをもっていき, C-c s を押すことで候補を選択
(load "init-flyspell")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; カーソル位置のファイルパスやアドレスを "C-x C-f" で開く
;;;
(ffap-bindings)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; cua-mode: 矩形編集を強力にする
;;;
;;;
;; リージョン選択中に C-RET で矩形編集に入る、C-g で終了
(require 'cua-mode nil t)
(cua-mode t)
(setq cua-enable-cua-keys nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; slime:
;;;
;; (load "init-slime")

;; (load "init-ac-mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; popwin:
;;;
;; (load "init-popwin")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; auto-install
;;;
;; (load "init-eshell")
;; (load "term+autoloads")
;; (load "init-term-plus")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; init-org-mode
;;;
(load "init-org-mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; twittering-mode
;;;
(load "init-twittering-mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; emms
;;;
;; (load "init-emms")


(define-key esc-map  "o" 'dabbrev-expand)
(define-key esc-map  " " 'expand-abbrev)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; SKK
;;;
(load "init-skk")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; yasnippet
;;;
(load "init-yasnippet")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; auto-complete 高機能補完+ポップアップメニュー
;;;
;; (load "init-auto-complete")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; slim
;;;
(require 'slim-mode)

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
(load "init-base")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-solarized-light)))
 '(custom-safe-themes (quote ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default)))
 '(emms-cache-file "~/.emacs.d/.emms-cache")
 '(emms-info-asynchronously nil)
 '(emms-info-functions (quote (emms-info-mpd)))
 '(emms-player-list (quote (emms-player-mpd)))
 '(emms-player-mpd-music-directory "/treasure/music")
 '(emms-playlist-buffer-name "*EMMS Playlist*")
 '(emms-playlist-default-major-mode (quote emms-playlist-mode))
 '(emms-playlist-mode-open-playlists t)
 '(emms-stream-default-action "play")
 '(emms-volume-change-function (quote emms-volume-mpd-change)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eshell-prompt-face ((t (:foreground "maroon2" :bold nil))) t)
 '(flymake-errline ((((class color)) (:background "firebrick"))))
 '(flymake-warnline ((((class color)) (:background "IndianRed"))))
 '(nxml-comment-content-face ((t (:foreground "yellow4"))) t)
 '(nxml-comment-delimiter-face ((t (:foreground "yellow4"))) t)
 '(nxml-delimited-data-face ((t (:foreground "lime green"))) t)
 '(nxml-delimiter-face ((t (:foreground "grey"))) t)
 '(nxml-element-local-name-face ((t (:foreground "yellow4"))) t)
 '(nxml-name-face ((t (:foreground "rosy brown"))) t)
 '(nxml-tag-slash-face ((t (:inherit nxml-name-face :foreground "grey"))) t))
