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
