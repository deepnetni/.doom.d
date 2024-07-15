;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Deepni"
      user-mail-address "deepnetni@163.com")

(defconst IS-GUI (display-graphic-p))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;
;; good theme:
;; 'doom-peacock, 'doom-opera, 'doom-gruvbox,
;; 'doom-zenburn 'doom-miramare 'doom-one,
;; 'doom-monokai-octagon/pro 'doom-miramare

(setq doom-theme 'doom-zenburn)


;; Fonts in terminal Emacs is decideby by the terminal settings.
(cond
 (IS-LINUX
  ;;(setq doom-font (font-spec :family "JetBrains Mono" :size 12.0 :weight 'bold)))
  (setq doom-font (font-spec :family "Input Mono" :size 12.0 :weight 'bold)))
 (IS-MAC
  (setq doom-font (font-spec :family "Input Mono" :size 16.0 :weight 'bold)))
 (t
  (message "### work on others platform")
  ))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(menu-bar--display-line-numbers-mode-relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(setq isearch-wrap-function 'ignore)
(setq evil-search-wrap nil)     ;; search don't go to the beginning of the file
(setq confirm-kill-emacs nil)   ;; exit emacs without asking `xx exit anyway? (y or n)'

;; coding system
(set-default buffer-file-coding-system 'utf-8-unix)   ;; replace CRLF(\r\n) with LF(\n)
(set-default-coding-systems 'utf-8-unix)
(set-language-environment 'Chinese-GB)    ;; to support Chinese characters
(prefer-coding-system 'gb2312)
(prefer-coding-system 'utf-16)
(prefer-coding-system 'utf-8-emacs)
(prefer-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)  ;; configure terminal coding system
(set-keyboard-coding-system nil)
(+global-word-wrap-mode t)  ;; show multi-lines when one line too long

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)  ;; Restoring old substitution behavior on s/S


;; modeline configure
(display-time-mode t) ;; display time in modeline

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ############################# Packages ############################# ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package! helm-ag ;; helm-mode is not compatible with ivy-mode; therefore don't bind to any mode
  :defer
  ;;:hook ((c-mode-common . helm-mode)   ; equal to (add-hook 'c-mode-hook #'helm-mode)
  ;;       (python-mode . helm-mode))
  :init
                                        ;'(helm-ag-base-command "ag --nocolor --nogroup -w")
                                        ;'(helm-ag-command-option "--all-text")
                                        ;'(helm-ag--ignore-case)
  (setq helm-ag-insert-at-point 'symbol
        helm-ag-ignore-buffer-patterns '("\\.txt\\'" "\\.mkd\\'" "TAGS"))
  (setq helm-ag-use-temp-buffer t)
  ;; `helm-do-ag' need backslash to match whitespace while `helm-ag' treat directly.
  ;; `helm-do-ag' treats words which starts with `-' as command line option, e.g. -Gpy xx.
  ;; `helm-ag' treats words after `--' as search patten, e.g. -- --count search --count.
  ;; don't add space between short option and its values, e.g. `-tcpp' is ok, `-t cpp' is not ok.
  ;; use `=' for long option, e.g. `--ignore=pattern' not use `--ignore pattern'.
  (global-set-key (kbd "C-c a") 'helm-ag-project-root)
  (global-set-key (kbd "C-l") 'helm-do-ag-project-root)
  (global-set-key (kbd "C-j") 'helm-resume))

(use-package! counsel-etags
  :defer
  :bind (:map evil-motion-state-map
         ("C-]" . #'counsel-etags-find-tag-at-point)
         :map c-mode-base-map
         ("C-c C-u" . #'counsel-etags-update-tags-force))
  :init
  (setq tags-revert-without-query t) ;; Don't ask before rereading the TAGS files if they have changed
  (setq large-file-warning-threshold nil) ;; Don't warn when TAGS files are large
  (global-set-key (kbd "C-c C-t") 'counsel-etags-list-tag)
  (advice-add 'counsel-etags-find-tag-at-point :after
              (lambda () (evil-scroll-line-to-center (line-number-at-pos))))
  (advice-add 'counsel-etags-list-tag :after
              (lambda () (evil-scroll-line-to-center (line-number-at-pos))))
  :config
  (setq counsel-etags-update-interval 60)
  ;; counsel-etags-ignore-directories does NOT support wildcast
  (push "build" counsel-etags-ignore-directories)
  (push "build_clang" counsel-etags-ignore-directories)
  ;; counsel-etags-ignore-filenames supports wildcast
  (push "*.json" counsel-etags-ignore-filenames)
  (push "TAGS" counsel-etags-ignore-filenames))

;; (use-package! eglot
;;   :init)

(use-package! indent-guide
  :init
  :config
                                        ;(set-face-background 'indent-guide-face "dimgray")
                                        ;(setq indent-guide-delay 0.1)
  (when (not IS-GUI)
    (setq indent-guide-char "|")
    (setq indent-guide-recursive t)
    (indent-guide-global-mode)))

(use-package! highlight-indent-guides
  :init
  (when IS-GUI
    (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))
  :config
                                        ; (when (doom-context-p 'init)
                                        ;   (add-hook 'doom-first-buffer-hook #'highlight-indent-guides-auto-set-faces))
  ;; bitmap, character
  (setq highlight-indent-guides-method 'bitmap)
                                        ; (setq highlight-indent-guides-auto-odd-face-perc 25)
                                        ; (setq highlight-indent-guides-auto-even-face-perc 30)
  (setq highlight-indent-guides-auto-character-face-perc 40)
  )

(use-package! nerd-icons-ivy-rich
  :init
  (nerd-icons-ivy-rich-mode 1)
  (ivy-rich-mode 1)
  (setq nerd-icons-ivy-rich-color-icon nil)
  )

(use-package! deepni
  :after (evil format-all)
                                        ;:hook evil-mode  ;; BUG Not work
  :bind (:map deepni-mode-map
              ("C-c C-f" . #'deepni/format-code))  ;; using `:bind' will load package when bootup
  :init
  (add-hook 'evil-mode-hook #'deepni-mode)
  :config
  (deepni/goto-center (pop-tag-mark
                       evil-goto-mark
                                        ;evil-ex-search-next
                                        ;evil-ex-search-previous
                       better-jumper-jump_backward
                       better-jumper-jump_forward
                                        ; evil-ex-search-word-backward
                                        ; evil-ex-search-word-forward
                       evil-jump-forward
                       evil-jump-backward))
  (setq comment-empty-lines nil)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ############################# Configures ############################# ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! which-key
  (setq which-key-idle-delay 0.4))

                                        ;(after! lookup
                                        ;  (push '("bing.com" . "https://www.bing.com/search?q=%s") +lookup-provider-url-alist))

(after! hl-todo
  (map! :map hl-todo-mode-map
        :prefix "C-c"
        "i" #'hl-todo-insert
        "o" #'hl-todo-occur)
  (add-to-list 'hl-todo-keyword-faces '("WHY" . "#FF0000")))

(after! counsel
  (advice-add 'counsel-bookmark :after
              (lambda () (evil-scroll-line-to-center (line-number-at-pos)))))

(after! evil (defalias #'forward-evil-word #'forward-evil-symbol)) ;; see characters with - or _ as one word

(after! cc-mode
  (add-hook 'c-mode-hook (lambda ()
                           (setq tab-width 4)
                           (setq c-basic-offset 4)
                           (setq backward-delete-char-untabify-method nil)))
  (add-hook 'c-mode-common-hook (lambda ()
                                  (setq hide-ifdef-shadow t)
                                  (hide-ifdef-mode)
                                  (hide-ifdefs)))
  ;;(set-company-backend! '(c-mode c++-mode)
  ;;  '((:separate company-irony-c-headers company-irony)
  ;;    company-files))
  )

;; company
(after! company
  (setq company-idle-delay 0.1
        company-tooltip-align-annotations t
        company-minimum-prefix-length 2
        ;; items in the company list are sorted by frequency of use
        company-transformers '(company-sort-by-occurrence)
        company-selection-wrap-around t)
  (add-to-list 'company-backends 'company-files t))

;; configure anaconda mode company backends by adding backends to `+company-backend-alist'
;;(after! anaconda-mode
;;  (set-company-backend! 'anaconda-mode
;;    '((:separate company-anaconda company-capf company-files)
;;      company-yasnippet))
;;  (message "### init anaconda %s" +company-backend-alist)
;;  )

(after! python
  (setq flycheck-flake8-maximum-line-length 90)
  (when (file-exists-p "~/.pylintrc")
    (setq flycheck-pylintrc "~/.pylintrc"))
  ;; (when (file-exists-p python-workon-env)
  ;;   ;; (pythonic-activate python-workon-env)
  ;;   (pyvenv-activate python-workon-env))
  (when IS-MAC (pyvenv-workon "work"))           ; TODO need set $WORKON_HOME to anaconda envs in terminal
  (when IS-LINUX (pyvenv-workon "pytorch")))

(after! json
  (add-hook 'json-mode-hook
            (lambda ()
              (make-local-variable 'js-indent-level)
              (setq js-indent-level 4)
              (setq tab-width 4))))

;; TODO add workspace in modeline
                                        ;(after! doom-modeline
                                        ;  (setq doom-modeline-persp-name t))

(after! doom-zenburn-theme
  (custom-set-faces!
    ;; TODO configure the color of theme background, zenburn-bg, not work '(custom-themed :background "#293134")
    ;; dark green 76905E
    `(font-lock-function-name-face :foreground ,(doom-color 'dark-cyan))
    `(region :background ,(doom-color 'base7))
    `(evil-ex-lazy-highlight :background ,(doom-color 'base7))
    '(font-lock-variable-name-face :foreground "#88C058")
    '(font-lock-keyword-face :foreground "#99B767")
    '(font-lock-comment-face :foreground "#749574")
    '(font-lock-apply-highlight :background "#81CACD")))

;; configure title bar
(add-to-list 'default-frame-alist '(undecorated . t)) ;; hide title bar
                                        ;(add-to-list 'default-frame-alist '(drag-internal-border . 1))
                                        ;(add-to-list 'default-frame-alist '(internal-border-width . 3))
                                        ;(add-to-list 'default-frame-alist '(vertical-scroll-bars))
                                        ;(add-to-list 'default-frame-alist '(left-fringe))      ;; show left fringe
                                        ;(add-to-list 'default-frame-alist '(right-fringe . 0)) ;; close right fringe

;; show file absolute path in title bar
;; (setq frame-title-format '((:eval (if (buffer-file-name)
;;                                       (abbreviate-file-name (buffer-file-name))
;;                                     "%b"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ############################# Keymaps ############################# ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                                        ; (if IS-GUI
                                        ;     (defconst prefix-global-mapkey "" "UI prefix shortcuts")
                                        ;   (defconst prefix-global-mapkey "C-c" "Terminal prefix shortcuts"))

                                        ;(map! :prefix prefix-global-mapkey
                                        ;      "C-," #'+company/complete)

(when IS-GUI
  ;; GUI client
  (map! "C-," #'+company/complete))

(when (not IS-GUI)
  ;; Terminal client, which take `C-,' as `,'
  (map! :prefix "C-c"
        "," #'+company/complete))

(map! "C-s" #'counsel-grep-or-swiper)

(map! :after ivy
      :map ivy-minibuffer-map
      ;; "C-j" #'ivy-next-line
      ;; "C-k" #'ivy-previous-line
      "C-u" #'ivy-backward-delete-char
      :map doom-leader-map
      "SPC" #'+ivy/switch-workspace-buffer)

(map! :after helm-mode
      :map helm-map
      "C-j" #'helm-next-line
      "C-k" #'helm-previous-line
      "M-j" #'helm-next-page
      "M-k" #'helm-previous-page
      "C-p" #'helm-execute-persistent-action ;; show file content temporarily.
      )

(map! :after cc-mode
      :map c-mode-base-map
      :n "M-n" #'+ivy/compile
      :n "M-N" #'recompile
      :n "C-c C-c" #'kill-compilation
      :prefix "C-c"
      "d" #'hide-ifdef-define
      "u" #'hide-ifdef-undef
      "C-d" #'gendoxy-tag
      "C-h" #'gendoxy-header)

;; python part
;; (map! :after anaconda-mode
;;       :map anaconda-mode-map
;;       :i "C-," #'anaconda-mode-complete)


;; NOTE the [feature] followd :after should be a package name in the `SPACE h p' list
(map! :after python
      :map python-mode-map
      :n "M-n" #'+ivy/compile
      :n "M-N" #'recompile
      :n "C-c C-c" #'kill-compilation
      :prefix "C-c C-p"
      :desc "activate conda env"
      :n "c" #'pyvenv-workon)

(map! :after json-mode
      :map json-mode-map
      :n "C-c C-c" #'kill-compilation
      :n "M-n" #'+ivy/compile
      :n "M-N" #'recompile)

(map! :leader
      :prefix "f"
      :desc "jump to dired"
      "j" #'dired-jump)

(map! :leader
      :prefix "w"
      :desc "delete other windows"
      "O" #'delete-other-windows)

(map! :leader
      :prefix "l"
      :map general-override-mode-map
      "`" #'+workspace/display
      "l" #'+workspace/other   ;; switch to last workspace
      "1" #'+workspace/switch-to-0
      "2" #'+workspace/switch-to-1
      "3" #'+workspace/switch-to-2
      "4" #'+workspace/switch-to-3
      "5" #'+workspace/switch-to-4
      "[" #'+workspace/switch-left
      "H" #'+workspace/switch-left
      "]" #'+workspace/switch-right
      "L" #'+workspace/switch-right
      "d" #'+workspace/delete
      "C-l" #'+workspace/load
      "s" #'+workspace/save
      "n" #'+workspace/new-named
      "r" #'+workspace/rename)

(map! :map global-map
      :prefix "C-h"
      "C-f" #'find-function
      "C-v" #'find-variable
      "C-k" #'find-function-on-key
      "C-b" #'counsel-descbinds)

                                        ;(map! :map evil-normal-state-map
                                        ;      :leader
                                        ;      :prefix ("d" . "doom")
                                        ;(evil-define-key* '(normal motion) 'global
                                        ;  (kbd "C-o") #'evil-jump-backward
                                        ;  (kbd "C-i") #'evil-jump-forward)

(evil-define-key* 'normal 'global
  (kbd "C-w O") #'delete-other-windows
  (kbd "C-t") #'pop-tag-mark
  (kbd "C-p") #'counsel-projectile-find-file
  (kbd "M-h") #'evil-window-left
  (kbd "M-l") #'evil-window-right
  (kbd "M-j") #'evil-window-down
  (kbd "M-k") #'evil-window-up
  (kbd "C-i") #'evil-jump-forward
  (kbd "C-k") #'evil-ex-nohighlight
  (kbd "C-n") #'+workspace/new-named)

                                        ;(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
                                        ;(define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
                                        ;(define-key evil-normal-state-map (kbd "C-=") 'evil-window-increase-height)
                                        ;(define-key evil-normal-state-map (kbd "C--") 'evil-window-decrease-height)
                                        ;(define-key evil-normal-state-map (kbd "C-.") 'evil-window-increase-width)
                                        ;(define-key evil-normal-state-map (kbd "C-,") 'evil-window-decrease-width)

(evil-define-key* 'insert 'global
                                        ;(kbd "C-h") #'left-char
                                        ;(kbd "C-l") #'right-char
  (kbd "C-j") #'evil-next-line
  (kbd "C-k") #'evil-previous-line
  (kbd "C-c C-i") #'yas-insert-snippet
  (kbd "TAB") #'yas-expand
  (kbd "M-i") #'tab-to-tab-stop)

(evil-define-key* 'motion 'global
  (kbd "C-]") #'xref-find-definitions
  (kbd "C-w C-]") #'xref-find-definitions-other-window
  (kbd "C-f") #'counsel-find-file
  (kbd "C-e") #'evil-end-of-line
  (kbd "C-b") #'evil-first-non-blank
  (kbd "*") #'evil-ex-search-word-forward
  (kbd "#") #'evil-ex-search-word-backward)

                                        ;(define-key evil-motion-state-map (kbd "C-1") #'+workspace/switch-to-0)
                                        ;(define-key evil-motion-state-map (kbd "C-2") #'+workspace/switch-to-1)
                                        ;(define-key evil-motion-state-map (kbd "C-3") #'+workspace/switch-to-2)
                                        ;(define-key evil-motion-state-map (kbd "C-4") #'+workspace/switch-to-3)
