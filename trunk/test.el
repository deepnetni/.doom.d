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

(system-name)

(display-graphic-p)

(message "%s" IS-MAC)
(message "%s" IS-WINDOWS)
(message "%s" IS-BSD)
(message "%s" IS-LINUX)

(defun testpcase (arg)
  (pcase arg
    (1 (message "1"))
    (2 (message "2"))
    (_ (message "others"))))

(testpcase 4)

(unless nil
  (message "not nil"))


(when nil
  (message "t"))


(cond
 (IS-MAC (message "mac"))
 (IS-LINUX (message "linux"))
 (IS-WINDOWS (message "windows"))
 )
