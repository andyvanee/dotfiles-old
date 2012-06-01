
;; Don't clutter up directories with files~
(setq backup-directory-alist `(("." . ,(expand-file-name (concat dotfiles-dir "backups")))))

;; Don't clutter with #files either
(setq auto-save-file-name-transforms `((".*" ,(expand-file-name (concat dotfiles-dir "backups")))))

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


;; Persistant scratch buffer

(defvar persistent-scratch-filename
  (concat dotfiles-dir "emacs-persistent-scratch"))

(defvar persistent-scratch-backup-directory
  (concat dotfiles-dir "emacs-persistent-scratch-backups/"))

(defun make-persistent-scratch-backup-name ()
  (concat
   persistent-scratch-backup-directory
   (replace-regexp-in-string
    (regexp-quote " ") "-" (current-time-string))))

(defun save-persistent-scratch ()
  (with-current-buffer (get-buffer "*scratch*")
    (if (file-exists-p persistent-scratch-filename)
        (copy-file persistent-scratch-filename
                   (make-persistent-scratch-backup-name)))
    (write-region (point-min) (point-max)
                  persistent-scratch-filename)))

(defun load-persistent-scratch ()
  (if (file-exists-p persistent-scratch-filename)
      (with-current-buffer (get-buffer "*scratch*")
        (delete-region (point-min) (point-max))
        (shell-command (format "cat %s" persistent-scratch-filename) (current-buffer)))))

(load-persistent-scratch)

(push #'save-persistent-scratch kill-emacs-hook)

;; A color theme

(defun color-theme-andy ()
  "dark color theme created by andy, 2012"
  (interactive)
  (color-theme-install
   '(color-theme-andy
     ((foreground-color . "#a9eadf")
      (background-color . "#222222")
      (background-mode . dark))
     (bold ((t (:bold t))))
     (bold-italic ((t (:italic t :bold t))))
     (default ((t (nil))))

     (font-lock-builtin-face ((t (:italic t :foreground "#a96da0"))))
     (font-lock-commentn-face ((t (:italic t :foreground "#bbbbbb"))))
     (font-lock-comment-delimiter-face ((t (:foreground "#666666"))))
     (font-lock-constant-face ((t (:bold t :foreground "#197b6e"))))
     (font-lock-doc-string-face ((t (:foreground "#3041c4"))))
     (font-lock-doc-face ((t (:foreground "gray"))))
     (font-lock-reference-face ((t (:foreground "white"))))
     (font-lock-function-name-face ((t (:foreground "#356da0"))))
     (font-lock-keyword-face ((t (:bold t :foreground "#bcf0f1"))))
     (font-lock-preprocessor-face ((t (:foreground "#e3ea94"))))
     (font-lock-string-face ((t (:foreground "#ffffff"))))
     (font-lock-type-face ((t (:bold t :foreground "#364498"))))
     (font-lock-variable-name-face ((t (:foreground "#7685de"))))
     (font-lock-warning-face ((t (:bold t :italic nil :underline nil
                                        :foreground "yellow"))))
     (hl-line ((t (:background "#112233"))))
     (mode-line ((t (:foreground "#ffffff" :background "#333333"))))
     (region ((t (:foreground nil :background "#555555"))))
     (show-paren-match-face ((t (:bold t :foreground "#ffffff"
                                       :background "#050505")))))))
(color-theme-andy)

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
