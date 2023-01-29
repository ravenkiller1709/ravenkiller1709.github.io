;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style t ;; Use our own styles
      org-html-htmlize-generate-css t ;; Create the CSS for all font definitions in the current session
      org-html-head "<link rel=\"stylesheet\" href=\"https://sandyuraz.com/styles/org.min.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "my-org-site"
             :recursive t
             :base-directory "./content"
             :publishing-directory "./public"
             :publishing-function 'org-html-publish-to-html
	     :with-author nil
	     :with-creator nil
	     :with-toc t
	     :section-numbers nil
	     :time-stamp-file nil)))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
