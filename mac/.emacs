(message "Loading .emacs really....")

(global-auto-revert-mode t)

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(setq mac-command-modifier 'meta)
;;
;; first things first. Add out private elisp directory to the
;; load path.
;;
(setq load-path (cons "~/elisp" load-path))

;(load "~/.emacs_addons/paredit/paredit.el")
;(load "~/.emacs_addons/haskell-mode/haskell-site-file")
;(load "~/.emacs_addons/php-mode.el")
;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;;
;; uncomment this to do common lisp stuff. Leave it out to do clojure.
;;

;;(add-to-list 'load-path "~/.emacs_addons/slime-2012-05-24/")  ; your SLIME directory
(setq inferior-lisp-program "/usr/local/bin/sbcl") ; your Lisp system
;;(require 'slime)
;;(slime-setup '(slime-fancy))
;;(slime-setup)

;;;;;;;; END LISP stuff..........




(global-set-key [(meta =)] 'align-regexp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Put XEmacs and Emacs specific code here
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(cond
 ( (string-match "XEmacs" emacs-version)
   ;; XEmacs CODE HERE!
   ( global-set-key [(shift tab)] 'dabbrev-expand)
   ( global-unset-key [(control x) r t] )       
   ( global-set-key [(control x) r t] 'replace-rectangle )

   (custom-set-variables
;;    '(fast-lock-mode t nil (fast-lock))
    '(paren-mode (quote paren) nil (paren))
    '(toolbar-visible-p nil)
    '(indent-tabs-mode nil)
;;    '(lazy-shot-stealth-time 5)
    '(font-lock-maximum-size 99999999)
;;    '(lazy-shot-mode t nil (lazy-shot))
    )
   (custom-set-faces
    '(font-lock-preprocessor-face ((((class color) (background dark)) (:foreground "orchid"))))
    '(font-lock-keyword-face ((((class color) (background dark)) (:foreground "purple"))))
    '(font-lock-type-face ((((class color) (background dark)) (:foreground "green"))))
    '(font-lock-comment-face ((((class color) (background dark)) (:foreground "firebrick"))))
    '(font-lock-function-name-face ((((class color) (background dark)) (:foreground "blue"))))
    )
   )
 (t
  ;; all other versions here....
  (require 'msb)
  (define-key global-map [(control down-mouse-1)] 'msb )
  (show-paren-mode 1)
  (setq frame-background-mode nil)
  (setq default-frame-alist
	'((top . 25) (left . 230)
	  (width . 80) (height . 38)
;;	  (font . "10x20")
	  (cursor-color . "yellow" )
	  (foreground-color .  "white" )
	  (background-color . "black" )
	  ;;	(font . "-*-Courier New-normal-r-*-*-17-102-*-*-c-*-*-ansi-")
	  ))
  ;;(setq initial-frame-alist '((top . 0) (left . 75)))
  (cond 
   ((fboundp 'global-font-lock-mode)
    ;; Turn on font-lock in all modes that support it
    (global-font-lock-mode t)
    ;;       (add-hook 'java-mode-hook 'turn-on-font-lock)
    ;; Maximum colors
    (setq font-lock-maximum-decoration t))
   )
  ( global-set-key [(shift tab)]  'dabbrev-expand)
  ) ;; other
 )

;; PHP mode
;(require 'php-mode)
;; To use abbrev-mode, add lines like this:
;(add-hook 'php-mode-hook
;'(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))


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
;; Add some Realnetworks specific datatypes to the syntax
;; coloring list





;;
;; Now add the dmacro package. Lots of cool stuff it does! 
;;
;;(require 'dmacro)
;;(dmacro-load "~/elisp/demo.dm")

;;
;; turn on abbrev mode
;;
(load "abbrev" )
(define-global-abbrev "fp" "fprintf( stderr, \"\\n\" );" )
(define-global-abbrev "dumpit" "{\nchar szBuff[256];\nsprintf( szBuff,\"\\n\");\n_DumpString(szBuff);\n}" )

;;(define-global-abbrev "for" "for( ; ; )\n{\n}" )

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
    (c-hanging-braces-alist        . ((block-open after)
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

;; I don't like case sensitive searches.
;;(setq isearch-case-fold-search nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; All my custom key strokes and bindings....
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

( global-set-key [(meta p)] 'scroll-down-one )
( global-set-key [(meta n)] 'scroll-up-one )
( global-unset-key [(control prior)] )
( global-set-key [(control prior)] 'gregs-beginning-of-defun )
( global-set-key [(control next)] 'gregs-end-of-defun  	     )
( global-set-key [(control home)] 'gregs-go-back      	     )        

( global-unset-key [(control o)] )
( global-set-key   [(control o)] 'copy-clear-mark)

( global-unset-key [(control x) (f)] )
( global-set-key   [(control x) (f)] 'other-frame)

( global-set-key   [(control return)] 'join-line)

( global-set-key [(control t)]    'scroll-down )
( global-set-key [(control /)]    'undo )

(global-set-key [(meta g)] 'goto-line)	;
(global-set-key [(control delete)] 'delete-entire-line);; don't like partial delete
(global-set-key [(control insert)] 'insert-entire-line);; don't like this also

(define-key global-map [(control down-mouse-2)] 'menu-bar-mode)
( global-set-key [(control down)]   'scroll-up-one )
( global-set-key [(control up)]     'scroll-down-one )
( global-set-key [(control right)]  'scroll-left-one       )
( global-set-key [(control left)]   'scroll-right-one      )
( global-set-key [(control f12)]    'bookmark-jump         )
( global-set-key [f12]      'bookmark-set          )
( global-set-key [(control a)] 'my-home)
( global-set-key [(control e)] 'my-end)
( global-set-key [(control d)] 'c-electric-delete-forward)
( global-set-key [\d] 'c-electric-delete)
( global-set-key [f1] 'compile)
( global-set-key [f2] 'next-error)
( global-set-key [(control f2)] 'previous-error)
( global-set-key [f3] 'goto-line)
( global-set-key [f4] 'isearch-forward)
( global-set-key [(control f5)] 'find-curr-file-again)
( global-set-key [f5] 'font-lock-fontify-buffer)
( global-set-key [f6] 'other-window)
( global-set-key [f7] 'bury-or-raise-buffer)
( global-set-key [f8] 'my-switch-to-buffer)


(global-set-key (kbd "<delete>") 'c-hungry-delete-forward)
(global-set-key (kbd "<backspace>") 'c-hungry-delete-backwards)







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
  (grep (concat "egrep -RI --exclude=\*.svn\* -s -i -n " needle " * /dev/null")))
(global-set-key "\C-x." 'my-grep)


(defun gregs-friend-buffer-function (other-buffer)
  t );;This will always return true no matter what other-buffer is
      ;; so that dabrev will always search every buffer.

(defun insert-rahul-file (command)
  "Insert a group of lines that will open FILE and write to it."
  (interactive "sFile Name: \n")
  (message (concat "Insert famous Rahul file code for file " command " ..."))
  (insert "\n{" )
  (indent-for-tab-command)
  (insert (concat "\nFILE* pFP=fopen(\"" command) )
  (insert "\", \"a+\");" )
  (indent-for-tab-command)
  (insert "\nif( pFP )" )
  (indent-for-tab-command)
  (insert "\n{" )
  (indent-for-tab-command)
  (insert "\nfprintf( pFP, \"\\n\");" )
  (indent-for-tab-command)
  (insert "\nfclose( pFP );" )
  (indent-for-tab-command)
  (insert "\n}" )
  (indent-for-tab-command)
  (insert "\n}" )
  (indent-for-tab-command)
  )

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
(add-to-list 'exec-path "/usr/local/bin")

(require 'tramp)

(setq tramp-default-method "ssh")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(background-color "#042028")
 '(background-mode dark)
 '(c++-font-lock-extra-types (quote ("\\sw+_t" "\\([iof]\\|str\\)+stream\\(buf\\)?" "ios" "string" "rope" "list" "slist" "deque" "vector" "bit_vector" "set" "multiset" "map" "multimap" "hash\\(_\\(m\\(ap\\|ulti\\(map\\|set\\)\\)\\|set\\)\\)?" "stack" "queue" "priority_queue" "iterator" "const_iterator" "reverse_iterator" "const_reverse_iterator" "reference" "const_reference" "INT32" "ULONG32" "PN_RESULT" "LONG32" "ULONG" "PNxRect" "UINT" "UINT32" "INT" "UINT16" "PNxWindow" "PNxSize" "PNxEvent" "BOOL" "Bool" "PNxPoint" "Display" "REFIID" "PNxDC" "UCHAR" "REGION" "Window" "XEvent" "IUnknown")))
 '(column-number-mode t)
 '(cursor-color "#708183")
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(dabbrev-case-fold-search t)
 '(default-justification (quote full))
 '(ecb-options-version "2.11")
 '(fill-column 80)
 '(font-lock-maximum-size 99999999)
 '(font-lock-mode t t (font-lock))
 '(foreground-color "#708183")
 '(grep-command "rgrep -n -i -R \"*.[ch]*\"  ")
 '(gutter-buffers-tab-visible-p nil)
 '(indent-tabs-mode nil)
 '(make-backup-files nil)
 '(mouse-avoidance-mode nil nil (avoid))
 '(paren-mode (quote paren) nil (paren))
 '(query-user-mail-address nil)
 '(scrollbars-visible-p t)
 '(show-paren-mode t)
 '(tab-stop-list (quote (8 12 16 20 24 28 32 36 40 44 48 52 56 60 64)))
 '(tab-width 8)
 '(tool-bar-mode nil)
 '(toolbar-visible-p nil)
 '(transient-mark-mode (quote (only . t)))
 '(user-mail-address "gwright@real.com"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "white" :background "black"))))
 '(font-lock-comment-face ((((class color) (background dark)) (:foreground "firebrick"))))
 '(font-lock-function-name-face ((((class color) (background dark)) (:foreground "gold"))))
 '(font-lock-keyword-face ((((class color) (background dark)) (:foreground "purple"))))
 '(font-lock-preprocessor-face ((((class color) (background dark)) (:foreground "orchid"))))
 '(font-lock-type-face ((((class color) (background dark)) (:foreground "green")))))

(setq minibuffer-max-depth nil)

(message "turn off tool bar")
(tool-bar-mode -1)

;; turn off the annoying newbie messages
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-screen t)

; emacs occasionally wants my email address for some reason
(setq user-mail-address "gwright@real.com")



;; resize the initial emacs window
(setq initial-frame-alist '((width . 120)
                            (height . 55)))
(setq default-frame-alist '((width . 120)
                            (height . 55)))


;;(set-default-font "-apple-profont-medium-r-*-*-*-*-*-*-*-*-*-*")
