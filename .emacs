;;;must key
(global-set-key (kbd "M-h") (lambda () (interactive) (find-file "~/.emacs")))
(global-set-key (kbd "M-m") 'set-mark-command)
(global-set-key (kbd "C-x k") (lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c g") 'gdb-many-windows)
(global-set-key (kbd "C-c o") 'occur)
(global-set-key (kbd "M-o") 'jr-find-alt-buf-or-file)
(global-set-key (kbd "M-,") 'copy-word-under-cursor)
(global-set-key (kbd "M-.") 'tags-apropos)
(global-set-key (kbd "C-c c") 'new-c-o)
(global-set-key (kbd "C-c r") 'new-tags-aprops)
(global-set-key (kbd "C-x C-p") 'pop-global-mark)
(global-set-key (kbd "M-n") 'forward-list)
(global-set-key (kbd "M-p") 'backward-list)
(global-set-key (kbd "C-x f") 'find-name-dired)

;;;must mode
(ido-mode)
(transient-mark-mode t)
(global-linum-mode t)
(require 'uniquify)
;;;(load-file "/usr/share/emacs/site-lisp/xcscope.el")
(add-to-list 'load-path "~/mkenvfile/")
(add-to-list 'load-path "~/mkenvfile/xcscope/")
(load-file "~/mkenvfile/xcscope/xcscope.el")
(require 'xcscope)
(cscope-setup)
(setq uniquify-buffer-name-style 'reverse)

;;;must UI
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))


;;;;;;;;;;;;;;;;;;;;;;;;must jr code
(defun jr-flip-file-name (fn)
  (cond ((string-match ".*\\.cpp" fn)
	 (replace-regexp-in-string "\\.cpp" ".h" fn))
	((string-match ".*\\.h" fn)
	 (replace-regexp-in-string "\\.h" ".cpp" fn))
	(t "")))
(defun jr-find-alt-buf-or-file ()
  "switch between .h .cpp"
  (interactive)
  (let* ((fn (buffer-name))
	 (ffn (buffer-file-name))
	 (fn-new (jr-flip-file-name fn))
	 (ffn-new (jr-flip-file-name ffn)))
    (cond ((memq (get-buffer fn-new)
		 (buffer-list))
	   (switch-to-buffer (get-buffer fn-new)))
	  ((and (> (length ffn-new) 0) (file-exists-p ffn-new))
	   (find-file ffn-new)))))
;;;;;;;;;;;;;;;;;;;;;;;;jr code end

;;;must hook
(defun my-c-mode-hook ()
  (c-set-style "stroustrup"))
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
(setq jr-customize-bg-color "black")
;(when window-system
;  (setq jr-customize-bg-color "#314f4f"))
					;(server-start)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default-tab-width 4 t)
 '(inhibit-startup-screen t)
 '(find-program "find")
 '(truncate-lines t))
;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(default ((t (:background "#314f4f")))))
; '(default ((t (:background "#314f4f")))))
; '(default ((t (:background "#314f4f")))))


(when (not window-system)
  (custom-set-faces
   '(default ((t (:background "black"))))))

;remember to set CYGWIN=nodosfilewarning
(defun ido-wide-find-dirs-or-files (dir file &optional prefix finddir)
  ;; As ido-run-find-command, but returns a list of cons pairs ("file" . "dir")
  (let ((filenames
  (split-string
   (shell-command-to-string
         (concat find-program " " ;"cygfind "
     (shell-quote-argument dir)
                   " -iname .svn -prune " " -or "
                   " -iname CVS -prune " " -or "
                   " -iname uiq -prune " " -or "
     " -iname "
     (shell-quote-argument
      (concat (if prefix "" "*") file "*"))
     " -type " (if finddir "d" "f") " -print"))))
 filename d f
 res)
    (while filenames
      (message find-program)
      (setq filename (car filenames)
     filenames (cdr filenames))
      (if (and (or (string-match "^/" filename) (string-match "^.:" filename))
        (file-exists-p filename))
   (setq d (file-name-directory filename)
  f (file-name-nondirectory filename)
  res (cons (cons (if finddir (ido-final-slash f t) f) d) res))))
    res))

(defun jr-global-root-file ()  
  (interactive)
  (require 'compile)
  (ignore-errors (kill-buffer "*GROOT*"))  
  (save-excursion  
    (let ((buf)  
          (name (read-string "Name:" (thing-at-point 'symbol))))  
      (setq buf (pop-to-buffer "*GROOT*"))  
      (setq name (replace-regexp-in-string "\\*" ".*" name))  
      (make-local-variable 'compilation-error-regexp-alist)  
      (while (or (not (file-exists-p ".cr_root"))  
                 (not (string-match "/\\|\\(.:/\\)" default-directory)))  
        (cd ".."))  
      (when (not (file-exists-p ".cr_root"))  
        (message "no .cr_root founded"))  
      (add-to-list 'compilation-error-regexp-alist  
                   '("\\([^\n\r ]+\\)" 1))
      (start-process "GROOT" buf "grep" "-i" name ".cr_root")  
      (set-process-sentinel (get-buffer-process (current-buffer))  
                            (lambda (process event)  
                              (when (string-match "finished" event)  
                                (goto-char (point-max))  
                                (insert  
                                 (format "Process: %s had finished" process))  
                                (goto-char (point-min))  
                                (font-lock-mode 1)
                                (compilation-minor-mode)))))))
;;不产生备份文件
(setq make-backup-files nil)
(setq x-select-enable-clipboard t)
;(run-with-idle-timer 0.001 nil 'w32-send-sys-command 61488)
;(cd "F:\\UCMbranches\\8_7_webapp\\")
;(setq default-directory "F:\\UCMbranches\\8_7_webapp\\")
;最大化
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
)
;启动时最大化
;(set-face-attribute 'default nil :height 110)
(setq frame-title-format '((:eval default-directory)))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(set-face-attribute 'default nil :height 100)
;(fset 'copy-word-under-cursor
;   [?\C-\M-b ?\C-  ?\C-\M-f ?\C-x ?r ?s ?l ?\M-x ?t ?i ?: ?: ?t ?- ?u ?n ?m ?a ?r ?k ?- ?r ?e ?g ?i ?o ?n return])
(fset 'copy-word-under-cursor
   [?\C-\M-b ?\C-  ?\C-\M-f ?\M-w ])

(fset 'new-c-o
   [?\C-\M-b ?\C-  ?\C-\M-f ?\M-w ?\M-x ?o ?c ?c ?u ?r return ?\C-y return])

(fset 'new-tags-aprops
   [?\C-\M-b ?\C-  ?\C-\M-f ?\M-w ?\M-x ?t ?a ?g ?s ?- ?a ?p ?r ?o ?p ?o ?s return ?\C-y return])
(add-to-list 'load-path "~/mkenvfile/color-theme/")
(load-file "~/mkenvfile/color-theme/color-theme.el")
(require 'color-theme)
(color-theme-initialize)
(color-theme-clarity)
(defun switch-full-screen ()
      (interactive)
      (shell-command "wmctrl -r :ACTIVE: -btoggle,maximized_vert,maximized_horz"))
(switch-full-screen)
(set-face-attribute 'default nil :height 120)
(setq find-name-arg "-iname")
