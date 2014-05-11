;;; -*- coding: utf-8 -*-;; If first time what use the mew,;; perhaps you should update state that type by C-u Z

(eval-when-compile (require 'cl))
(require 'mew)
(require 'notifications nil t)

(defvar my/mew-gmail-prefixes '()
  "Specify list as title and address without @gmail.com.Note: the default title can't changedFor example'((\"default\" \"foo\") ; if your mail address is 'foo@gmail.com'  (\"sub\"     \"bar\")  (\"temp\"    \"baz\"))")

(defconst my/mew-gmail-prefixes  '(("default" "njsekay")
                                   ("njunichiro" "njunichiro")
                                   ("jhysteric"  "jhysteric")))

(defun my/biff-function (n)
  (when (< 0 n)
    (if (version< "24.0.0" emacs-version)
        (notifications-notify :title "Emacs/Mew"
                              :body  (format "You got mail(s): %i" n)
                              :timeout 5000)
      (mew-biff-bark n))))

(defun mew-spam-assassin-or-bsfilter (val)
  (let ((case-fold-search t))
    (if (string-match "yes" val) ?D)))

(defun my/generate-mew/gmail-alist-from (mail-prefix)
  (let ((inbox-name (concat "+inbox-" mail-prefix))
        (address (concat mail-prefix "@gmail.com")))
    (loop for property in '("user" "imap-user" "smtp-user")
          for alist = `(,(cons "inbox-folder" inbox-name)) then alist
          collect (cons property mail-prefix) into alist
          finally return alist)))

(setq mew-ssl-verify-level 0
      ;; Does not bring mail automatically at booting time
      mew-auto-get nil
      ;; Leave mail of pop server after get mail
      mew-pop-delete nil
      ;; Add extension ".mew"
      mew-use-suffix t
      ;; Manage unread topic
      mew-use-unread-mark t
      ;; Spam configuration
      mew-spam: "X-Spam-Flag:"      mew-inbox-action-alist '(("X-Spam-Flag:" mew-spam-assassin-or-bsfilter))
      ;; Register password briefly
      mew-use-cached-passwd t
      ;; Does not bring mail at booting time
      mew-auto-get nil
      ;; For Biff
      mew-use-biff t
      mew-use-biff-bell t  ; use alarm
      mew-biff-interval 10 ; minute
      mew-biff-function 'my/biff-function)

(defvar mew/gmail-default-alist  `(("proto"             . "%")
                                   ("name"              . ,(user-full-name))
                                   ("mail-domain"       . "gmail.com")
                                   ("imap-trash-folder" . "%Trash")
                                   ("imap-spam-folder"  . "%SPAM")
                                   ("fcc"               . "%Sent")
                                   ("imap-server"       . "imap.gmail.com")
                                   ("imap-auth"         . t)
                                   ("imap-ssl"          . t)
                                   ("imap-ssl-port"     . "993")
                                   ("smtp-auth"         . t)
                                   ("smtp-ssl"          . t)
                                   ("smtp-ssl-port"     . "465")
                                   ("smtp-server"       . "smtp.gmail.com")
                                   ("use-smtp-auth"     . t)))
(defun my/mew-create-alist (list)
  (loop with alist = '()
        for (title account) in list
        collect `(,title
                  ,@mew/gmail-default-alist
                  ,@(my/generate-mew/gmail-alist-from account))));; Switch to account by types "C" and renew summary by types "i"

(setq mew-config-alist
      (my/mew-create-alist
       my/mew-gmail-prefixes))
