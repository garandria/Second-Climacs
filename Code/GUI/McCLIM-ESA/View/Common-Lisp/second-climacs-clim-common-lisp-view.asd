(defsystem "second-climacs-clim-common-lisp-view"
  :depends-on ("second-climacs-clim-base"
               "climacs-syntax-common-lisp"
               "stealth-mixin")
  :serial t
  :components ((:file "packages")
               (:file "common-lisp-view")
               (:file "token-drawing")
               (:file "cursor-visibility")
               (:file "common-lisp-command-table")
               (:file "indentation")))
