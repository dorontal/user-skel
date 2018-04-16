;;; .emacs

(setq window-width 80)
(setq window-height 43)

;;; use auto-install when need new .el 
;(load "~/lib/emacs/elisp/auto-install.el")
;(auto-install-from-url "https://raw.github.com/aki2o/emacs-tss/master/tss.el")
;(auto-install-from-url "https://raw.github.com/aki2o/emacs-tss/master/typescript.el")

;(require 'auto-complete)
(load "~/lib/emacs/elisp/auto-complete.el")
(load "~/lib/emacs/elisp/yaxception.el")
(load "~/lib/emacs/elisp/log4e.el")
(load "~/lib/emacs/elisp/json-reformat.el")
(load "~/lib/emacs/elisp/json-snatcher.el")
(load "~/lib/emacs/elisp/json-mode.el")
(load "~/lib/emacs/elisp/tss.el")
(load "~/lib/emacs/elisp/typescript.el")
;(require 'tss)
;(require 'typescript)

;;; set up the autoinclude hack 
(load "~/lib/emacs/elisp/autoinclude.el")
(setq auto-include-directory "~/lib/emacs/autoinclude/")
(setq auto-include-alist '(("\\.h$" . "header.h")
			   ("\\.cpp$" . "header.cpp")
			   ("\\.m$" . "header.m")
			   ))

;;; js2-mode mooz fork https://github.com/mooz/js2-mode
;(autoload 'js2-mode "js2-mode" nil t)
;(autoload 'js2-mode "~/lib/emacs/elisp/js2-mode/js2-mode" nil t)

(add-to-list 'auto-mode-alist '("\\.ts$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

;;; Get tabs the way I want
(setq-default indent-tabs-mode nil)

;;; latex stuff
(setq tex-dvi-view-command "/usr/bin/xdvi")

;; avoid waiting for comint (command completion) to load on first usage
(autoload 'comint "comint-dynamic-complete")

;;; matlab related
(autoload 'matlab-mode "~/lib/emacs/elisp/matlab.el" "Matlab Editing Mode" t)
;;;add-hook 'matlab-mode-hook 'turn-on-font-lock)
(add-to-list 'auto-mode-alist '("\\.m$" . matlab-mode))
(setq matlab-indent-function nil)

;;; c/c++ related
(defun my-c++-indent-setup ()
  ;;; I know how to use CVS, I don't need Emacs telling me what to do
  (setq-default vc-handle-cvs nil)
  ;;; my indent style
  (setq c-basic-offset 4)
  (setq c-default-style "K&R")
  ;;; tell emacs to never use tab chars for indentation
  (setq indent-tabs-mode nil))

(add-hook 'c++-mode-hook 'my-c++-indent-setup)
;;;(add-hook 'c++-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'c++-mode)

(defun my-python-indent-setup ()
  (setq indent-tabs-mode nil)
  (setq py-continuation-offset 0)
  (turn-on-font-lock)
  (setq tab-width 4)
  (setq py-indent-offset 4))

(add-hook 'python-mode-hook 'my-python-indent-setup)

;;; turn on auto-fill mode automatically in text mode and related modes
(add-hook 'text-mode-hook
          '(lambda () (auto-fill-mode 1)))

(add-hook 'html-mode-hook
          (lambda ()
            (set (make-local-variable 'sgml-basic-offset) 2)))

;; Are we running XEmacs or Emacs?
(defvar running-xemacs (string-match "XEmacs" emacs-version))

;; Turn on font-lock mode for Emacs
(cond ((not running-xemacs)
       (global-font-lock-mode t)))

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; Always end a file with a newline
(setq require-final-newline t)

;;; VISUAL/DISPLAY

;; Enable wheelmouse support by default
(cond (window-system (mwheel-install)))

;; Visual feedback on selections
(setq-default transient-mark-mode t)

;;; (if (string-match "XEmacs" emacs-version)
(cond (running-xemacs
       (progn ;;; XEmacs stuff

         (set-specifier menubar-visible-p nil)
         
         ;;; XEmacs way of turning font lock for all modes
         (font-lock-mode)
         
         ;;; Who needs a 3D modeline?
         ;;; (set-specifier modeline-shadow-thickness 0)
         
         ;;; Or a toolbar?
         (set-specifier default-toolbar-visible-p nil)

         ;;; I know what I'm doing w.r.t. key mappings; don't warn me.
         (setq display-warning-suppressed-classes
               (cons 'key-mapping display-warning-suppressed-classes)))

         ;;; Blinking cursor is spawn of the Evil One
         ;;; (blink-cursor-mode nil)

         ;;; Set default font & other window properties under FSF Emacs.
         ;;; XEmacs doesn't need this because it uses the X resources
         ;;; database, which can be modified in ~/.Xdefaults
         (setq default-frame-alist
               (append default-frame-alist
                       '((width . window-width) (height . window-height))))))

;;; save faces with all other options
(setq options-save-faces t)

;;; no underlining
(setq face-underline-p nil)

;;; always show line and column numbers
(line-number-mode 1) 
(column-number-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; KEY BINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (global-set-key (kbd "C-SPC") 'set-mark-command)

(global-set-key "\M-g" 'goto-line)

;;; fill-paragraph
(global-set-key "\M-\C-p" 'fill-paragraph)

;;; Global replace
(global-set-key "\M-r" 'replace-string)
(global-set-key "\M-\C-r" 'query-replace)

;;; erase line-end whitespace
(global-set-key "\C-xw" 'flush-trailing-whitespace)

;;; Change other window commands.
(global-set-key "\C-xn" 'select-next-window)
(global-set-key "\C-xp" 'select-previous-window)
(global-set-key "\C-xd" 'delete-window)
(global-set-key "\C-xv" 'find-alternate-file)
(global-set-key "\C-x\C-v" 'find-file-other-window)
(global-set-key "\C-xt" 'line-to-top)

;;; interactively kill any of current buffers
(global-set-key "\C-x\C-k" 'kill-some-buffers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Here are the next and previous window functions.

(defun select-next-window ()
  (interactive)
  (other-window 1))

(defun select-previous-window ()
  (interactive)
  (other-window -1))

;;; Brings current line to top of window.

(defun line-to-top ()
  (interactive)
  (recenter 0))

;;; Flushes hanging whitespace at end of lines.

(defun flush-trailing-whitespace ()
  (interactive)
  "Eliminate trailing whitespace at ends of lines."
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "[ \t][ \t]*$" nil t)
      (delete-region (match-beginning 0) (point)))))

;; (global-set-key "\C-v" 'scroll-up)

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; window width and height
; (set-frame-position (selected-frame) 222 0)
(set-frame-height (selected-frame) window-height)
(set-frame-width (selected-frame) window-width)

;;; colors
(set-background-color "black") 
(set-foreground-color "white") 
;(set-face-foreground "firebrick") 
(set-cursor-color "purple") 
(setq visible-bell 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
