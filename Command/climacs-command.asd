(defsystem "climacs-command"
  :depends-on ("acclimation")
  :serial t
  :components ((:file "packages")
               (:file "command")
               (:file "invocation")))
