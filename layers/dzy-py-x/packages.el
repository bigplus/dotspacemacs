;;; packages.el --- dzy-py-x layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: yp-tc-m-2505 <yp-tc-m-2505@yp-tc-m-2505deMacBook-Air.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `dzy-py-x-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `dzy-py-x/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `dzy-py-x/pre-init-PACKAGE' and/or
;;   `dzy-py-x/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst dzy-py-x-packages
  '(elpy
    jedi-direx)
  "The list of Lisp packages required by the dzy-py-x layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


(defun dzy-py-x/init-elpy ()
  (use-package elpy
    :diminish elpy-mode
    :config
    ;; -------------------------START : https://github.com/TheBB/elpy-layer---------------------------------------
    ;; Elpy removes the modeline lighters. Let's override this
    (defun elpy-modules-remove-modeline-lighter (mode-name))
    (setq elpy-modules '(elpy-module-sane-defaults
                         elpy-module-eldoc
                         elpy-module-pyvenv))

    (when (configuration-layer/layer-usedp 'auto-completion)
      (add-to-list 'elpy-modules 'elpy-module-company)
      (add-to-list 'elpy-modules 'elpy-module-yasnippet))

    ;; -------------------------STOP : https://github.com/TheBB/elpy-layer---------------------------------------

    (progn
      (elpy-enable)))
  )

(defun dzy-py-x/init-jedi-direx ()
  (use-package jedi-direx
    :config
    (progn
      (eval-after-load "python"
        '(define-key python-mode-map "\C-cx" 'jedi-direx:pop-to-buffer))
      (add-hook 'jedi-mode-hook 'jedi-direx:setup)))
  )

;;; packages.el ends here
