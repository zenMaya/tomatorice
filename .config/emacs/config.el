(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)

(setq gc-cons-threshold 10000000)
(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold 1000000)
            (message "gc-cons-threshold restored to %S"
                     gc-cons-threshold)))

(defun find-config ()
  "Edit config.org"
  (interactive)
  (find-file "~/.config/emacs/config.org"))

(global-set-key (kbd "C-c I") 'find-config)

(global-visual-line-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)      ; y and n instead of yes and no everywhere else
(delete-selection-mode 1)
(global-hl-line-mode 0)

(setq
 inhibit-startup-message t         ; Don't show the startup message
 inhibit-startup-screen t          ; or screen
 cursor-in-non-selected-windows t  ; Hide the cursor in inactive windows

 echo-keystrokes 0.1               ; Show keystrokes right away, don't show the message in the scratch buffe
 initial-scratch-message nil       ; Empty scratch buffer
 initial-major-mode 'org-mode      ; org mode by default
 sentence-end-double-space nil     ; Sentences should end in one space, come on!
 confirm-kill-emacs 'y-or-n-p      ; y and n instead of yes and no when quitting with 'q'
)

(load-theme 'deeper-blue t)

(set-face-attribute 'default nil :font "Inconsolata 11")

(set-face-background 'show-paren-match "grey84")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

(setq column-number-mode t) ;; show columns in addition to rows in mode line
(set-face-attribute 'mode-line nil :background "NavajoWhite")
(set-face-attribute 'mode-line-inactive nil :background "#FAFAFA")

(use-package git-gutter
  :hook (prog-mode . git-gutter-mode))

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus)
        (t      . ivy--regex-fuzzy)))   ;; enable fuzzy searching everywhere except for Swiper

  (global-set-key (kbd "s-b") 'ivy-switch-buffer)
  ;; (global-set-key (kbd "M-s-b") 'ivy-resume)
  )

(use-package swiper
  :config
  ;; (global-set-key "\C-s" 'swiper)
  ;; (global-set-key "\C-r" 'swiper)
  (global-set-key (kbd "s-f") 'swiper))

(use-package counsel
  :config
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "s-y") 'counsel-yank-pop)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "s-p") 'counsel-git))

(use-package smex)
(use-package flx)
(use-package avy)

(setq-default indent-tabs-mode nil)
(setq tab-width 2)

(setq js-indent-level 2)
(setq css-indent-offset 2)
(setq-default c-basic-offset 2)
(setq c-basic-offset 2)
(setq-default tab-width 2)
(setq-default c-basic-indent 2)

(use-package company
  :config
  (setq company-idle-dalay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  (company-tng-configure-default)

  :hook (prog-mode . global-company-mode)
  :bind ( "C-<tab>" . company-complete))
(use-package company-lsp
  :commands company-lsp
  :config (push `company-lsp company-backends))

;; (use-package flycheck)

(use-package rust-mode)

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

;;  (use-package flycheck-rust
;;    :hook (rust-mode . flycheck-mode))

;;  (use-package racer
;;    :hook (rust-mode . racer-mode))

;;  (use-package company-racer)

(use-package ccls
  :after projectile
  :custom
  (ccls-args nil)
  (ccls-executable (executable-find "ccls"))
  (projectile-project-root-files-top-down-recurring
   (append '("compile_commands.json" ".ccls")
	   projectile-project-root-files-top-down-recurring))
  :config (push ".ccls-cache" projectile-globally-ignored-directories))

(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\.cmake\\'"))

(use-package cmake-font-lock
  :after (cmake-mode)
  :hook (cmake-mode . cmake-font-lock-activate))

(use-package cmake-ide
  :after projectile
  :hook (c++-mode . my/cmake-ide-find-project)
  :preface
  (defun my/cmake-ide-find-project ()
    "Finds the directory of the project for cmake-ide."
    (with-eval-after-load 'projectile
      (setq cmake-ide-project-dir (projectile-project-root))
      (setq cmake-ide-build-dir (concat cmake-ide-project-dir "build")))
    (setq cmake-ide-compile-command (concat "cd " cmake-ide-build-dir " && make"))
    (cmake-ide-load-db))

  (defun my/switch-to-compilation-window ()
    "Switches to the *compilation* buffer after compilation."
    (other-window 1))
  :bind ([remap comment-region] . cmake-ide-compile)
  :init (cmake-ide-setup)
  :config (advice-add 'cmake-ide-compile :after #'my/switch-to-compilation-window))

(use-package google-c-style
  :hook ((c-mode c++-mode) . google-set-c-style)
         (c-mode-common . google-make-newline-indent))

;; (use-package auctex)

;; (use-package company-auctex)

(setq ispell-program-name "enchant-2")
(add-hook 'text-mode-hook 'flyspell-mode)

;;-------------------------------------------------------------------------------
(use-package hydra)
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5))
(use-package move-text)
(use-package avy
  :bind ( "M-j" . avy-goto-word-or-subword-1))
;;-------------------------------------------------------------------------------
(use-package lsp-mode
  :hook (prog-mode . lsp)
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil)
  (setq lsp-enable-snippet t)
  (setq lsp-enable-indentation t))

(use-package lsp-ui
  :commands lsp-ui-mode)

;; Shift arrows to move between windows
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(load-file "~/.config/emacs/hydra-moving.el")


(global-set-key (kbd "s-q") 'delete-frame)

;;-------------------------------------------------------------------------------
;;THIS IS FOR C++/C

;;(use-package mu4e
;;  :ensure t
;;  :options
;;  (setq mail-user-agent 'mu4e-user-agent))
