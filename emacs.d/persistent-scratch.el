;; Make the scratch buffer persistant

(defvar persistent-scratch-filename
  (concat dotfiles-dir "emacs-persistent-scratch"))

(defun save-persistent-scratch ()
  (with-current-buffer (get-buffer "*scratch*")
    (write-region (point-min) (point-max)
                  persistent-scratch-filename)))

(defun load-persistent-scratch ()
  (if (file-exists-p persistent-scratch-filename)
      (with-current-buffer (get-buffer "*scratch*")
        (delete-region (point-min) (point-max))
        (shell-command (format "cat %s" persistent-scratch-filename) (current-buffer)))))

(load-persistent-scratch)

(push #'save-persistent-scratch kill-emacs-hook)
