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
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(use-package doom-themes
  :init (load-theme 'doom-one t)
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

(use-package all-the-icons)

(use-package git-gutter
  :hook (prog-mode . git-gutter-mode))

(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook (lambda ()
     (org-bullets-mode 1))))

(use-package flycheck)

(use-package rust-mode)

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(use-package flycheck-rust
  :hook (rust-mode . flycheck-mode))

(use-package racer
  :hook (rust-mode . racer-mode))

(use-package company-racer)

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

;;-------------------------------------------------------------------------------
(use-package hydra)
(use-package which-key :ensure t)
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
(use-package company-lsp :commands company-lsp)

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

;;------------------------------------------------------------------------------
(use-package helm
  :init (helm-mode 1)
  :config
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") #'helm-find-files))
;;-------------------------------------------------------------------------------
(use-package treemacs)
(use-package treemacs-projectile)
(use-package projectile)
(use-package fic-mode
  :hook (prog-mode . fic-mode))


;; Shift arrows to move between windows
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(load-file "~/.config/emacs/hydra-moving.el")




;;-------------------------------------------------------------------------------
;;THIS IS FOR C++/C

;;(use-package mu4e
;;  :ensure t
;;  :options
;;  (setq mail-user-agent 'mu4e-user-agent))
