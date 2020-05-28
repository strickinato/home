    (setq org-directory "~/Dropbox/zettel")
    (setq +org-capture-todo-file "~/Dropbox/zettel/inbox/capture.org")

    (defun make-orgcapture-frame ()
        "Create a new frame and run org-capture."
        (interactive)
        (make-frame '((name . "remember") (width . 80) (height . 16)
                        (top . 400) (left . 300)
                        (font . "-apple-Monaco-medium-normal-normal-*-13-*-*-*-m-0-iso10646-1")
                    ))
        (select-frame-by-name "remember")
        (org-capture))

(use-package! org-jira
  :after org
  :config
  (setq jiralib-url "https://fictiv.atlassian.net"))

(setq org-publish-project-alist
      '(

        ("garden-org"
            :base-directory "~/Dropbox/projects/MAINTAINED/garden"
            :base-extension "org"
            :publishing-directory "~/Dropbox/projects/MAINTAINED/garden/build"
            :recursive t
            :publishing-function org-pandoc-export-to-html5
            :headline-levels 3
            :auto-preamble t
        )

        ("garden-static"
            :base-directory "~/Dropbox/projects/MAINTAINED/garden"
            :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
            :publishing-directory "~/Dropbox/projects/MAINTAINED/garden/build"
            :recursive t
            :publishing-function org-publish-attachment
        )

        ("garden" :components ("garden-org" "garden-static"))

      ))

(setq doom-font (font-spec :family "Fira Code" :size 14))

(setq doom-theme 'doom-horizon)

(setq display-line-numbers-type t)

(after! treemacs
  (treemacs-resize-icons 0)
  (setq treemacs-no-png-images t)
  )

(setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org"))
(after! org
  (elfeed-org))

(use-package! zetteldeft
  :config
  (setq deft-directory "~/Dropbox/zettel")
)

(use-package! graphviz-dot-mode)

(map!
    :leader
    :desc "Launch Zetteldeft" :gn "n SPC" #'zetteldeft-deft-new-search
    :desc "New File" :gn "z n" #'zetteldeft-new-file
    :desc "New File and Link" :gn "z N" #'zetteldeft-deft-new-search-and-link
    )

(setq md4rd-subs-active '(Zettelkasten unixporn))

(setq rust-format-on-save t)
