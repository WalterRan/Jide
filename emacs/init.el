(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
     ("http" . "10.144.1.11:8080")
     ("https" . "10.144.1.11:8080")))

(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Failed to verify signature archive-contents.sig:
;; Looks like a bug in your version of Emacs.
(setq package-check-signature nil)

(add-to-list 'load-path "~/.emacs.d/custom")

;; (require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)

(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))
