;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(require 'text-adjust)
(defun text-adjust-space-before-save-if-needed ()
  (when (memq major-mode
              '(org-mode text-mode mew-draft-mode myhatena-mode))
    (text-adjust-space-buffer)))
(defalias 'spacer 'text-adjust-space-buffer)
(add-hook 'before-save-hook 'text-adjust-space-before-save-if-needed)