;;; emms-init.el --- Initialize emms

;;; Setup

;; (add-to-list 'load-path "~/elisp/emms")

;; Initialize
(require 'emms)
(require 'emms-info)
(require 'emms-player-mpd)
(require 'emms-playing-time)
(require 'emms-playlist-mode)
(require 'emms-streams)
(require 'emms-volume)

(emms-playing-time 1)

;; The name of emms-playlist-mode is *way* too long
(add-hook 'emms-playlist-mode-hook
          #'(lambda ()
              (setq mode-name "EMMS")))

;;; Utilities

(defun my-start-mpd ()
  "Start MPD and sync to its playlist."
  (interactive)
  ;; (shell-command "mpd ~/.mpd/mpd.conf")
  (shell-command "mpd")
  (emms-player-mpd-connect)
  (switch-to-buffer emms-playlist-buffer))

(defun my-stop-mpd ()
  "Stop MPD."
  (interactive)
  ;; (shell-command "mpd --kill ~/.mpd/mpd.conf")
  (shell-command "mpd --kill")
  (emms-playlist-current-kill)
  (emms-player-mpd-disconnect))

;; Switch to the radio buffer
(defun my-emms-streams ()
  (interactive)
  (let ((buf (get-buffer emms-stream-buffer-name)))
    (if buf
        (switch-to-buffer buf)
      (emms-streams))))

;; Switch to either the radio buffer or the current EMMS playlist
(defun my-emms-switch-to-current-playlist ()
  (interactive)
  (if (and (boundp 'emms-stream-playlist-buffer)
           (eq emms-stream-playlist-buffer emms-playlist-buffer))
      (switch-to-buffer emms-stream-buffer-name)
    (if (or (null emms-playlist-buffer)
            (not (buffer-live-p emms-playlist-buffer)))
        (error "No current Emms buffer")
      (switch-to-buffer emms-playlist-buffer))))

;;; Key customizations

(define-key emms-playlist-mode-map "q" 'emms-playlist-current-kill)
(define-key emms-playlist-mode-map (kbd "SPC") 'emms-pause)
;; this is the "O" button on the gamepad
(define-key emms-playlist-mode-map (kbd "<prior>") 'emms-player-mpd-previous)
;; this is the "X" button on the gamepad
(define-key emms-playlist-mode-map (kbd "<next>") 'emms-player-mpd-next)

;; this is the largest dot on the top row, in the middle section
(global-set-key (kbd "<f8>") 'my-start-mpd)
;; this is the smallest dot on the top row, in the middle section
(global-set-key (kbd "<f5>") 'my-stop-mpd)
;; this is the check-mark button on the gamepad
(global-set-key (kbd "<select>") 'emms-pause)

(global-set-key "\C-cm" nil)
(global-set-key "\C-cm " 'emms-pause)
(global-set-key "\C-cm0" 'emms-playlist-current-clear)
(global-set-key "\C-cmc" 'emms-player-mpd-connect)
(global-set-key "\C-cmn" 'emms-player-mpd-next)
(global-set-key "\C-cmo" 'my-emms-switch-to-current-playlist)
(global-set-key "\C-cmp" 'emms-player-mpd-previous)
(global-set-key "\C-cmq" 'emms-stop)
(global-set-key "\C-cmQ" #'(lambda () (interactive) (emms-player-mpd-clear)))
(global-set-key "\C-cmr" 'my-emms-streams)
(global-set-key "\C-cms" 'emms-seek)
(global-set-key "\C-cm-" 'emms-volume-mode-minus)
(global-set-key "\C-cm+" 'emms-volume-mode-plus)
(global-set-key "\C-cm\C-c" 'my-emms-reset-cache)

(define-key emms-playlist-mode-map (kbd "SPC") 'emms-pause)
(define-key emms-playlist-mode-map (kbd "+") 'emms-volume-raise)
(define-key emms-playlist-mode-map (kbd "-") 'emms-volume-lower)
;; (define-key emms-playlist-mode-map (kbd "<right>") (lambda () (interactive) (emms-seek +10)))
;; (define-key emms-playlist-mode-map (kbd "<left>") (lambda () (interactive) (emms-seek -10)))
;; (define-key emms-playlist-mode-map (kbd "<up>") (lambda () (interactive) (emms-seek +60)))
;; (define-key emms-playlist-mode-map (kbd "<down>") (lambda () (interactive) (emms-seek -60)))
;; (define-key emms-playlist-mode-map (kbd "S u") 'emms-score-up-file-on-line)
;; (define-key emms-playlist-mode-map (kbd "S d") 'emms-score-down-file-on-line)
;; (define-key emms-playlist-mode-map (kbd "S o") 'emms-score-show-file-on-line)
;; (define-key emms-playlist-mode-map (kbd "S l") 'emms-score-less-tolerant)
;; (define-key emms-playlist-mode-map (kbd "S m") 'emms-score-more-tolerant)
;; (define-key emms-playlist-mode-map (kbd "S t") 'emms-score-set-tolerance)
(define-key emms-playlist-mode-map (kbd "i") 'emms-score-show-playing)
(define-key emms-playlist-mode-map (kbd "f") 'emms-playlist-limit-to-info-artist)
(define-key emms-playlist-mode-map (kbd "a") 'emms-playlist-limit-to-all)
;; (define-key emms-playlist-mode-map (kbd "<F3>") 'my-emms-play-default)
;; (define-key emms-playlist-mode-map (kbd "<F4>") 'emms-play-directory)
(define-key emms-playlist-mode-map (kbd "R") 'de-add-dir)
;; (define-key emms-playlist-mode-map (kbd "<F6>") 'emms-play-directory-tree)
;; (define-key emms-playlist-mode-map (kbd "<F7>") 'emms-previous)
;; (define-key emms-playlist-mode-map (kbd "<F8>") 'emms-next)
;; (define-key emms-playlist-mode-map (kbd "<F9>") 'my-emms-google-for-lyrics)
(define-key emms-playlist-mode-map (kbd "n") 'emms-next)
(define-key emms-playlist-mode-map (kbd "p") 'emms-previous)
(define-key emms-playlist-mode-map (kbd "S h") 'emms-shuffle)
(define-key emms-playlist-mode-map (kbd "S s") 'emms-playlist-sort-by-info-artist)

;;; Custom variables

(custom-set-variables
 '(emms-cache-file "~/.emacs.d/.emms-cache")
 '(emms-info-asynchronously nil)
 '(emms-info-functions (quote (emms-info-mpd)))
 '(emms-player-list (quote (emms-player-mpd)))
 '(emms-player-mpd-music-directory "/treasure/music")
 '(emms-playlist-buffer-name "*EMMS Playlist*")
 '(emms-playlist-default-major-mode (quote emms-playlist-mode))
 '(emms-playlist-mode-open-playlists t)
 '(emms-stream-default-action "play")
 '(emms-volume-change-function (quote emms-volume-mpd-change)))
(custom-set-faces)

;;; Initialization

(define-emms-combined-source all nil
  '((emms-source-directory "/treasure/music")))

;; Type M-x emms-add-all to add all music in your /treasure/music directory.

;;; emms-init.el ends here
