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

(setq a '(1 2 3))

(push '(4 3) a)


(delete 'company-capf company-backends)

(setq company-backends (delete 'company-capf company-backends))

(message "%s" company-backends)

(defun deepni/add-remove-backends (opt backend)
  (when (boundp 'company-backends)
    (message "in %s" company-backends)
                                        ;(make-local-variable 'company-backends)
    (pcase opt
      ;; add
      ('add (add-to-list 'company-backends backend)
            (message "out %s" company-backends)
            )
      ;; remove
      ('remove
       (setq company-backends (delete backend company-backends))))
    ))

(deepni/add-remove-backends 'add 'company-capf)

(deepni/add-remove-backends 'remove 'company-capf)


(message "%s" company-backends)


(file-exists-p "~/anaconda3/envs/work3")


(defun test-interactive (arg)
  (interactive "bbuffer-name:")
  (message arg))

(expand-file-name (buffer-name))

(defun deepni/run-current-python-file (fname)
  "Run current python file pointed by `FNAME'."
  (interactive "bRun File: ")
  (message fname)
  (message (expand-file-name (buffer-name)))
  (+ivy/compile)
  (buffer-name)
  )


(call-interactively #'+lookup/online)

(file-name-extension (buffer-name) t)   ; .el
(file-name-extension (buffer-name))     ; el


(string-suffix-p "pre" "hello.prex")    ; nil
(string-suffix-p "pre" "hello.pre")     ; t

(print noninteractive)



(list '(a) '(1 2) '(c))
