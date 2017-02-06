;;--------------------------------------------------------------------------------
;; org-mode org-2-html
(require 'ox-publish)

(setq publish_dir "~/Desktop/opensource/bigplus.github.io/")
(setq debug-on-error t)
(setq org_dir "~/org/")

(setq org-publish-project-alist
  '(
    ;; org-notes
        ("org-notes"               ;Used to export .org file
         :base-directory "~/org/"   ;directory holds .org files
         :base-extension "org"     ;process .org file only
         :publishing-directory "~/Desktop/public_html/" ;export destination
         ;:publishing-directory "/ssh:user@server" ;export to server
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4               ; Just the default for this project.
         :auto-preamble nil
         :auto-sitemap t                  ; Generate sitemap.org automagically...
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
         :sitemap-sort-files anti-chronologically  ; 看别人的配置后添加的
         :sitemap-file-entry-format "%d %t"        ; 看别人的配置后添加的
         :export-creator-info nil    ; Disable the inclusion of "Created by Org" in the postamble.
         :export-author-info nil     ; Disable the inclusion of "Author: Your Name" in the postamble.
         :author "Jerry"             ; 看别人的配置，后添加的
         :email "zhuyu.deng@foxmail.com"  ; 看别人的配置后添加的
         :table-of-contents t        ; Set this to "t" if you want a table of contents, set to "nil" disables TOC.
         :section-numbers nil        ; Set this to "t" if you want headings to have numbers.
         :auto-postamble t           ; Disable auto postamble
         :html-postamble get-intranet-postamble ;; "    <p class=\"postamble\">Last Updated %d.</p> " ; your personal postamble
         :style-include-default nil  ;Disable the default css style
         )

        ;; org-static
        ("org-static"                ;Used to publish static files
         :base-directory "~/org/static_files/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ;; org
        ("org" :components ("org-notes" "org-static")) ;; combine "org-static" and "org-static" into one function call

        ;;--------------------
        ;; bigdata-static
        ("bigdata-static"                ;Used to publish static files  记得在bigdata目录下放css img js等
         :base-directory "~/org/static_files/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/public_html/bigdata/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ;;--------------------
        ;; jerry-static
        ("jerry-static"                ;Used to publish static files
         :base-directory "~/org/static_files/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/public_html/jerry/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ;;--------------------
        ;; algo-static
        ("algo-static"                ;Used to publish static files
         :base-directory "~/org/static_files/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/public_html/algo/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ;;--------------------
        ;; others-static
        ("others-static"                ;Used to publish static files
         :base-directory "~/org/static_files/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/public_html/others/"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ;;--------------------

        ;;	("all" :components ("org" "bigdata-static" "jerry-static" "algo-static" "others-static"))
        ("all" :components ("org"))
        ("bigdata-static" :components ("bigdata-static"))
        ))

;;--------------------------------------------------------------------------------
;; htmlize org输出的html代码段高亮
                                        ;(require 'htmlize)

;;--------------------------------------------------------------------------------

;;                            <p class=\"postamble\">Last Updated %C. Created by %a</p>
;; org2html 脚本
;;(defun get-intranet-postamble (plist)
;;  (let ((title (plist-get plist :title))
;;        (creator (plist-get plist :creator))
;;        (time (format-time-string org-html-metadata-timestamp-format))
;;        )
;;    (format
;;             "<script>
;;              var _hmt = _hmt || [];
;;              (function() {
;;                       var hm = document.createElement(\"script\");
;;                       hm.src = \"//hm.baidu.com/hm.js?001e800887eba2f8f57ec8059aafdad6\";
;;                       var s = document.getElementsByTagName(\"script\")[0];
;;                       s.parentNode.insertBefore(hm, s);
;;                       })();
;;              </script>
;;              <div id=\"disqus_thread\"></div>
;;              <script type=\"text/javascript\">
;;              var disqus_shortname = 'bigplus';
;;              (function() {
;;                       var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
;;                       dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
;;                       (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
;;                       })();
;;              </script>
;;
;;              <script>
;;              (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
;;                      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
;;                       m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
;;                       })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
;;              ga('create', 'UA-56515498-2', 'auto');
;;              ga('send', 'pageview');
;;              </script>
;;     <p>
;;       <a href=\"mailto:%s?Subject=Comments on %s\">Send a feedback</a>
;;     </p>
;;
;;     <p>
;;       <span class=\"date\">Created: %s</span> by <span class=\"creator\"> Jerry </span>
;;     </p>"
;;     "zhuyu.deng@gmail.com" title time)))
;;

;; org2html 原来的脚本，后来添加了 评论，统计等信息
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
;;(setq org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"./css/org.css\" />")
;;(setq org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/org.css\" />")
(setq org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/worg.css\" />")
;; (setq org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/org.css\" />")

;(setq org-export-html-validation-link nil)
;(setq org-html-validation-link nil)
;;(setq org-src-fontify-natively t)
;;-------------------------------------------------------------------------------------------------
;(setf org-html-postamble nil)
;;(setf org-html-scripts "")

;;(setf org-html-postamble-format
;;      (list
;;       (list
;;	"en"
;;	(concat
;;	 "<p>By <a href='https://pavpanchekha.com' rel='author'>%a</a>.\n"
;;	 "Share it—it's <a href='http://creativecommons.org/licenses/by-sa/4.0' rel='license'>CC-BY-SA licensed</a>.</p>"))))
;; (setq org-html-postamble "whatever you want, make sure its html though")

;; -------------------------- 显示不同 title 的大小 -----------------------------------------------
;(set-face-attribute 'org-level-1 nil :height 1.6 :bold t)
;(set-face-attribute 'org-level-2 nil :height 1.4 :bold t)
;(set-face-attribute 'org-level-3 nil :height 1.2 :bold t)

;但能不能在编辑的时候，就可以在org-mode里面看到语法高亮的效果呢？答案是肯定的！
(setq org-src-fontify-natively t)

;; ---------------------------------- autoload indent -------------------------------------------
;(org-indent-mode t)

;;; ----------------------------------
;;; http://orgmode.org/worg/org-contrib/babel/examples/fontify-src-code-blocks.html
;(org-block-begin-line
; ((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF"))))
;(org-block-background
; ((t (:background "#FFFFEA"))))
;(org-block-end-line
; ((t (:overline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF"))))
;
;;; ----------------------------------
;(defface org-block-begin-line
;  '((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF")))
;  "Face used for the line delimiting the begin of source blocks.")
;
;(defface org-block-background
;  '((t (:background "#FFFFEA")))
;  "Face used for the source block background.")
;
;(defface org-block-end-line
;  '((t (:overline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF")))
;  "Face used for the line delimiting the end of source blocks.")
;



;; 其他人的org配置

;; 配置org publish project
  ;; Begin=================     

;;  (require 'ox-publish)
;;  (setq org-publish-project-alist
;;        '(
;;          ("blog-notes"
;;           :base-directory "~/org/notes"
;;           :base-extension "org"
;;           :publishing-directory "~/org/public_html/"
;;           :recursive t
;;           :publishing-function org-html-publish-to-html
;;           :headline-levels 4             ; Just the default for this project.
;;           :auto-preamble t
;;           :section-numbers nil
;;           :author "Tisoga"
;;           :email "forrestchang7@gmail.com"
;;           :auto-sitemap t                ; Generate sitemap.org automagically...
;;           :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
;;           :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
;;           :sitemap-sort-files anti-chronologically
;;           :sitemap-file-entry-format "%d %t"
;;           :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/worg.css\"/>"
;;           :html-postamble "<p class=\"postamble\">Last Updated %C. Created by %a</p>
;;                            <script>
;;                            var _hmt = _hmt || [];
;;                            (function() {
;;                                     var hm = document.createElement(\"script\");
;;                                     hm.src = \"//hm.baidu.com/hm.js?001e800887eba2f8f57ec8059aafdad6\";
;;                                     var s = document.getElementsByTagName(\"script\")[0];
;;                                     s.parentNode.insertBefore(hm, s);
;;                                     })();
;;                            </script>
;;                            <div id=\"disqus_thread\"></div>
;;                            <script type=\"text/javascript\">
;;                            var disqus_shortname = 'tisogasnotes';
;;                            (function() {
;;                                     var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
;;                                     dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
;;                                     (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
;;                                     })();
;;                            </script>
;;                            <script>
;;                            (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
;;                                     (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
;;                                     m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
;;                                     })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
;;                            ga('create', 'UA-56515498-2', 'auto');
;;                            ga('send', 'pageview');
;;                            </script>
;;                            "
;;           )
;;
;;          ("blog-static"
;;           :base-directory "~/org/notes"
;;           :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
;;           :publishing-directory "~/org/public_html/"
;;           :recursive t
;;           :publishing-function org-publish-attachment
;;           )
;;
;;          ("blog" :components ("blog-notes" "blog-static"))
;;
;;          ))

  ;; End===================

(setq truncate-lines nil)
(setq org-src-fontify-natively t)

(add-hook 'org-mode-hook
          (lambda () (setq truncate-lines nil)))

(provide 'init-org)
