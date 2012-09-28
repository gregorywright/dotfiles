(message "Loading .emacs really....")

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(global-auto-revert-mode t)


;;
;; Load PHP mode for stuff
;;
(add-to-list 'auto-mode-alist '("\\.\\(php\\|rmml\\)$" . php-mode))

(autoload 'magit-status "magit" nil t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(setq mac-command-modifier 'meta)
(show-paren-mode 1)

;;The root of all evil is not premature optimization, it is TABs in source code.
(setq-default indent-tabs-mode nil)

;;imenu stuff..
(define-key global-map [(shift down-mouse-3)] 'imenu)
(setq imenu-sort-function 'imenu--sort-by-name)

(setq transient-mark-mode t)
(column-number-mode t)
(pending-delete-mode t )
(line-number-mode t)


(setq scroll-step 1) ;;this will make emacs sooth scroll instead of centering
(setq ps-printer-name "//bagpipe/3N-E-3041B" ) 

(setq scroll-wheel-scroll-amount '(1 ((shift) . 1) ((control))) )
(setq mouse-wheel-progressive-speed nil)

 
;;
;; make new-dabbrev search all buffers all the time, not just
;; the ones in the same major mode.
;;
(load "dabbrev" )
(require 'dabbrev)

(setq dabbrev-friend-buffer-function 'gregs-friend-buffer-function)
(setq dabbrev-always-check-other-buffers t)
(setq dabbrev-abbrev-char-regexp "\\sw\\|\\s_")
(setq dabbrev-case-replace nil )

(add-hook 'emacs-lisp-mode-hook
	  '(lambda () 
	     (set (make-local-variable 'dabbrev-case-fold-search) t)
	     (set (make-local-variable 'dabbrev-case-replace) nil)))
(add-hook 'c++-mode-hook
	  '(lambda () 
	     (set (make-local-variable 'dabbrev-case-fold-search) t )
	     (abbrev-mode 1)
	     (set (make-local-variable 'dabbrev-case-replace) nil)))
(add-hook 'c-mode-hook
	  '(lambda () 
	     (set (make-local-variable 'dabbrev-case-fold-search) t )
	     (set (make-local-variable 'dabbrev-case-replace) nil)))
(add-hook 'text-mode-hook
	  '(lambda () 
	     (set (make-local-variable 'dabbrev-case-fold-search) t)
	     (set (make-local-variable 'dabbrev-case-replace) nil)))


(setq c-basic-offset 4)

(defconst my-c-style
  '("PERSONAL"
    (c-basic-offset                . 4)
    (c-tab-always-indent           . t)
    (c-comment-only-line-offset    . 0)
    (c-hanging-braces-alist        . ((substatement-open  after)
                                      (block-open after)
				      (brace-list-open)))
    (c-hanging-colons-alist        . ((member-init-intro before)
				      (inher-intro)
				      (case-label after)
				      (label after)
				      (access-key after)))
    (c-cleanup-list                . (scope-operator
				      empty-defun-braces
				      defun-close-semi))
    (c-offsets-alist               . ((arglist-close     . c-lineup-arglist)
				      (case-label        . 3)
				      (block-open        . -)
				      (substatement-open  . 0)
				      (knr-argdecl-intro . 6)))
    (c-echo-semantic-information-p . t)
    )
  "My C Programming Style")

;;
;; Customize the cc-mode.
;;
(load "cc-mode")

;; Customizations for both c-mode and c++-mode
(defun my-c-mode-common-hook ()
  ;; set up for my perferred indentation style, but  only do it once
  (let ((my-style "PERSONAL"))
    (or (assoc my-style c-style-alist)
	(setq c-style-alist (cons my-c-style c-style-alist)))
    (c-set-style my-style))
  ;; offset customizations not in my-style
  (setq tab-width 8
	;; this will make sure spaces are used instead of tabs
	indent-tabs-mode nil)
  ;; we like auto-newline and hungry-delete
  (c-toggle-auto-hungry-state 1)
  (setq c-basic-offset 4)
  ;; keybindings for both C and C++.  We can put these in c-mode-map
  ;; because c++-mode-map inherits it
  (define-key c-mode-map [(control m)] 'newline-and-indent)
  )

;; the following only works in Emacs 19
;; Emacs 18ers can use (setq c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c++-mode-hook 'my-c-mode-common-hook)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; All my custom key strokes and bindings....
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key   [backtab]  'dabbrev-expand)
(global-set-key   [(meta =)] 'align-regexp)
(global-set-key   [(meta r)] 'magit-status)
(global-set-key   [(meta p)] 'scroll-down-one )
(global-set-key   [(meta n)] 'scroll-up-one )
(global-unset-key [(control prior)] )
(global-set-key   [(control prior)] 'gregs-beginning-of-defun )
(global-set-key   [(control next)] 'gregs-end-of-defun  	     )
(global-set-key   [(control home)] 'gregs-go-back      	     )        
(global-set-key   (kbd "C-M-]") 'indent-region )
(global-unset-key [(control o)] )
(global-set-key   [(control o)] 'copy-clear-mark)
(global-unset-key [(control x) (f)] )
(global-set-key   [(control x) (f)] 'other-frame)
(global-set-key   [(control return)] 'join-line)
(global-set-key   [(control t)]    'scroll-down )
(global-set-key   [(control /)]    'undo )
(global-set-key   [(meta g)] 'goto-line)	;
(global-set-key   [(control delete)] 'delete-entire-line);; don't like partial delete
(global-set-key   [(control insert)] 'insert-entire-line);; don't like this also
(global-set-key   [(control down)]   'scroll-up-one )
(global-set-key   [(control up)]     'scroll-down-one )
(global-set-key   [(control right)]  'scroll-left-one       )
(global-set-key   [(control left)]   'scroll-right-one      )
(global-set-key   [(control a)] 'my-home)
(global-set-key   [(control e)] 'my-end)

(define-key global-map [(control down-mouse-2)] 'menu-bar-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Here is all my funcs.
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun gregs-other-buffer ()
  "just switches to some buffer"
  (interactive)
  (switch-to-buffer (other-buffer))
  )

(defun gregs-indent-defun ()
  "marks the whole defun and indents"
     (interactive)
  (mark-defun)
  (indent-region indent-region-function nil nil)
  )

(defun delete-entire-line ()
  "Unlike the delete-line function, this deletes the entire line
   regardless of cursor position and scrolls up the rest of the 
   window. The cursor will be left at the same cursor position or
   at the end of line, whichever is smaller."
  (interactive)
  (defvar KillWholeLine nil "Local var for delete-entire-line" )
  (defvar CurrentColumn nil "Local var for delete-entire-line" )
  (setq KillWholeLine kill-whole-line)
  (setq CurrentColumn (current-column))
  (setq kill-whole-line 1)
  (beginning-of-line)
  (kill-line nil)
  (setq kill-whole-line KillWholeLine )
  (beginning-of-line)
  )

(defun insert-entire-line ()
  "Unlike the open-line function, this inserts an entire line
   and scrolls down the rest of the window. It shouln't matter where the
   cursor is. oh, it doesn't really work well though..... :-("
  (interactive)
  (beginning-of-line)
  (open-line 1)
  )
(defun scroll-up-one ()
  (interactive)
  (scroll-up 1)
  )
(defun scroll-down-one ()
  (interactive)
  (scroll-down 1)
  )


(defun copy-clear-mark ()
  "Just copies the region and clears the mark."
  (interactive)
  (setq deactivate-mark t)
  (copy-region-as-kill (region-beginning) (region-end))
  )



(defun my-grep ()
  "grep the whole directory for something defaults to term at cursor position"
  (interactive)
  (setq default (thing-at-point 'symbol))
  (setq needle (or (read-string (concat "grep for <" default "> ")) default))
  (setq needle (if (equal needle "") default needle))
  (grep (concat "egrep -s -i -n -r --exclude=\\.svn " needle " ~real/greg-vg/htdocs /dev/null")))
(global-set-key "\C-x." 'my-grep)


(defun gregs-friend-buffer-function (other-buffer)
  t );;This will always return true no matter what other-buffer is
      ;; so that dabrev will always search every buffer.


(defun gregs-string-rectangle (command)
  "Set the rectangle then call. String will replace the rectangle on each line."
  (interactive "sString: \n")
  (setq pp (point))
  (setq mm (mark))
  (kill-rectangle mm pp)
  (string-rectangle mm pp command)
  )

(defun gregs-mark-whole-word ()
  "Mark whole word"
  (interactive)
  (backward-word 1)
  (mark-word 1))


(defun gregs-beginning-of-defun ()
  "Save point to register then go to begin of defun use C-home to get back"
  (interactive)
  (point-to-register 'Z)
  (beginning-of-defun))

(defun gregs-end-of-defun ()
  "Save Point to register the go to end of defun use c-home to get back"
  (interactive)
  (point-to-register 'Z)
  (end-of-defun))

(defun gregs-go-back ()
  "get back to register Z"
  (interactive)
  (jump-to-register 'Z))
  
(defun join-line ()
  "Join line with next line down"
  (interactive)
  (end-of-line)
  (kill-line)
  (delete-horizontal-space)
  )

(defun beginning-of-next-defun ()
  "Go to beginning brace of next function"
  (interactive)
  (end-of-defun)
  (end-of-defun)
  (beginning-of-defun))

(defun scroll-left-one ()
  "Just scroll left one char"
  (interactive)
  (if (equal (current-column) 0)
      (scroll-left 2)
    ;;else
    (scroll-left 1)))

(defun scroll-right-one ()
  "Just scroll right one char"
  (interactive)
  (scroll-right 1))

(defun gregs-scroll-under-cursor-up ()
  "scrolls the window up underneath the cursor."
  (interactive)
  (scroll-up 1)(next-line 1))

(defun gregs-scroll-under-cursor-down ()
  "scrolls the window down underneath the cursor."
  (interactive)
  (scroll-down 1)(previous-line 1))


(defun find-curr-file-again ()
  "Read in the current file again, READONLY (t) or not (nil)."
  (interactive)
  (setq pname (buffer-file-name))
  (setq linenum (1+ (count-lines 1 (point))))
  (kill-buffer (buffer-name))
  (find-file pname)
  (goto-line linenum)
  )

(defun toggle-truncate ()
  "Toggles the value of truncate-line"
  (interactive)
  (if (equal truncate-lines nil)
      (setq truncate-lines t)
    ;;else
    (setq truncate-lines nil))
  (redraw-display))

(defun raise-buffer ()
  (interactive)
  (let ((blist (nreverse (buffer-list))))
    (while (string-match "\\` " (buffer-name (car blist)))
      (setq blist (cdr blist)))
    (if blist
        (switch-to-buffer (car blist)))))


(defun bury-or-raise-buffer (&optional arg)
  "Bury the buffer.  If arg, raise the most-recently-buried one."
  (interactive "P")
  (if arg
      (raise-buffer)
    (bury-buffer)))

(defun my-switch-to-buffer ()
  "This will switch between the two most recent buffers"
  (interactive)

  (switch-to-buffer nil)
  )
(defun my-home ()
  "If current column is greater than 0, goes to column 0.
Otherwise, if not at top of current window, goes to top of window.
Otherwise, goes to beginning of buffer."
  (interactive)
  (if (> (current-column) 0)            ; not at column 0, goto start of line
      (beginning-of-line)
    ;; else
    (if (not (eq (point) (window-start))) ; not at top of window, goto to top
        (move-to-window-line 0)
      ;; else
      (goto-char (point-min)))))	; at top of window, goto top of file

(defun my-end ()
  "If not at end of current line, goes to end of line.
Otherwise, if not at bottom of current window, goes to bottom of window.
Otherwise, goes to end of buffer."
  (interactive)
  (setq oldpoint (point))               ; save original point
  (if (not (eolp))                      ; if not at end of line,
      (end-of-line)                     ;    go to end of line
    ;; else
    (move-to-window-line -1)            ; otherwise, goto end of window
    (end-of-line)
    (if (eq oldpoint (point))           ; if still at original point,
        (goto-char (point-max)))))      ;    goto end of buffer


(defun shell-command-verbose (command)
  "Execute COMMAND in shell with message."
  (interactive "sCommand: \n")
  (message (concat "Executing: " command " ..."))

  (shell-command command)
  (message "Done")
  ) 

(defun quote-string (string)
  "Enclose STRING in single or double quotes."
  (setq has-double (string-match "\"" string))
  (setq has-single (string-match "'" string))
  (cond
   ((or (and (not has-single) (not has-double))
	(and has-double (not has-single)))
    (concat "'" string "'"))
   ((and has-single (not has-double))
    (concat "\"" string "\""))
   (t
    (message (concat "Can't quote string correctly: " string))
    (sleep-for 3)
    (concat "\"" string "\""))
   )
  )
(put 'narrow-to-region 'disabled nil)


(setq-default ispell-program-name "aspell")

(require 'tramp)

(setq minibuffer-max-depth nil)

(menu-bar-mode 0)

;; turn off the annoying newbie messages
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-screen t)

; emacs occasionally wants my email address for some reason
(setq user-mail-address "gwright@real.com")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(menu-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun upcase-rectangle (b e)
  "change chars in rectangle to uppercase"
  (interactive "r")
  (apply-on-rectangle 'upcase-rectangle-line b e))

(defun upcase-rectangle-line (startcol endcol)
  (when (= (move-to-column startcol) startcol)
    (upcase-region (point)
                   (progn (move-to-column endcol 'coerce)
                          (point)))))
