;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; よく忘れることのメモ
;; --------------------------------------------------------------------------------
;; Lynx-like キーマップのまま
;; タブ作成 C-c C-t
;; 次のタブに移動 C-c C-n
;; 前のタブに移動 C-c C-p
;; 現在のタブを削除 C-c C-w
;; 現在のバッファにあるすべてのインライン画像の表示をトグルで切り替え T
;; 戻る B
;; 更新 R
;; ブックマークへ追加 a
;; ブックマーク閲覧   v
;; --------------------------------------------------------------------------------
;; HOME を google に設定
(setq w3m-home-page "http://www.google.co.jp")

;; 検索をGoogle(日本語サイト)でおこなう
(setq w3m-search-default-engine "google")

;; (add-hook 'w3m-fontify-after-hook 'cc-w3m-del-trailing-ws)
;; 魔法のクッキーを ON にする。
(setq w3m-use-cookies t)
(setq w3m-cookie-accept-bad-cookies t)

;; もちろんタブ機能を有効にする。
(setq w3m-use-tab t)

;; 明日の天気
;; (setq w3m-weather-default-area "東京都・東京")
;; dired で 'w' を実行すると、htmlファイルを閲覧できるように。
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "w" 'dired-w3m-find-file)))
(defun dired-w3m-find-file ()
  (interactive)
  (require 'w3m)
  (let ((file (dired-get-filename)))
    (w3m-find-file file)))

(setq w3m-accept-japanese-characters t)

; w3m でhtmlメールを表示
;; (require 'mime-w3m)

(setq w3m-fill-column -5)
