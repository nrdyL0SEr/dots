;; PACKAGE MANAGEMENT
(use-package package
             :config
             (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                                      ("melpa-stable" . "https://stable.melpa.org/packages/")
                                      ("elpa" . "https://elpa.gnu.org/packages/")))
             (package-initialize))
(use-package use-package
             :custom
             (use-package-always-ensure t)
             (package-native-compile t)
             (warning-minimum-level :emergency))


;; VARIABLES AND FUNCTIONS
(defvar mt/home (concat (getenv "HOME") "/") "My home directory.")
(setq bookmark-default-file (concat mt/home ".cache/emacs/bookmarks"))

(defun to-and-fro-minibuffer ()
  "Go back and forth between minibuffer and other window."
  (interactive)
  (if (window-minibuffer-p (selected-window))
    (select-window (minibuffer-selected-window))
    (select-window (active-minibuffer-window))))
(defun froggy-search ()
  "Search within notes folder for all .org files"
  (interactive)
  (consult-find "~/Notes/" "\\.org#"))
(defun rugby-search ()
  "Search org-roam directory using consult-ripgrep."
  (interactive)
  (let ((consult-ripgrep-command "rg --multiline --null --ignore-case --type org --line-buffered --color=always"))
    (consult-ripgrep (concat org-roam-directory))))
