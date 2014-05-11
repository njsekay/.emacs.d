;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-


;;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
;;;; dired を使って、一気にファイルの coding system (漢字) を変換する
(require 'dired-aux)
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key (current-local-map) "T"
              'dired-do-convert-coding-system)))

(defvar dired-default-file-coding-system nil
  "*Default coding system for converting file (s).")

(defvar dired-file-coding-system 'no-conversion)

(defun dired-convert-coding-system ()
  (let ((file (dired-get-filename))
        (coding-system-for-write dired-file-coding-system)
        failure)
    (condition-case err
        (with-temp-buffer
          (insert-file file)
          (write-region (point-min) (point-max) file))
      (error (setq failure err)))
    (if (not failure)
        nil
      (dired-log "convert coding system error for %s:\n%s\n" file failure)
      (dired-make-relative file))))

(defun dired-do-convert-coding-system (coding-system &optional arg)
  "Convert file (s) in specified coding system."
  (interactive
   (list (let ((default (or dired-default-file-coding-system
                            buffer-file-coding-system)))
           (read-coding-system
            (format "Coding system for converting file (s) (default, %s): "
                    default)
            default))
         current-prefix-arg))
  (check-coding-system coding-system)
  (setq dired-file-coding-system coding-system)
  (dired-map-over-marks-check
   (function dired-convert-coding-system) arg 'convert-coding-system t))
;; ディレクトリを移動してもバッファを作成しないようにする
(defvar my-dired-before-buffer nil)
(defadvice dired-advertised-find-file
  (before kill-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))

(defadvice dired-advertised-find-file
  (after kill-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))

(defadvice dired-up-directory
  (before kill-up-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))

(defadvice dired-up-directory
  (after kill-up-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))

(setq ls-lisp-dirs-first t)

(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)


;;;;;一応標準でtar.gz、拡張子が指定されればtar.bz2にも反応するようになってる。もっと拡張したければ、condのところをstring-matchで適当にやってくれ
;;;;;複数ファイルの解凍は非同期実行だとなんかおかしくなるので、同期実行にしている。
;;;;;マークしたエントリ（マークがなければポイントしているエントリ）を圧縮解凍する
;;;;圧縮
(defun dired-do-tar-comp (file-name)
  (interactive "F Compressed file name is: ")
  (let ((files (dired-get-marked-files t current-prefix-arg))
        (arg (cond ((string-match ".*\.tar\.bz2$" file-name) "jcvf")
                   (t "zcvf"))))
    (dired-do-shell-command 
     (concat "tar " arg " " file-name " * &") nil files)))

;;;;解凍
(defun dired-do-tar-decomp ()
  (interactive)
  (let ((files (dired-get-marked-files t current-prefix-arg)))
    (mapcar (lambda (e)
              (let ((arg (cond ((string-match ".*\.tar.bz2$" e) "jxvf")
                               (t "zxvf"))))
                (dired-do-shell-command (concat "tar " arg " *") nil (list e)))) files)))


(define-key dired-mode-map "t" 'dired-do-tar-comp)
(define-key dired-mode-map "z" 'dired-do-tar-decomp)


(require 'dired-toggle-sudo)
(define-key dired-mode-map (kbd "C-c C-s") 'dired-toggle-sudo)
(eval-after-load 'tramp
 '(progn
    ;; Allow to use: /sudo:user@host:/path/to/file
    (add-to-list 'tramp-default-proxies-alist
		  '(".*" "\\`.+\\'" "/ssh:%h:"))))

