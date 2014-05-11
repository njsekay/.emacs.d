;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(require 'bbdb-wl)
(bbdb-wl-setup)
(add-hook 'wl-mail-setup-hook 'bbdb-insinuate-sendmail)

(require 'bbdb)
(autoload 'bbdb         "bbdb-com" "Insidious Big Brother Database" t)
(autoload 'bbdb-name    "bbdb-com" "Insidious Big Brother Database" t)
(autoload 'bbdb-company "bbdb-com" "Insidious Big Brother Database" t)
(autoload 'bbdb-net     "bbdb-com" "Insidious Big Brother Database" t)
(autoload 'bbdb-notes   "bbdb-com" "Insidious Big Brother Database" t)
(autoload 'bbdb-insinuate-vm       "bbdb-vm"    "Hook BBDB into VM")
(autoload 'bbdb-insinuate-rmail    "bbdb-rmail" "Hook BBDB into RMAIL")
(autoload 'bbdb-insinuate-mh       "bbdb-mhe"   "Hook BBDB into MH-E")
(autoload 'bbdb-insinuate-gnus     "bbdb-gnus"  "Hook BBDB into GNUS")
(autoload 'bbdb-insinuate-sendmail "bbdb"       "Hook BBDB into sendmail")

(bbdb-initialize)
(setq bbdb-file "~/.emacs.d/data/.bbdb") ;(concat TT:mule-save-dir "~/.bbdb")
(setq bbdb/mail-auto-create-p   'bbdb-ignore-some-messages-hook)
(setq bbdb-ignore-some-messages-alist
      '(("From" .       "MAILER-DAEMON\\|iso-2022-jp\\|ISO-2022-JP")))
(setq bbdb-pop-up-elided-display        '(creation-date timestamp))
(setq bbdb-user-mail-names      "kokada@tamaru\\.kuee\\.kyoto-u\\.ac\\.jp")

;; BBDB windowの高さ
(setq bbdb-pop-up-target-lines 10)
;; ポップアップ表示
(setq bbdb-use-pop-up t)
(setq signature-use-bbdb t)
(setq bbdb-north-american-phone-numbers-p nil)
;; サマリに bbdb の名前を表示 :-)。
;(setq wl-summary-from-func 'bbdb-wl-from-func)
;; 自動的に ML フィールドを加える
(add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook)
;; wl-folder-suspendしたときにBBDBフィールドを消す
(defadvice wl-folder-suspend (after wl-bbdb-suspend activate compile)
  (interactive)
(bbdb-wl-exit))
(defadvice wl-exit (after wl-bbdb-suspend activate compile)
  (interactive)
(bbdb-wl-exit))
;; X-Faceを表示する
;; (require 'highlight-headers)

;; (setq bbdb-auto-notes-alist 
;;       '(
;; 	("X-ML-Name" (".*" ML 0))
;;  	("X-Mailer" (".*$" User-Agent 0))
;;  	("X-Newsreader" (".*$" User-Agent 0))
;;  	("User-Agent" (".*$" User-Agent 0))
;; 			      ))
;; (setq bbdb-auto-notes-alist
;;       (append bbdb-auto-notes-alist (list
;;               (list "X-Face"
;;                     (list (concat "[ \t\n]*\\([^ \t\n]*\\)"
;;                                   "\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
;;                                   "\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
;;                                   "\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
;;                                   "\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
;;                                   )
;;                           'face
;;                           "\\1\\3\\5\\7\\9")))))











(defun wl-draft-turn-on-ac ()
  (setq ac-sources '(ac-source-bbdb))
  (auto-complete-mode 1))

(add-hook 'wl-draft-mode-hook 'wl-draft-turn-on-ac)

(defvar ac-bbdb-header-list '("to" "from" "cc" "bcc"))

(defun ac-bbdb-candidate ()
  (delete-dups
   (apply
    'append
    (mapcar (lambda (rec)
              (mapcar (lambda (n) (bbdb-dwim-net-address rec n))
                      (bbdb-record-net rec)))
            (bbdb-records)))))

(defun ac-bbdb-prefix ()
  (interactive)
  (let ((case-fold-search t))
    (when (and
           (< (point)
              (save-excursion
                (goto-char (point-min))
                (search-forward (concat "\n" mail-header-separator "\n") nil t)
                (point)))
           (save-excursion
             (beginning-of-line)
             (while (and (looking-at "^[ \t]")
                         (not (= (point) (point-min))))
               (forward-line -1))
             (looking-at (concat (regexp-opt ac-bbdb-header-list t) ":"))))
      (ac-prefix-symbol))))

(defvar ac-source-bbdb
  '((candidates . ac-bbdb-candidate)
    (match . substring)
    (prefix . ac-bbdb-prefix)))