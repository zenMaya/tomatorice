;;; cmake-font-lock-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "cmake-font-lock" "cmake-font-lock.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from cmake-font-lock.el

(autoload 'cmake-font-lock-activate "cmake-font-lock" "\
Activate advanced CMake colorization.

To activate this every time a CMake file is opened, use the following:

    (add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

\(fn)" t nil)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "cmake-font-lock" '("cmake-font-lock-")))

;;;***

(provide 'cmake-font-lock-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; cmake-font-lock-autoloads.el ends here