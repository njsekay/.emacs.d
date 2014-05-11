(setq eshell-cmpl-ignore-case t)
(setq eshell-ask-to-save-history (quote always))
(setq eshell-cmpl-cycle-completions t)
(setq eshell-cmpl-cycle-cutoff-length 5)
(setq eshell-hist-ignoredups t)

(defadvice eshell (around eshell-around)
  (let ((system-time-locale "English"))
    ad-do-it))

;; prompt
(setq eshell-prompt-function
      (lambda ()
        (concat
         "[" (format-time-string "%Y/%m/%d(%a) %H:%M") "]"
          "["
         (user-login-name) "@" (system-name) " "
         (eshell/pwd)
         "]\n"
         (if (= (user-uid) 0)
             "#"
           "$")
         " "
         )))

(setq eshell-prompt-regexp "^[^#$]*[$#] ")

(add-hook 'eshell-mode-hook
          '(lambda ()
             (progn
               (define-key eshell-mode-map "\C-a" 'eshell-bol)
               (define-key eshell-mode-map "\C-p" 'eshell-previous-matching-input-from-input)
               (define-key eshell-mode-map "\C-n" 'eshell-next-matching-input-from-input)
               )
             ))

(require 'pcomplete)
(add-to-list 'ac-modes 'eshell-mode)
(ac-define-source pcomplete
  '((candidates . pcomplete-completions)))

(defun my-ac-eshell-mode ()
  (setq ac-sources
        '(ac-source-pcomplete
          ac-source-words-in-buffer
          ac-source-dictionary)))

(add-hook 'eshell-mode-hook
          (lambda ()
            (my-ac-eshell-mode)
            (define-key eshell-mode-map (kbd "C-i") 'auto-complete)))

(custom-set-faces
    '(eshell-prompt-face ((t (:foreground "maroon2" :bold nil)))))
