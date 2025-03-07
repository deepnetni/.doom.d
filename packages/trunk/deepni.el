;;; trunk/deepni.el -*- lexical-binding: t; -*-

;;; Commentary:

;; Bind all the settings to this minor mode for easy management

(require 'persp-mode)
(require 'hideif)
(require 'format-all)
(require 'evil)
;;(require 'ivy)

;;; Code:

;;;###autoload
(defmacro deepni/goto-center (args)
  "Move the line outputed by ARGS to center."
  `(dolist (tgt ',args)
     (advice-add tgt :after (lambda (&rest _)
                              (evil-scroll-line-to-center (line-number-at-pos))))))

;;;###autoload
(defun deepni/format-code ()
  "Process macros first in c/cpp mode before format."
  (interactive)
  (pcase major-mode
    ('c-mode (hide-ifdefs)
             (+format/buffer))
    ('c++-mode (hide-ifdefs)
               (+format/buffer))
    ('python-mode (+format/buffer))
    (_ (+format/buffer))))

;;;###autoload
(defun deepni/add-remove-backends (opt backend)
  (when (boundp 'company-backends)
                                        ;(make-local-variable 'company-backends)
    (message "### in %s" company-backends)
    (pcase opt
      ;; add
      ('add (add-to-list 'company-backends backend))
      ;; remove
      ('remove
       (setq company-backends (delete backend company-backends))))
    (message "### out %s" company-backends)
    ))

(defun deepni/save-layout ()
  "Save current layout to file."
  (interactive)
  (persp-save-state-to-file (concat persp-save-dir "deep-layout")))

(defun deepni/load-layout ()
  "Load last time layout from file."
  (interactive)
  (let ((fname (concat persp-save-dir "deep-layout")))
    (message "### %s %s" fname (file-exists-p fname))
    (when (file-exists-p fname)
      (persp-load-state-from-file fname))))

(defun deepni/python-current-file ()
  "insert current filename in compile buffer."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (compile (format "python %s" file-name))
      (message "No file associated with this buffer."))))


;; NOTE define minor mode

(defvar deepni-mode-map (make-sparse-keymap)
  "Keymap used in `deepni-mode' buffers.")

;;;###autoload
(define-minor-mode deepni-mode
  "A minor mode for deepnetni to override conflict settings."
  :init-value t
  :lighter ""
  :keymap deepni-mode-map)

(provide 'deepni)
;;; deepni.el ends here
