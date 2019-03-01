This package offers a fancy and fast mode-line which was from DOOM Emacs
(https://github.com/hlissner/doom-emacs/tree/master/modules/ui/doom-modeline),
but it's more powerful and much faster.
It's also integrated into Centaur Emacs (https://github.com/seagle0128/.emacs.d).

The doom-modeline was designed for minimalism, and offers:
- A match count panel (for anzu, iedit, multiple-cursors, symbol-overlay,
  evil-search and evil-substitute)
- An indicator for recording a macro
- Current environment version (e.g. python, ruby, go, etc.) in the major-mode
- A customizable mode-line height (see doom-modeline-height)
- A minor modes segment which is compatible with minions
- An error/warning count segment for flymake/flycheck
- A workspace number segment for eyebrowse
- A perspective name segment for persp-mode
- A window number segment for winum and window-numbering
- An indicator for evil state
- An indicator for god state
- An indicator for ryo-modal state
- An indicator for xah-fly-keys state
- An indicator for remote host
- An indicator for current input method
- An indicator for debug state
- An indicator for LSP state
- An indicator for github notifications
- An indicator for unread emails with mu4e-alert.
- An indicator for buffer position which is compatible with nyan-mode
- An indicator for party parrot
- An indicator for PDF page number
- Truncated file name, file icon, buffer state and project name in buffer
  information segment, which is compatible with projectile and project

Installation:
From melpa, `M-x package-install RET doom-modeline RET`.
In `init.el`,
(require 'doom-modeline)
(doom-modeline-mode 1)
or
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))
