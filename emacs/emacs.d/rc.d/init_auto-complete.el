(require 'auto-complete)
(require 'go-autocomplete nil t)
(require 'auto-complete-config)
;;OS判別
(eval-when-compile (load-file "~/.emacs.d/init/ostype.el"))
;補完。auto-completeがあるから要らないかも
(define-key global-map "\C-c\C-i" 'dabbrev-expand)
;; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                         (auto-complete-mode 1))
                       ))
(ac-set-trigger-key "TAB")
(when run-linux
  (when (require 'auto-complete-etags nil t)
    (add-to-list 'ac-sources 'ac-source-etags)))
;;補完候補をC-n/C-pでも選択できるように
;;Vimmerには嬉しいかも。
(add-hook 'auto-complete-mode-hook
          (lambda ()
            (define-key ac-completing-map (kbd "C-n") 'ac-next)
            (define-key ac-completing-map (kbd "C-p") 'ac-previous)))
(real-global-auto-complete-mode t)
(provide 'init_auto-complete)
