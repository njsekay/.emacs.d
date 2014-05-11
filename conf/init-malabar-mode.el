;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;; *** Malabar Mode : A better Java mode
(when (require 'malabar-mode nil t)
  ;; (setq malabar-groovy-lib-dir (expand-file-name "~/lib/elisp/malabar-1.3-SNAPSHOT/lib")) ; お好みで
  (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))
  ;; 普段使わないパッケージを import 候補から除外
  (add-to-list 'malabar-import-excluded-classes-regexp-list
               "^java\\.awt\\..*$")
  (add-to-list 'malabar-import-excluded-classes-regexp-list
               "^com\\.sun\\..*$")
  (add-to-list 'malabar-import-excluded-classes-regexp-list
               "^org\\.omg\\..*$")
  (add-hook 'malabar-mode-hook
            (lambda ()
              (add-hook 'after-save-hook 'malabar-compile-file-silently
                        nil t))))

;;; **** Malabar Groovy : Customization of malabar-mode's inferior Groovy.
(setq malabar-groovy-java-options '("-Duser.language=en")) ; 日本語だとコンパイルエラーメッセージが化けるので
