(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(eval-when-compile (require 'use-package))
;;-------------------------------------------------------------------------------
(use-package doom-themes
  :init (load-theme 'doom-one t)
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))
(use-package all-the-icons)
(use-package git-gutter
  :hook (prog-mode . git-gutter-mode))

;;-------------------------------------------------------------------------------
(use-package hydra)
(use-package which-key)
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
  :bind ( "C-SPC" . company-complete))
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


;; Shift arrows to move between windows
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(load-file "~/.emacs.d/hydra-moving.el")




;;-------------------------------------------------------------------------------
;;THIS IS FOR C++/C
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


;;-----------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ede-project-directories
   (quote
    ("/home/yachimm_thomasegh/projects/cadump-compiler")))
 '(package-selected-packages
   (quote
    (which-key flycheck-clangcheck flycheck-clang-tidy flycheck-clang-analyzer flycheck lsp-ui git-gutter treemacs-magit treemacs-projectile cmake-ide cmake-font-lock ccls cmake-mode doom-themes doom-modeline company helm-projectile projectile helm treemacs move-text use-package hydra))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )