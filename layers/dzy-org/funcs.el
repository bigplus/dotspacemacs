;; org-mode org-2-html
(require 'ox-publish)

;; ------------------------ config from http://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.org.html ---------------------
;; https://stackoverflow.com/questions/21258769/using-emacs-org-mode-how-to-publish-the-unchanged-files-in-a-project
;; https://qiwulun.github.io/posts/org-mode%E5%B8%B8%E7%94%A8%E5%8A%9F%E8%83%BD%EF%BC%8D%EF%BC%8Dpublish.html
;; https://ogbe.net/blog/blogging_with_org.html
;; http://www.cnblogs.com/wang_yb/p/3519221.html
;; https://ogbe.net/emacsconfig.html
;; https://thibaultmarin.github.io/blog/posts/2016-11-13-Personal_website_in_org.html#org2fc99b4
;; https://pavpanchekha.com/blog/org-mode-publish.html
;; 下划线变成下标 ： http://blog.csdn.net/csfreebird/article/details/43580679
;; 处理变量问题 : https://stackoverflow.com/questions/37489217/exporting-with-ox-publish-can-not-assign-variable-to-keyword
;; https://emacs-china.org/tags/org

;; (setq basedir "~/org/")
;; (setq publishdir "~/public_html/")
(setq basedir "~/bigplus.github.io/org")
(setq publishdir "~/bigplus.github.io/")

(setq org-publish-project-alist
      `(
        ;; org-notes
        ("org-notes"               ;Used to export .org file
         :base-directory  ,basedir;directory holds .org files
         ;; :base-directory  "~/bigplus.github.io/org" ;directory holds .org files
         :base-extension "org"     ;process .org file only
         :publishing-directory ,publishdir;export destination
         ;; :publishing-directory "~/bigplus.github.io/" ;export destination
         :recursive t
         :publishing-function org-html-publish-to-html

         ;; sitemap
         :auto-sitemap t                ; Generate sitemap.org automagically...
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.

         ;; html
         :author "Jerry"             ; 看别人的配置，后添加的
         :email "zhuyu.deng@foxmail.com"
         :headline-levels 4               ; Just the default for this project.
         :html-postamble get-intranet-postamble

         ;; functions
         ;; 自动换行 http://orgmode.org/org.html#Export-settings
         :preserve-breaks t
         )

        ;; org-static
        ("org-static"                ;Used to publish static files
         :base-directory ,basedir
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory ,publishdir
         :recursive t
         :publishing-function org-publish-attachment
         )

        ;; org
        ("org" :components ("org-notes" "org-static")) ;; combine "org-static" and "org-static" into one function call

        ;;	("all" :components ("org"))
        ("all" :components ("org"))
        ))


;; org2html footer
(defun get-intranet-postamble (plist)
  (let ((title (plist-get plist :title))
        (creator (plist-get plist :creator))
        (time (format-time-string org-html-metadata-timestamp-format))
        )
    (format
     "<p>
     <a href=\"mailto:%s?Subject=Comments on %s\">Send a feedback</a>
     </p>

     <p>
     <span class=\"date\">Created: %s</span> by <span class=\"creator\"> Jerry </span>
     </p>"
     "zhuyu.deng@gmail.com" title time)))



;;---------------------------------------------------------------------------------------------------------------------------------------
;;                  -- config css --
;; (setq org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/org.css\" />")
(setq org-html-head (concat "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/org.css\" />\n" "<link rel=\"stylesheet\" type=\"text/css\" href=\"../css/org.css\" />"  "<link rel=\"stylesheet\" type=\"text/css\" href=\"../../css/org.css\" />"   "<link rel=\"stylesheet\" type=\"text/css\" href=\"../../../css/org.css\" />"))

;;但能不能在编辑的时候，就可以在org-mode里面看到语法高亮的效果呢？答案是肯定的！
(setq org-src-fontify-natively t)

;; End===================

(setq truncate-lines nil)
(setq org-src-fontify-natively t)

;; auto nextline
;; http://www.fuzihao.org/blog/2015/02/19/org-mode%E6%95%99%E7%A8%8B/
;; http://fengjian.info/?p=687
(add-hook 'org-mode-hook
          (lambda () (setq truncate-lines nil)))

;;;###autoload
(defadvice org-html-paragraph (before fsh-org-html-paragraph-advice
                                      (paragraph contents info) activate)
  "Join consecutive Chinese lines into a single long line without
unwanted space when exporting org-mode to html."
  (let*
      ((orig-contents (ad-get-arg 1))
       (reg-han "[[:multibyte:]]")
       (fixed-contents (replace-regexp-in-string
                        (concat "\\(" reg-han "\\) *\n *\\(" reg-han "\\)")
                        "\\1\\2" orig-contents)))
    (ad-set-arg 1 fixed-contents)))

(org-indent-mode t)

(provide 'init-org)
