;;; presonal-afterload.el -- show
;;;

;; If you'd like to add some auto installation of packages in your personal
;; config use the following code:

;; sr-speedbar(require 'projectile-speedbar)
(prelude-require-packages '(sr-speedbar projectile-speedbar))
(setq sr-speedbar-skip-other-window-p t)

;; require maxframe package
;; To restore the frame to it's original dimensions, call restore-frame:
;; M-x restore-frame
; (prelude-require-package 'maxframe)
; (add-hook 'window-setup-hook 'maximize-frame t)

;; require ws-butler
;; Unobtrusively remove trailing whitespace.
; (prelude-require-package ' ws-butler)
; (add-hook 'c-mode-common-hook 'ws-butler-mode)
;;(add-hook 'c-mode-common-hook 'ws-butler-mode)

; (require 'cc-mode)
; (require 'semantic)
; (prelude-require-package 'stickyfunc-enhance)
; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
; (global-semanticdb-minor-mode 1)
; (global-semantic-idle-scheduler-mode 1)
; (global-semantic-stickyfunc-mode 1)

; (add-hook 'c-mode-common-hook   'hs-minor-mode)
; (add-hook 'c-mode-hook   'hs-minor-mode)
; (add-hook 'c++-mode-hook   'hs-minor-mode)

; (when (eq system-type 'windows-nt) 
	; (progn 
	; (semantic-add-system-include "C:/CustomProgFiles/msys64/mingw64/include/")
	; (semantic-add-system-include "C:/CustomProgFiles/msys64/mingw64/x86_64-w64-mingw32/include/")
	; (semantic-add-system-include "C:/CustomProgFiles/msys64/mingw64/include/c++/6.3.0/" 'c++-mode)))

; (semantic-mode 1)

;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
;; (setq c-default-style "linux")  ;; set style to "linux"
