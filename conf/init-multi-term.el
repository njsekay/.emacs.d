;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(when (require 'multi-term nil t)
  (setq multi-term-program "/usr/bin/zsh"))

(global-set-key (kbd "C-c t") 'multi-term)
;; (global-set-key (kbd "C-c c") '(lambda ()
;;                                 (interactive)
;;                                 (multi-term)))

(setq multi-term-program shell-file-name
      ansi-term-color-vector [unspecified
                              "black" "red3" "green3" "yellow3"
                              "DeepSkyBlue" "magenta1" "cyan3" "white"])

;; my-keybinds for keybinds -e
(defun term-send-forward-char ()
  (interactive)
  (term-send-raw-string "\C-f"))

(defun term-send-backward-char ()
  (interactive)
  (term-send-raw-string "\C-b"))

(defun term-send-previous-line ()
  (interactive)
  (term-send-raw-string "\C-p"))

(defun term-send-next-line ()
  (interactive)
  (term-send-raw-string "\C-n"))

(add-hook 'term-mode-hook
          '(lambda ()
             (let* ((key-and-func
                     `(("\C-p"           term-send-previous-line)
                       ("\C-n"           term-send-next-line)
                       ("\C-b"           term-send-backward-char)
                       ("\C-f"           term-send-forward-char)
                       (,(kbd "C-h")     term-send-backspace)
                       (,(kbd "C-y")     term-paste)
                       (,(kbd "ESC ESC") term-send-raw)
                       (,(kbd "C-S-p")   multi-term-prev)
                       (,(kbd "C-S-n")   multi-term-next)
                       ;; 利用する場合は
                       ;; helm-shell-historyの記事を参照してください
                       ;; ("\C-r"           helm-shell-history)
                       )))
               (loop for (keybind function) in key-and-func do
                     (define-key term-raw-map keybind function)))))


;; (set-language-environment  'utf-8)
;; (prefer-coding-system 'utf-8)
;; (setq file-name-coding-system 'utf-8)
;; (setq locale-coding-system 'utf-8)
