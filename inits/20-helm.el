(require 'helm)

(global-set-key (kbd "M-z") 'zop-up-to-char)

;; backup を作らない
(setq make-backup-files nil)

;; yasnippet の設定

(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
        "~/.emacs.d/yasnippets"
        "~/.emacs.d/snippets"
        ))



;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)n



(yas-global-mode 1)

(auto-insert-mode 1)

;; helmでripgrep検索する
(setq helm-ag-base-command "rg --vimgrep --no-heading")

(global-set-key (kbd "C-u") 'helm-ag)
