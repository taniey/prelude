;;; presonal-preload.el --- show
;;; commentary:

;;; code:
;; set the win-NT env
(when (eq system-type 'windows-nt)
  (let ((mypaths
         '("c:/CustomProgFiles/Python36/"
           "c:/CustomProgFiles/Git-2.13.0-64-bit/cmd"
           "c:/CustomProgFiles/msys64/mingw64/bin"
           ;; "c:/CustomProgFiles/emacs/emacs.config/.emacs.d/irony/bin"
           ;; "C:/CustomProgFiles/mingw64/bin"
           ;; "C:/CustomProgFiles/msys64/usr/bin"
           ))
        (another-var "only a test."))

    ;; set default directories
    (setq default-directory "D:/")

    (setenv "PATH" (concat (mapconcat 'identity mypaths ";") ";" (getenv "PATH")))
    (setenv "GTAGSLIBPATH" "c:/CustomProgFiles/emacs/emacs.config/.gtags/")
    ;;(setenv "PATH" (mapconcat 'identity mypaths ";" ))
    ;;(setenv "PATH" (concat "C:\\CustomProgFiles\\msys64\\mingw64\\bin" ";"
    ;;                       ;; "C:\\CustomProgFiles\\msys64\\usr\\bin" ";"
    ;;                       (getenv "PATH")))

    (setq exec-path (append mypaths exec-path))
    ))


;;; my custom config

;;; colonum show numberp
;;(global-linum-mode t)


;; set my theme dracula
(setq prelude-theme 'deeper-blue)
;;(setq prelude-theme 'solarized-dark)
;;(setq prelude-theme 'solarized-light)
;;(setq prelude-theme 'dracula)


;; Although whitespace-mode is awesome some people might find it too intrusive.
;; You can disable it in your personal config with the following bit of code:
;; (setq prelude-whitespace nil)

;; If you like whitespace-mode but prefer it to not automatically cleanup your
;; file on save, you can disable that behavior by setting
;; prelude-clean-whitespace-on-save to nil in your config file with:
;; (setq prelude-clean-whitespace-on-save nil)


;;Disable flyspell-mode
(setq prelude-flyspell nil)


;; If you'd like to be take this a step further and disable the arrow key
;; navigation completely put this in your personal config:
;; (setq guru-warn-only nil)

;; To disable guru-mode completely add the following snippet to your personal
;; Emacs config:
;; (setq prelude-guru nil)

;; Prelude overrides C-a to behave as described here. If you don't like that
;; simply add this to your personal config:
;; (global-set-key [remap move-beginning-of-line]
;;                 'move-beginning-of-line)

;; Prelude swaps the default ido flex matching with the more powerful ido-flx.
;; The sorting algorithm flx uses is more complex, but yields better results.
;; On slower machines, it may be necessary to lower flx-ido-threshold to ensure
;; a smooth experience.
;; (setq flx-ido-threshold 1000)

;; You can always disable the improved sorting algorithm all together like this:
;; (flx-ido-mode -1)

;; set flycheck c++ language standard
(setq prelude-cpp-lang-std "c++11")
