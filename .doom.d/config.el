;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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

(setq doom-font (font-spec :family "Fira Code" :size 16))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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

;; Sly setup
(setq inferior-lisp-program "sbcl")
(map! "M-S-<return>" #'sly-eval-defun)
(map! "M-<return>" #'sly-eval-defun)

;; Add colored parentheses
(add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)

;; Auto indent lisp code on save
(load! "indent-file.el")
(add-hook 'after-save-hook #'indent-whole-buffer)

;; Overwrite selected text
(delete-selection-mode 1)

;; Fixes because I can't type
(map! "C-x C-o" #'other-window)

;; Sane alt/ctrl+backspace behavior...
;; https://gist.github.com/jclosure/d838a672ba77482f2dcc1fc4df3368de#file-emacs-el-L447
(defun my-delete-backward-word ()
  (interactive "*")
  (push-mark)
  (backward-word)
  (delete-region (point) (mark)))

(defun my-delete-forward-word ()
  (interactive "*")
  (push-mark)
  (forward-word)
  (delete-region (point) (mark)))

(defun my-backward-kill-word-on-this-line ()
  (interactive)
  (let ((orig-point (point)))
    (beginning-of-line)
    (let ((beg-line-point (point)))
      (goto-char orig-point)
      (backward-word)
      (let ((backward-word-point (point)))
        ;; If the position of the beginning of the line is the same or
        ;; before the previous word position, remove previous word
        (goto-char orig-point)
        (if (> beg-line-point backward-word-point)
            (progn
              (goto-char beg-line-point)
              ;; delete whitespace and move to line above
              (delete-indentation))
          (backward-kill-word 1))))))

(defun my-backward-delete-word-on-this-line ()
  (interactive)
  (let ((orig-point (point)))
    (beginning-of-line)
      (let ((beg-line-point (point)))
        (goto-char orig-point)
        (backward-word)
        (let ((backward-word-point (point)))
          ;; If the position of the beginning of the line is the same or
          ;; before the previous word position, remove previous word
          (goto-char orig-point)
          (if (> beg-line-point backward-word-point)
              (progn
                (goto-char beg-line-point)
                ;; delete whitespace and move to line above
                (delete-indentation))
            (my-delete-backward-word))))))
(define-key global-map [remap backward-kill-word] #'my-backward-delete-word-on-this-line)
(define-key global-map [remap kill-word] #'my-delete-forward-word)

;; Treemacs
(setq treemacs-width 25)

;; Switch buffers using Alt+arrows
(map! "M-<left>" #'switch-to-prev-buffer)
(map! "M-<right>" #'switch-to-next-buffer)
