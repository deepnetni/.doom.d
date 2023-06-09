;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Deepni"
      user-mail-address "deepnetni@163.com")

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
;; good theme: 'doom-gruvbox, 'doom-zenburn 'doom-miramare 'doom-one
(setq doom-theme 'doom-miramare)
(setq doom-font (font-spec :family "InputMono" :size 14.0 :weight 'bold))

;; this determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(setq which-key-idle-delay 0.4)  ;; search don't go to the beginning of the file
(setq isearch-wrap-function 'ignore)
(setq evil-search-wrap nil)

;; coding system
(set-default buffer-file-coding-system 'utf-8-unix)
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

;; NOTE Packages

(use-package! helm-ag
  :defer t
  :hook ((c-mode-common . helm-mode)   ; equal to (add-hook 'c-mode-hook #'helm-mode)
         (python-mode . helm-mode))
  :init
  ;'(helm-ag-base-command "ag --nocolor --nogroup -w")
  ;'(helm-ag-command-option "--all-text")
  ;'(helm-ag--ignore-case)
  (setq helm-ag-insert-at-point 'symbol
        helm-ag-ignore-buffer-patterns '("\\.txt\\'" "\\.mkd\\'" "TAGS"))
  (global-set-key (kbd "C-c a") 'helm-ag-project-root)
  (global-set-key (kbd "C-l") 'helm-do-ag-project-root)
  (global-set-key (kbd "C-j") 'helm-resume))

(use-package! counsel-etags
  :defer t
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
  ;(map! (:map
  ;       evil-motion-state-map
  ;       "C-]" #'counsel-etags-find-tag-at-point
  ;       :map c-mode-base-map
  ;       :prefix "C-c"
  ;       "C-u" #'counsel-etags-update-tags-force))
  :config
  (setq counsel-etags-update-interval 60)
  ;; counsel-etags-ignore-directories does NOT support wildcast
  (push "build" counsel-etags-ignore-directories)
  (push "build_clang" counsel-etags-ignore-directories)
  ;; counsel-etags-ignore-filenames supports wildcast
  (push "*.json" counsel-etags-ignore-filenames)
  (push "TAGS" counsel-etags-ignore-filenames))

(use-package! deepni
  :after (evil format-all)
  ;:hook evil-mode  ;; BUG Not work
  :bind (:map deepni-mode-map
              ("C-c C-f" . #'deepni/format-code))
  :init
  (add-hook 'evil-mode-hook #'deepni-mode)
  :config
  (deepni/goto-center (evil-goto-mark
                       pop-tag-mark
                       evil-jump-forward
                       evil-jump-backward
                       evil-ex-search-next
                       evil-ex-search-previous
                       evil-ex-search-word-backward
                       evil-ex-search-word-forward)))

  ;(global-set-key (kbd "C-c C-f") #'deepni/format-code))

;(after! evil
;  (deepni/goto-center #'(evil-goto-mark
;                         pop-tag-mark
;                         evil-jump-forward
;                         evil-jump-backward
;                         evil-ex-search-next
;                         evil-ex-search-previous
;                         evil-ex-search-word-backward
;                         evil-ex-search-word-forward)))

;(after! counsel-etags
;  (deepni/goto-center #'(counsel-etags-find-tag-at-point)))

(after! hl-todo
  (map! :map hl-todo-mode-map
        :prefix "C-c"
        "i" #'hl-todo-insert
        "o" #'hl-todo-occur))


(after! evil (defalias #'forward-evil-word #'forward-evil-symbol)) ;; see characters with - or _ as one word

(after! cc-mode
  (add-hook 'c-mode-common-hook (lambda ()
                                  (setq hide-ifdef-shadow t)
                                  (hide-ifdef-mode)
                                  (hide-ifdefs))))

;; company
(after! company
  (setq company-idle-delay 0.1
        company-tooltip-align-annotations t
        company-minimum-prefix-length 1
        ;; items in the company list are sorted by frequency of use
        company-transformers '(company-sort-by-occurrence)
        company-selection-wrap-around t))

;; TODO add workspace in modeline
;(after! doom-modeline
;  (setq doom-modeline-persp-name t))


;; NOTE Keybindings

(map! "C-s" #'counsel-grep-or-swiper)

(map! :after cc-mode
      :map c-mode-base-map
      :prefix "C-c"
      "d" #'hide-ifdef-define
      "u" #'hide-ifdef-undef)

(map! :leader
      :prefix "f"
      :desc "jump to dired"
      "j" #'dired-jump)

(map! :leader
      :prefix "w"
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

(evil-define-key* '(normal insert) 'global
  (kbd "C-,") #'+company/complete)

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
  (kbd "C-h") #'left-char
  (kbd "C-l") #'right-char
  (kbd "C-j") #'evil-next-line
  (kbd "C-k") #'evil-previous-line
  (kbd "TAB") #'yas-expand
  (kbd "M-i") #'tab-to-tab-stop)

(evil-define-key* 'motion 'global
  (kbd "C-f") #'counsel-find-file
  (kbd "C-e") #'evil-end-of-line
  (kbd "C-b") #'evil-first-non-blank
  (kbd "*") #'evil-ex-search-word-forward
  (kbd "#") #'evil-ex-search-word-backward)

;(define-key evil-motion-state-map (kbd "C-1") #'+workspace/switch-to-0)
;(define-key evil-motion-state-map (kbd "C-2") #'+workspace/switch-to-1)
;(define-key evil-motion-state-map (kbd "C-3") #'+workspace/switch-to-2)
;(define-key evil-motion-state-map (kbd "C-4") #'+workspace/switch-to-3)
