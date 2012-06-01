
;; Don't clutter up directories with files~
(setq backup-directory-alist `(("." . ,(expand-file-name (concat dotfiles-dir "backups")))))

;; Don't clutter with #files either
(setq auto-save-file-name-transforms `((".*" ,(expand-file-name (concat dotfiles-dir "backups")))))

;; Use persistent scratch file
(load-file (concat dotfiles-dir "persistent-scratch.el"))

;; Syntax modes
(add-to-list 'load-path (concat dotfiles-dir "vendor/coffee-mode"))
(require 'coffee-mode)

(add-to-list 'load-path (concat dotfiles-dir "vendor/php-mode"))
(require 'php-mode)

(add-to-list 'load-path (concat dotfiles-dir "vendor/go-mode"))
(require 'go-mode)

;; Adding color-theme
(add-to-list 'load-path (concat dotfiles-dir "vendor/color-theme"))
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)))

;; Copy kill ring to mac clipboard
(load-file (concat dotfiles-dir "vendor/pbcopy.el"))
(turn-on-pbcopy)

(load-file (concat dotfiles-dir "color-theme-andy.el"))
(color-theme-andy)

;; 2 space tabs and no tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

;; enable mouse reporting for terminal emulators
(unless window-system
  (require 'mouse)
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                               (interactive)
                               (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                               (interactive)
                               (scroll-up 1))))

;; enable mouse reporting for terminal emulators
(unless window-system
  (xterm-mouse-mode 1)
  (global-set-key [mouse-4] '(lambda ()
                               (interactive)
                               (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                               (interactive)
                               (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t))
