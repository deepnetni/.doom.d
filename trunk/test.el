;;; trunk/test.el -*- lexical-binding: t; -*-

;;; Code:


(require 'deepni)

(message "test deepni package")

(defun print-name (&rest args)
  (let ((first (plist-get args :first))
        (key (or (plist-get args :key) "?")))
    (message key)
    (when first
      (message first))))

(defun print-name_1 (&rest args)
  (let ((first (plist-get args :first))
        (key (or (plist-get args :key) "?")))
    (message key)
    (when first
      (message first))))

(setq funcs #'(print-name print-name_1))

(defun fadd (f-alist)
  (dolist (f f-alist)
    (message "%s" (symbolp `#',f))
    (message "%s start" `#',f)
    (advice-add `#',f :after
                (lambda (&rest _)
                  (message "## after done")))))

;(fadd #'(print-name print-name_1))
(advice-add 'print-name :after
            (lambda (&rest _)
              (message "## after done")))

(defmacro tm (args)
  `(dolist (tgt ',args)
     (message "%d" tgt)))

(tm (1 2 3))

;(print-name :first "first arg" :key "this is key")
(window-system)
