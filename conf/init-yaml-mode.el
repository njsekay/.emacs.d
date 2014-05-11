(defun yaml-custom ()
  (setq indent-tabs-mode nil)
  (setq yaml-indent-offset 2)
  )

(add-hook 'yaml-mode-hook
  '(lambda() (yaml-custom)))
