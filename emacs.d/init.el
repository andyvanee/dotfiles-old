;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Load path etc.

(setq dotfiles-dir (file-name-directory
		    (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path dotfiles-dir)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(require 'load-packages)

;; You can keep system- or user-specific customizations here
(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-dir (concat dotfiles-dir user-login-name))

(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))

(if (file-exists-p user-specific-dir)
      (mapc #'load (directory-files user-specific-dir nil ".*el$")))

(if (file-exists-p user-specific-config) (load user-specific-config))

;; 2 space tabs and no tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)
;;(setq indent-line-function 'indent-relative)
(global-set-key
  (kbd "RET")
  'newline-and-indent)

;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)

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
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#262622" :foreground "White" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "cousine" :family "Cousine")))))

;;(defun arrange-frame (w h x y)
;;  "Set the width, height, and x/y position of the current frame"
;;  (let ((frame (selected-frame)))
;;    (delete-other-windows)
;;    (set-frame-position frame x y)
;;    (set-frame-size frame w h)))

;;(arrange-frame 160 50 2 22)


(add-to-list 'load-path "~/.emacs.d/vendor/color-theme")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))
