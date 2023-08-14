(cl:in-package #:asdf-user)

(defsystem "second-climacs-incremental-parsing"
  :depends-on ("trivial-gray-streams"
               "cluffer"
               "flexichain"
               "eclector")
  :serial t
  :components
  ((:file "packages")
   (:file "utilities")
   (:file "wad")
   (:file "buffer-stream")
   (:file "cache")
   (:file "analyzer")
   (:file "token")
   (:file "client")
   (:file "parse")
   (:file "read-forms")))
