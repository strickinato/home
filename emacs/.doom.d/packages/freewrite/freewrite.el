(require 'posframe)

(defvar freewrite/countdown-timer nil
  "Timer object for the countdown posframe.")

(defvar freewrite/countdown-seconds-left 0
  "Seconds remaining in the countdown.")

(defun freewrite/poshandler-frame-top-right (_info)
  "Place the posframe at top-right, assuming it is 100px wide."
  (let* ((frame  (selected-frame))
         (fw     (frame-pixel-width frame))
         (pfw    100)        ;; assume child frame is 100px wide
         (margin 8))
    (cons (- fw pfw margin)  ;; X = frame-width − pfw − margin
          margin)))          ;; Y = margin from top

(defun freewrite/countdown--update-posframe ()
  "Update the countdown posframe each second; hide it at zero."
  (if (<= freewrite/countdown-seconds-left 0)
      (freewrite/countdown-shutdown)
    (posframe-show
     " *freewrite-countdown*"
     :string               (format "⏳ %2d s left" freewrite/countdown-seconds-left)
     :poshandler           #'freewrite/poshandler-frame-top-right
     :background-color     "#222"
     :foreground-color     "#fafafa"
     :internal-border-width 6
     :border-width         1
     :border-color         "#666"
     :accept-focus         nil)
    (cl-decf freewrite/countdown-seconds-left)))

(defun freewrite/countdown-shutdown ()
    ;; TODO this should happen automatically, but for now have it callable
    (interactive)
    (progn
        (when freewrite/countdown-timer
          (cancel-timer freewrite/countdown-timer)
          (setq freewrite/countdown-timer nil))
        (posframe-hide " *freewrite-countdown*")))

(defun freewrite/start-countdown (seconds)
  "Start a SECONDS-long countdown shown in a top-right posframe."
  (interactive "nCountdown seconds: ")
  (when freewrite/countdown-timer
    (cancel-timer freewrite/countdown-timer))
  (setq freewrite/countdown-seconds-left (max 0 seconds))
  (setq freewrite/countdown-timer
        (run-at-time 0 1 #'freewrite/countdown--update-posframe)))

(defvar freewrite/freewrite-prompts
  '("What's infiltrated your mind lately?"
    "What's something funny Sunny did recently?"
    "What's something funny Dino did recently?"
    "What's something good about Lucy?"
    "Start listing things you're grateful for"
    ))

(defun freewrite/get-random-prompt ()
  "Return a random prompt from `freewrite/freewrite-prompts'."
  (nth (random (length freewrite/freewrite-prompts)) freewrite/freewrite-prompts))

(defun freewrite/freewrite ()
  "Create a new freewrite entry with a random prompt and open it in fullscreen writing mode."
  (interactive)
  (let* ((directory "~/brain/freewrite")
         (file-path (expand-file-name (format "freewrite-%s.md" (format-time-string "%Y-%m-%d-%H%M%S")) directory))
         (prompt (freewrite/get-random-prompt)))
    (unless (file-exists-p directory)
      (make-directory directory t))
    (with-temp-file file-path
      (insert (format "---\ntitle: Freewrite - %s\nprompt: %s\n---\n\n"
                      (format-time-string "%Y-%m-%d")
                      prompt)))
    (find-file file-path)
    (goto-char (point-max))
    (delete-other-windows)
    (when (boundp 'display-line-numbers-mode)
      (display-line-numbers-mode -1))
    (+zen/toggle)
    (freewrite/start-countdown 300)
    (add-hook 'kill-buffer-hook #'freewrite/countdown-shutdown nil t)))

;; TODO
;; When I close the file - I want the countdown timer to go away
;; I also want to cancel the freewrite and have it not save
;; I want to open the freewrite directory in a search buffer, or dired, or something like that

;; (posframe-delete " *freewrite-countdown*")
;; (posframe-delete-all)
(provide 'freewrite)
