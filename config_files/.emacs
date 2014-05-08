; ******** Automatically install packages ********
(require 'package)
; list packages
(setq package-list '(elpy color-theme-solarized yaml-mode virtualenv ag))
; list repositories containing packages
(setq package-archives 
      '(
	("melpa" . "http://melpa.milkbox.net/packages/")
	("elpy" . "http://jorgenchaefer.github.io/packages/")
))
; activate all the packages
(package-initialize)
; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))
; install missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

; ******** System detection functions ********
(defun system-is-mac ()
  (interactive)
  (string-equal system-type "darwin"))

(defun system-is-linux ()
  (interactive)
  (string-equal system-type "gne/linux"))

; ******** Emacs Cocoa customizations ********
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
 
(if (and (system-is-mac) window-system) (set-exec-path-from-shell-PATH))

; ******** Mac specific ********
(if (system-is-mac)
    (setq ns-command-modifier 'meta))

; ******** Gui specific ********
(if (window-system) (progn
    (load-theme 'solarized-dark 1)
))

; ************************************************************

(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

(require 'ido)
(ido-mode t)

(require 'tramp)
(setq tramp-default-method "ssh")

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.sls\\'" . yaml-mode))

(require 'org)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done 1)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))
(setq org-confirm-babel-evaluate nil)

(elpy-enable)
(elpy-use-ipython)

(global-linum-mode 1)
(show-paren-mode 1)
