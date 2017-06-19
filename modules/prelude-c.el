;;; prelude-c.el --- Emacs Prelude: cc-mode configuration.
;;
;; Copyright © 2011-2017 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: https://github.com/bbatsov/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Some basic configuration for cc-mode and the modes derived from it.

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

(require 'prelude-programming)

(defun prelude-c-mode-common-defaults ()
  "Available C style:

  “gnu”: The default style for GNU projects
  “k&r”: What Kernighan and Ritchie, the authors of C used in their book
  “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
  “whitesmith”: Popularized by the examples that came with Whitesmiths C, an
                early commercial C compiler.
  “stroustrup”: What Stroustrup, the author of C++ used in his book
  “ellemtel”: Popular C++ coding standards as defined by “Programming in C++,
              Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
  “linux”: What the Linux developers use for kernel development
  “python”: What Python developers use for extension modules
  “java”: The default style for 'java-mode” (see below)
  “user”: When you want to define your own style"
  (setq c-default-style "ellemtel"
        c-basic-offset 4)
  (c-set-offset 'substatement-open 0))

(setq prelude-c-mode-common-hook 'prelude-c-mode-common-defaults)

;; this will affect all modes derived from cc-mode, like
;; java-mode, php-mode, etc
(add-hook 'c-mode-common-hook (lambda ()
                                (run-hooks 'prelude-c-mode-common-hook)))

(defun prelude-makefile-mode-defaults ()
  "The makefile mode default settings function."
  (whitespace-toggle-options '(tabs))
  (setq indent-tabs-mode t ))

(setq prelude-makefile-mode-hook 'prelude-makefile-mode-defaults)

(add-hook 'makefile-mode-hook (lambda ()
                                (run-hooks 'prelude-makefile-mode-hook)))

(prelude-require-packages '(helm-gtags))
(require 'helm-gtags)

;; Enable helm-gtags-mode in Dired so you can jump to any tag
;; when navigate project tree with Dired
(add-hook 'dired-mode-hook 'helm-gtags-mode)

;; Enable helm-gtags-mode in Eshell for the same reason as above
(add-hook 'eshell-mode-hook 'helm-gtags-mode)

;;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; customize
(custom-set-variables
 '(helm-gtags-path-style 'relative)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t))

 ;; for gdb set
 ;; use gdb-many-windows by default
(setq gdb-many-windows t)
 ;; Non-nil means display source file containing the main routine at startup
(setq  gdb-show-main t)



;; key bindings
(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
  (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
  (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim))

;; (prelude-require-packages '(ycmd company-ycmd))
;; (company-ycmd-setup)
;; (set-variable 'ycmd-global-config "/path/to/global_conf.py")
;; (set-variable 'ycmd-extra-conf-whitelist '("~/projects/*"))

;; company-c-header
(prelude-require-package 'company-c-headers)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-c-headers))

;; (defun ede-object-system-include-path ()
;;   "Return the system include path for the current buffer."
;;   (when ede-object
;;     (ede-system-include-path ede-object)))

;; (setq company-c-headers-path-system 'ede-object-system-include-path)


;; for irony install
(prelude-require-package 'irony)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(when (eq system-type 'windows-nt)
  ;; Windows performance tweaks
  ;;
  (when (boundp 'w32-pipe-read-delay)
    (setq w32-pipe-read-delay 0))
  ;; Set the buffer size to 64K on Windows (from the original 4K)
  (when (boundp 'w32-pipe-buffer-size)
    (setq irony-server-w32-pipe-buffer-size (* 64 1024))))

;; for flycheck c++ flag setting
(defun prelude-flycheck-c++-language-standard ()
  "Set the default c++ language standard."
  ;; (let ((cpp-lang-std "c++11"))
  ;;   (setq flycheck-gcc-language-standard cpp-lang-std)
  ;;   (setq flycheck-clang-language-standard cpp-lang-std)
  ;;   (setq flycheck-cppcheck-standards cpp-lang-std)
  ;;   )
  (unless (boundp 'prelude-cpp-lang-std)
    (setq prelude-cpp-lang-std "c++11"))

  (setq flycheck-gcc-language-standard prelude-cpp-lang-std)
  (setq flycheck-clang-language-standard prelude-cpp-lang-std)
  (setq flycheck-cppcheck-standards prelude-cpp-lang-std))

(add-hook 'c++-mode-hook #'prelude-flycheck-c++-language-standard)


;; require for company-irony
(prelude-require-package 'company-irony)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; (prelude-require-package 'company-rtags)
;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'company-rtags))

;; require cmake-mode
(prelude-require-package 'cmake-mode)

;; require ede
(require 'ede)
(global-ede-mode t)

(provide 'prelude-c)

;;; prelude-c.el ends here
