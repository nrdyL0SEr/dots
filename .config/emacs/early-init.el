;; GARBAGE cOLLECTION
(setq gc-cons-percentage 0.6)
; Make the initial buffer load faster by setting its mode to fundamental-mode
(setq initial-major-mode 'fundamental-mode)

;; COMPILE WARNINGS
(setq native-comp-async-report-warnings-errors 'silent)
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))

;; SPLASH SCREEN
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "ʕ•́ᴥ•̀ʔ")

;; VISUALS
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(display-line-numbers-mode -1)
(set-fringe-mode 10)
(visual-line-mode 1)
(set-frame-parameter nil 'alpha-background 80)
(add-to-list 'default-frame-alist '(alpha-background . 80))

;; FONT
(set-face-attribute 'default t :weight 'medium :height 130 :font "Source Code Pro")
(custom-theme-set-faces
 'user
 '(org-level-1 ((t (:inherit outline-1 :height 1.4))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
 '(variable-pitch ((t (:family "Source Code Pro" :weight medium))))
 '(org-block ((t (:background nil))))
 '(org-quote ((t (:background nil))))
 '(org-block-begin-line ((t (:background nil))))
 '(org-block-end-line ((t (:background nil))))
 '(fixed-pitch ((t ( :family "Source Code Pro" :height 130)))))
