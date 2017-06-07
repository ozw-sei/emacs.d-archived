;; パッケージのp設定
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)


(package-initialize)

(require 'cask "$HOME/.cask/cask.el")
(cask-initialize)

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")

(add-to-list 'load-path "~/.emacs.d/elisp")


(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

;;; タブの先頭に[X]を表示しない
(setq elscreen-tab-display-kill-screen nil)
;;; header-lineの先頭に[<->]を表示しない
(setq elscreen-tab-display-control nil)
;;; バッファ名・モード名からタブに表示させる内容を決定する(デフォルト設定)
(setq elscreen-buffer-to-nickname-alist
      '(("^dired-mode$" .
         (lambda ()
           (format "Dired(%s)" dired-directory)))
        ("^Info-mode$" .
         (lambda ()
           (format "Info(%s)" (file-name-nondirectory Info-current-file))))
        ("^mew-draft-mode$" .
         (lambda ()
           (format "Mew(%s)" (buffer-name (current-buffer)))))
        ("^mew-" . "Mew")
        ("^irchat-" . "IRChat")
        ("^liece-" . "Liece")
        ("^lookup-" . "Lookup")))
(setq elscreen-mode-to-nickname-alist
      '(("[Ss]hell" . "shell")
        ("compilation" . "compile")
        ("-telnet" . "telnet")
        ("dict" . "OnlineDict")
        ("*WL:Message*" . "Wanderlust")))

(setenv "PYTHONPATH" "~/venv/bin/python")

(elpy-enable)

(defun turn-on-flycheck-mode ()
  (flycheck-mode 1))

(add-hook 'python-mode-hook 'turn-on-flycheck-mode)

(require 'ng2-mode)

; 必要なパッケージのロード
(require 'go-mode)
(require 'company-go)

;; 諸々の有効化、設定
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook (lambda()
           (add-hook 'before-save-hook' 'gofmt-before-save)
           (local-set-key (kbd "M-.") 'godef-jump)
           (set (make-local-variable 'company-backends) '(company-go))
           (company-mode)
           (setq indent-tabs-mode nil)    ; タブを利用
           (setq c-basic-offset 4)        ; tabサイズを4にする
           (setq tab-width 4)))

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

 ;; ビープ音禁止
 (setq ring-bell-function 'ignore)

(require 'disable-mouse)
(global-disable-mouse-mode)


;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; C-sで絞り込む
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; TABで候補を設定
(define-key company-active-map (kbd "C-i") 'company-complete-selection)

;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key company-mode-map (kbd "C-:") 'company-complete)

(add-hook 'after-init-hook 'global-company-mode)

(require 'jedi-core)
(setq jedi:complete-on-dot t)
(setq jedi:use-shortcuts t)
(add-hook 'python-mode-hook 'jedi:setup)
(add-to-list 'company-backends 'company-jedi)

;; 自動改行しない
(setq auto-fill-mode 0)

(require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(require 'tide)
(add-hook 'typescript-mode-hook
          (lambda ()
            (tide-setup)
            (flycheck-mode t)
            (setq flycheck-check-syntax-automatically '(save mode-enabled))
            (eldoc-mode t)
            (company-mode-on)))

(exec-path-from-shell-initialize)

(setq howm-menu-lang 'ja)
(require 'howm-mode)

(setq howm-file-name-format "%Y/%m/%Y_%m_%d.txt")

(global-set-key "\C-c,," 'howm-menu)
(autoload 'howm-menu "howm-mode" "Hitori Otegaru Wiki Modoki" t)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)


;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)


;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)


;; Newline at end of file
(setq require-final-newline t)


;; delete the selection with a keypress
(delete-selection-mode t)


(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)


;; misc useful keybindings
(global-set-key (kbd "s-<") #'beginning-of-buffer)
(global-set-key (kbd "s->") #'end-of-buffer)


(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)


(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(set-face-attribute 'default nil :height 100)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (py-autopep8 esup noflet haskell-emacs haskell-mode ddskk zop-to-char web-mode use-package undohist undo-tree tide solarized-theme smartparens rust-mode recentf-ext quickrun popwin point-undo open-junk-file ng2-mode multiple-cursors magit js2-mode jedi-core init-loader idle-highlight-mode htmlize howm helm-ls-git helm-ghq helm-ag git-gutter-fringe+ flycheck-pos-tip flycheck-cask expand-region exec-path-from-shell ensime elscreen elpy drag-stuff dockerfile-mode disable-mouse dired-toggle dired-details company-go cask browse-kill-ring ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(exec-path-from-shell-initialize)


;; make what-whereでSKK modulesで表示されるディレクトリを指定
(add-to-list 'load-path "/usr/share/emacs25.2/site-list/skk")
;; M-x skk-tutorialでNo file found as 〜とエラーが出たときにskk-tut-fileを設定
;; make what-whereでSKK tutorialsで表示されるディレクトリ上のSKK.tutを指定
(setq skk-tut-file "/usr/share/skk/SKK.tut")
(require 'skk)
(global-set-key "\C-x\C-j" 'skk-mode)

(setq skk-dcomp-activate t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/theme")
(load-theme 'solarized t)

(defun reload-font ()
  (interactive)
  ;;GNU/Linux
  (when (and (eq system-type 'gnu/linux) window-system)
    (set-face-attribute 'default nil :family "Ritcty" :height 140)
    (set-fontset-font (frame-parameter nil 'font)
                      'japanese-jisx0208
                      (font-spec :family "IPAGothic"))
    (add-to-list 'face-font-rescale-alist
                 '("Noto Sans Mono CJK JP" . 1.0))  
    )
  )

(reload-font)

(require 'point-undo)
(global-set-key (kbd "C-<") 'point-undo)
(global-set-key (kbd "C->") 'point-redo)

(require 'py-autopep8)
;; 保存時にバッファ全体を自動整形する
(add-hook 'before-save-hook 'py-autopep8-before-save)