(defun my/diff-auto-save-file ()
  "Get auto-save #file# difference with current buffer."
  (interactive)
  (diff (make-auto-save-file-name) (current-buffer) nil 'noasync))

;; GLOBAL BINDINGS
(define-key global-map (kbd "C-S-y") 'simpleclip-paste)
(define-key global-map (kbd "C-S-w") 'simpleclip-cut)
(define-key global-map (kbd "M-W") 'simpleclip-copy)

(define-key global-map (kbd "C-c C-j") 'jump-to-register)
(define-key global-map (kbd "C-x 5 R") 'set-frame-name)
(define-key global-map (kbd "C-x C-n") 'display-line-numbers-mode)
(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c o") 'froggy-search)
(define-key global-map (kbd "C-c rv") 'rugby-search)
(define-key global-map (kbd "C-c s") 'dictionary-search)
(define-key global-map (kbd "M-SPC") 'to-and-fro-minibuffer)
; Global Registers
(set-register ?1 '(file . "~/Notes/1school.org"))
(set-register ?2 '(file . "~/Notes/1A+media.org"))
(set-register ?3 '(file . "~/Notes/1diary.org"))
(set-register ?4 '(file . "~/Notes/1writing.org"))
(set-register ?5 '(file . "~/Notes/1misc.org"))
(set-register ?d '(file . "~/Notes/1definitions.org"))
(set-register ?i '(file . "~/Notes/1info.org"))
(set-register ?t '("*** Preamble\n- Author :: \n- Related :: \n- \n*** Notes\n*** Vocabulary"))
; Nullified Keys
(global-set-key (kbd "C-x C-z") nil)
(global-set-key (kbd "C-x C-c") nil)
(global-set-key (kbd "C-/") nil)


;; SETTINGS
(setq-default cursor-in-non-selected-windows t)
(setq-default help-window-select t)
(setq-default load-prefer-newer t)
(setq-default vc-follow-symlinks t)
(setq-default view-read-only t)
(setq-default enable-recursive-minibuffers t)
(setq-default bookmark-fringe-mark nil)
(setq-default display-time-default-load-average nil)
(setq-default sentence-end-double-space nil)
(setq-default tab-width 4)
(setq-default select-enable-clipboard 'nil)
(setq-default ad-redefinition-action 'accept)
(fset 'yes-or-no-p 'y-or-n-p)
(set-default-coding-systems 'raw-text)
; Global Modes
(defun highlight-visual-line ()
  (save-excursion
    (cons (progn (beginning-of-visual-line) (point))
          (progn (end-of-visual-line) (point)))))

(setq hl-line-range-function 'highlight-visual-line)
(global-hl-line-mode 1)
(setq-default auto-fill-mode)
(setq-default variable-pitch-mode 1)
(global-display-line-numbers-mode 1)
(setq-default display-line-numbers-type 'visual)
(global-visual-line-mode 1)
(setq-default indent-tabs-mode t)
; Modeline
(setq-default mode-line-format nil)
; Backup
(setq create-lockfiles nil)
(setq make-backup-files t)
(setq version-control t)
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq kept-old-versions 5)
(setq kept-new-versions 5)
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))
; System Trash
(setq trash-directory (concat mt/home ".Trash"))
(setq delete-by-moving-to-trash t)


;; THEME
(use-package doom-themes
             :config
             ;; Global settings (defaults)
             (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
                   doom-themes-enable-italic nil) ; if nil, italics is universally disabled
             (load-theme 'doom-rouge t)
             ;; Corrects (and improves) org-mode's native fontification.
             (doom-themes-org-config))

;; HISTORY
(use-package savehist
             :init
             (savehist-mode))


;; SYSTEM CLIPBOARD
(use-package simpleclip
             :init
             (simpleclip-mode 1))

;; UNDO!
(use-package undo-fu
             :config
             (global-unset-key (kbd "C-z"))
             (global-set-key (kbd "C-z") 'undo-fu-only-undo)
             (global-set-key (kbd "C-S-z") 'undo-fu-only-redo))


;; COMPLETION
(use-package vertico
             :init
             (vertico-mode)
             :config
             (setq vertico-cycle t)
             :custom
             (vertico-sort-function 'vertico-sort-history-alpha))
; Consult me for... stuff
(use-package consult
             :hook (completion-list-mode . consult-preview-at-point-mode)
             :init
             (setq xref-show-xrefs-function #'consult-xref
                   xref-show-definitions-function #'consult-xref)
             :config
             (consult-customize
               consult-theme :preview-key '(:debounce 0.2 any)
               (setq consult-narrow-key "<")))
; Hot and fuzzy!!
(use-package hotfuzz
             :config
             (setq completion-styles '(hotfuzz))
             (setq completion-ignore-case t))

;; OLIVETTI
(use-package olivetti
             :config
             (setq olivetti-minimum-body-width 100))

;; AUTO GIT COMMIT!
(use-package git-auto-commit-mode)
(setq-default gac-ask-for-summary-p nil)
(setq-default gac-silent-message-p t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ORGMODE⬇️;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org
             :init
             :hook (org-mode . (lambda ()
                                 (org-appear-mode) (olivetti-mode) (git-auto-commit-mode)))

             :bind ((:map org-mode-map
                          ("C-c C-x r" . org-metaright)
                          ("C-c C-x l" . org-metaleft)))
             :config
             (setq org-ellipsis " ▾")
             (setq org-src-preserve-indentation nil)
             (setq org-link-frame-setup '((file . find-file)))
             (setq org-startup-folded t)
             (setq org-cycle-separator-lines -1)
             (setq org-hide-emphasis-markers t)
             (setq org-M-RET-may-split-line nil)
             (setq org-fontify-quote-and-verse-blocks t)
             (setq org-tags-column 0)
             (setq org-adapt-indentation nil)
             (setq org-indent-indentation-per-level 3)
             (setq org-todo-keywords '((sequence "TODO(t)" "PROG" "|" "DONE")))
             (setq org-agenda-files '("~/Notes/"))
             (setq org-bookmark-names-plist nil)
             (setq org-log-done 'time)
             (setq org-capture-templates '(
                                           
                                           ("d" "Definitions"
                                            entry (file "~/Notes/1definitions.org")
                                           "* %?")

                                           ("i" "Info")
                                           ("ip" "Info (People)"
                                            entry (file+headline "~/Notes/1info.org" "PEOPLE :people:")
                                            "** %?")
                                           ("ie" "Info (Events)"
                                            entry (file+headline "~/Notes/1info.org" "EVENTS :events:") 
                                            "** %?")
                                           ("io" "Info (Organization)"
                                            entry (file+headline "~/Notes/LibraryOfAlexandria/info.org" "ORGANIZATIONS :organizations:") 
                                            "** %?")
                                           )))

(use-package org-roam
             :after org
             :init
             (setq org-roam-directory "~/Notes/")
             :bind (("C-c r i" . org-roam-node-insert)
                    (:map org-mode-map
                          ("C-c C-j" . jump-to-register)
                          ("C-c r o" . org-id-get-create)
                          ("C-c r l" . org-roam-buffer-toggle)))
             :config
             (setq org-roam-database-connector 'sqlite-builtin)
             (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:20}" 'face 'org-tag)))
             (setq org-roam-completion-everywhere t))

(use-package org-roam-ui 
             :after org
             :defer t)

(use-package org-appear
             :after org
             :defer t)



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#000000"))))
 '(fixed-pitch ((t (:family "Source Code Pro" :height 130))))
 '(org-block ((t (:background nil))))
 '(org-block-begin-line ((t (:background nil))))
 '(org-block-end-line ((t (:background nil))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.4))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
 '(org-quote ((t (:background nil))))
 '(variable-pitch ((t (:family "Source Code Pro" :weight medium)))))
;  _________________________________________
; / Invent and fit; have fits and reinvent! \
; | We toast the Lisp programmer who pens   |
; | his thoughts within nests of            |
; \\ parentheses.                           /
;   ---------------------------------------
;          \   ^__^ 
;           \  (oo)\_______
;              (__)\       )\/\\
;                  ||----w |
;__________________||_____||_________________
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("93011fe35859772a6766df8a4be817add8bfe105246173206478a0706f88b33d"
	 "4b6cc3b60871e2f4f9a026a5c86df27905fb1b0e96277ff18a76a39ca53b82e1"
	 "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8"
	 "f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd"
	 "e978b5106d203ba61eda3242317feff219f257f6300bd9b952726faf4c5dee7b"
	 default))
 '(package-selected-packages nil))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
