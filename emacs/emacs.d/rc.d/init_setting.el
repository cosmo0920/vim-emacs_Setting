;; 同名のファイルを開いたとき親のディレクトリ名も表示
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;;for magit
(autoload 'magit "magit" "Emacs git client." t)
;; ファイルの履歴
(require 'recentf)
(when (locate-library "recentf")
  (require 'recentf-ext)
  (recentf-mode t)
  (setq recentf-exclude '("^\\.emacs\\.bmk$"))
  (setq recentf-auto-cleanup 'never) ;;tramp対策。
  (setq recentf-max-menu-items 10)
  (setq recentf-max-saved-items 20)
  (recentf-mode 1)
)
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(cond
 ((equal (file-exists-p "/usr/bin/zsh") t)
  (shell-pop-set-internal-mode-shell "/usr/bin/zsh"))
 ((equal (file-exists-p "/bin/zsh") t)
  (shell-pop-set-internal-mode-shell "/bin/zsh"))
 ((equal (file-exists-p "/bin/bash") t)
  (shell-pop-set-internal-mode-shell "/bin/bash"))
 ((equal (file-exists-p "/bin/dash") t)
  (shell-pop-set-internal-mode-shell "/bin/dash")) 
 ((equal (file-exists-p "/usr/bin/tcsh") t)
  (shell-pop-set-internal-mode-shell "/usr/bin/tcsh")) 
 ((equal (file-exists-p "/usr/bin/csh") t)
  (shell-pop-set-internal-mode-shell "/usr/bin/csh")) 
 (t
  (shell-pop-set-internal-mode-shell "/bin/sh")))
;;shell-pop.elの設定
(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook
          (function
           (lambda ()
             (define-key term-raw-map "\C-t" 'shell-pop))))
(defadvice ansi-term (after ansi-term-after-advice (arg))
  "run hook as after advice"
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)
(global-set-key "\C-t" 'shell-pop)
;; use shift + arrow keys to switch between visible buffers
(require 'windmove)
(windmove-default-keybindings)
;;C-RET RET -- cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil) ;; 変なキーバインド禁止
;; basic
(define-key global-map (kbd "C-z") 'undo)                 ; undo
(define-key global-map (kbd "M-C-g") 'grep)               ; grep
(require 'whitespace)
(setq whitespace-style '(face              ; faceを使って視覚化する。
                         trailing          ; 行末の空白を対象とする。
                         lines-tail        ; 長すぎる行のうち
                                           ; whitespace-line-column以降のみを
                                           ; 対象とする。
                         space-before-tab  ; タブの前にあるスペースを対象とする。
                         space-after-tab)) ; タブの後にあるスペースを対象とする。
;; デフォルトで視覚化を有効にする。
(global-whitespace-mode 1)
;;; 行の先頭でC-kを一回押すだけで行全体を消去する
(setq kill-whole-line t)
;;to ensure that your files have no trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(provide 'init_setting)
