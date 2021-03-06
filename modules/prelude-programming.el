;;; prelude-programming.el --- Emacs Prelude: prog-mode configuration
;;
;; Copyright © 2011-2017 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: https://github.com/bbatsov/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Some basic prog-mode configuration and programming related utilities.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(defun prelude-local-comment-auto-fill ()
  (set (make-local-variable 'comment-auto-fill-only-comments) t))

(defun prelude-font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.

This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
          1 font-lock-warning-face t))))


;; all programs will show line number
(add-hook 'prog-mode-hook 'prelude-line-number-mode-default)
;; (prelude-line-number-mode-default)

;; show the name of the current function definition in the modeline
(require 'which-func)
(which-function-mode 1)

;; in Emacs 24 programming major modes generally derive from a common
;; mode named prog-mode; for others, we'll arrange for our mode
;; defaults function to run prelude-prog-mode-hook directly.  To
;; augment and/or counteract these defaults your own function
;; to prelude-prog-mode-hook, using:
;;
;;     (add-hook 'prelude-prog-mode-hook 'my-prog-mode-defaults t)
;;
;; (the final optional t sets the *append* argument)

;; smart curly braces
(sp-pair "{" nil :post-handlers
         '(((lambda (&rest _ignored)
              (crux-smart-open-line-above)) "RET")))

;; enlist a more liberal guru
(setq guru-warn-only t)

(defun prelude-prog-mode-defaults ()
  "Default coding hook, useful with any programming language."
  (when (and (executable-find ispell-program-name)
             prelude-flyspell)
    (flyspell-prog-mode))
  (when prelude-guru
    (guru-mode +1))
  (smartparens-mode +1)
  (prelude-enable-whitespace)
  (prelude-local-comment-auto-fill)
  (prelude-font-lock-comment-annotations))

(setq prelude-prog-mode-hook 'prelude-prog-mode-defaults)

(add-hook 'prog-mode-hook (lambda ()
                            (run-hooks 'prelude-prog-mode-hook)))

;; enable on-the-fly syntax checking
(if (fboundp 'global-flycheck-mode)
    (add-hook 'after-init-hook 'global-flycheck-mode)
    ;; (global-flycheck-mode +1)
  (add-hook 'prog-mode-hook 'flycheck-mode))


;; in top line function show enhance
(prelude-require-package 'stickyfunc-enhance)
;;(require 'semantic)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(semantic-mode 1)
;; (require 'stickyfunc-enhance)


;; YASnippet is a template system for Emacs. It allows you to type an
;; abbreviation and automatically expand it into function templates.
;; Bundled language templates include: C, C++, C#, Perl, Python, Ruby, SQL,
;; LaTeX, HTML, CSS and more. The snippet syntax is inspired from TextMate's
;; syntax, you can even import most TextMate templates to YASnippet.
;; enable YASnippet as a non-global minor mode
;; seem like not show.
;; (yas-reload-all)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)
(require 'yasnippet)
(yas-global-mode 1)

;; Package: clean-aindent-mode
(prelude-require-packages '(clean-aindent-mode dtrt-indent ws-butler))

;; for debug
(require 'realgud)

;; (require 'clean-aindent-mode)
;; (add-hook 'prog-mode-hook 'clean-aindent-mode)

;; (require 'dtrt-indent)
;; (dtrt-indent-mode 1)
;; (setq dtrt-indent-verbosity 0)

;; (require 'ws-butler)
;; (add-hook 'prog-mode-hook 'ws-butler-mode)
;; (add-hook 'text-mode 'ws-butler-mode)
;; (add-hook 'fundamental-mode 'ws-butler-mode)

;; (prelude-require-package 'emr)
;; (autoload 'emr-show-refactor-menu "emr")
;; (define-key prog-mode-map (kbd "M-RET") 'emr-show-refactor-menu)
;; (eval-after-load "emr" '(emr-initialize))

(provide 'prelude-programming)

;;; prelude-programming.el ends here
