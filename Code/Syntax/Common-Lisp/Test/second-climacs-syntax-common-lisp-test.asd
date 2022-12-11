(defsystem "second-climacs-syntax-common-lisp-test"
  :depends-on ("second-climacs-syntax-common-lisp"
               "split-sequence")
  :serial t
  :components ((:file "packages")
               (:file "vector-folio")
               (:file "folio")
               (:file "cache-invalidation")
               (:file "random-form")
               (:file "buffer")))
