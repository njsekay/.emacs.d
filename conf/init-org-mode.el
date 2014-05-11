;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(require 'org-capture)
(defun org-capture-demo ()
  (interactive)
  (let ((file "/tmp/org-capture.org")
        org-capture-templates)
    (find-file-other-window file)
    (unless (save-excursion
              (goto-char 1)
              (search-forward "* test\n" nil t))
      (insert "* test\n** entry\n"))
    (other-window 1)
    (setq org-capture-templates
          `(("a" "ふつうのエントリー後に追加" entry
             (file+headline ,file "entry")
             "* %?\n%U\n%a\n")
            ("b" "ふつうのエントリー前に追加" entry
             (file+headline ,file "entry")
             "* %?\n%U\n%a\n" :prepend t)
            ("c" "即座に書き込み" entry
             (file+headline ,file "entry")
             "* immediate-finish\n" :immediate-finish t)
            ("d" "ナローイングしない" entry
             (file+headline ,file "entry")
             "* 全体を見る\n\n" :unnarrowed t)
            ("e" "クロック中のエントリに追加" entry (clock)
             "* clocking" :unnarrowed t)
            ("f" "リスト" item
             (file+headline ,file "list")
             "- リスト")
            ;; うまく動かない
            ("g" "チェックリスト" checkitem
             (file+headline ,file "list")
             "チェックリスト")
            ("h" "表の行" table-line
             (file+headline ,file "table")
             "|表|")
            ("i" "そのまま" plain
             (file+headline ,file "plain")
             "あいうえお")
            ("j" "ノードをフルパス指定して挿入" entry
             (file+olp ,file "test" "entry")
             "* %?\n%U\n%a\n")
            ;; これもうまく動かない
            ("k" "ノードを正規表現指定して挿入" entry
             (file+regexp ,file "list")
             "* %?\n%U\n%a\n")
            ;; 年月日エントリは追記される
            ("l" "年/月/日のエントリを作成する1" entry
             (file+datetree ,file))
            ("m" "年/月/日のエントリを作成する2" item
             (file+datetree ,file))
            ("o" "年/月/日のエントリを作成する prepend" entry
             (file+datetree ,file) "* a" :prepend t)))
    (org-capture)))
(global-set-key "\C-x\C-z" 'org-capture-demo)




;; (save-window-excursion (shell-command (format "emacs-test -l test-minimum -l %s %s &" buffer-file-name buffer-file-name)))
(require 'org-install)
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-directory "~/memo/")
(setq org-default-notes-file (concat org-directory "agenda.org"))
(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline nil "Inbox")
         "** TODO %?\n   %i\n   %a\n   %t")
        ("b" "Bug" entry
         (file+headline nil "Inbox")
         "** TODO %?   :bug:\n   %i\n   %a\n   %t")
        ("i" "Idea" entry
         (file+headline nil "New Ideas")
         "** %?\n   %i\n   %a\n   %t")))
(global-set-key (kbd "C-c c") 'org-capture)


(defvar org-code-reading-software-name nil)
;; ~/memo/code-reading.org に記録する
(defvar org-code-reading-file "code-reading.org")
(defun org-code-reading-read-software-name ()
  (set (make-local-variable 'org-code-reading-software-name)
       (read-string "Code Reading Software: " 
                    (or org-code-reading-software-name
                        (file-name-nondirectory
                         (buffer-file-name))))))

(defun org-code-reading-get-prefix (lang)
  (concat "[" lang "]"
          "[" (org-code-reading-read-software-name) "]"))
(defun org-remember-code-reading ()
  (interactive)
  (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
         (org-remember-templates
          `(("CodeReading" ?r "** %(identity prefix)%?\n   \n   %a\n   %t"
             ,org-code-reading-file "Memo"))))
    (org-remember)))


(defun org-next-visible-link ()
  "Move forward to the next link.
If the link is in hidden text, expose it."
  (interactive)
  (when (and org-link-search-failed (eq this-command last-command))
    (goto-char (point-min))
    (message "Link search wrapped back to beginning of buffer"))
  (setq org-link-search-failed nil)
  (let* ((pos (point))
	 (ct (org-context))
	 (a (assoc :link ct))
         srch)
    (if a (goto-char (nth 2 a)))
    (while (and (setq srch (re-search-forward org-any-link-re nil t))
                (goto-char (match-beginning 0))
                (prog1 (not (eq (org-invisible-p) 'org-link))
                  (goto-char (match-end 0)))))
    (if srch
        (goto-char (match-beginning 0))
      (goto-char pos)
      (setq org-link-search-failed t)
      (error "No further link found"))))

(defun org-previous-visible-link ()
  "Move backward to the previous link.
If the link is in hidden text, expose it."
  (interactive)
  (when (and org-link-search-failed (eq this-command last-command))
    (goto-char (point-max))
    (message "Link search wrapped back to end of buffer"))
  (setq org-link-search-failed nil)
  (let* ((pos (point))
	 (ct (org-context))
	 (a (assoc :link ct))
         srch)
    (if a (goto-char (nth 1 a)))
    (while (and (setq srch (re-search-backward org-any-link-re nil t))
                (goto-char (match-beginning 0))
                (not (eq (org-invisible-p) 'org-link))))
    (if srch
        (goto-char (match-beginning 0))
      (goto-char pos)
      (setq org-link-search-failed t)
      (error "No further link found"))))
(define-key org-mode-map "\M-n" 'org-next-visible-link)
(define-key org-mode-map "\M-p" 'org-previous-visible-link)

