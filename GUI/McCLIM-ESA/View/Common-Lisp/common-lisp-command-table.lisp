(cl:in-package #:second-climacs-clim-view-common-lisp)

(clim:define-command-table common-lisp-table
  :inherit-from
  (clim-base:global-table
   clim-base:ascii-insert-table
   clim-base:delete-table
   clim-base:motion-table))

(clim:define-command
    (com-up-expression :name t :command-table common-lisp-table)
    ()
  (let* ((view (clim:stream-default-view (esa:current-window)))
         (climacs-view (clim-base:climacs-view view))
         (analyzer (base:analyzer climacs-view))
         (cache (climacs-syntax-common-lisp:folio analyzer))
         (climacs-buffer (base:buffer analyzer))
         (cluffer-buffer (base:cluffer-buffer climacs-buffer)))
    (climacs-syntax-common-lisp:scavenge cache cluffer-buffer)
    (climacs-syntax-common-lisp:read-forms analyzer)
    (clim-base:with-current-cursor (cursor)
      (climacs-syntax-common-lisp:up-expression cache cursor))))

(esa:set-key `(com-up-expression)
	     'common-lisp-table
	     '((#\u :meta :control)))
