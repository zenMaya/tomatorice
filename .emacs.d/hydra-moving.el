(global-set-key
 (kbd "C-n")
 (defhydra hydra-move
   (:body-pre (next-line))
   "move"
   ("n" next-line)
   ("p" previous-line)
   ("f" forward-char)
   ("b" backward-char)
   ("a" beginning-of-line)
   ("e" move-end-of-line)
   ("v" scroll-up-command)
   ;; Converting M-v to V here by analogy.
   ("V" scroll-down-command)
   ("l" recenter-top-bottom)))

(defhydra hydra-page (ctl-x-map "" :pre (widen))
  "page"
  ("]" forward-page "next")
  ("[" backward-page "prev")
  ("n" narrow-to-page "narrow" :bind nil :exit t))

(defhydra hydra-move-text ()
  "Move text"
  ("u" move-text-up "up")
  ("d" move-text-down "down"))
