(cl:in-package #:common-lisp-user)

(defpackage #:second-climacs-incremental-parsing
  (:use #:common-lisp)
  (:shadow #:package-name #:symbol-name)
  (:local-nicknames (#:reader #:eclector.reader)
                    (#:readtable #:eclector.readtable)
                    (#:gs #:trivial-gray-streams)
                    (#:flx #:flexichain))
  (:export
   #:line-count
   #:line-contents
   #:analyzer
   #:update-cache
   #:map-wads-and-spaces

   ;; Wads
   #:wad
   #:expression-wad
   #:labeled-object-definition-wad
   #:labeled-object-reference-wad
   #:no-expression-wad
   #:skipped-wad
   #:comment-wad
   #:block-comment-wad
   #:semicolon-comment-wad
   #:word-wad
   #:misspelled
   #:ignored-wad
   #:sharpsign-wad
   #:sharpsign-plus-wad
   #:sharpsign-minus-wad
   #:read-suppress-wad
   #:reader-macro-wad
   #:error-wad
   #:absolute-start-line-number
   #:start-line
   #:height
   #:end-line
   #:start-column
   #:end-column
   #:min-column-number
   #:max-column-number
   #:children
   #:expression
   #:token
   #:indentation
   #:semicolon-count
   #:left-sibling
   #:right-sibling

   ;; Tokens
   #:token ; class
   #:symbol-token
   #:non-existing-package-symbol-token
   #:non-existing-symbol-token
   #:existing-symbol-token
   #:value-token
   #:numeric-token
   #:other-token
   #:package-name
   #:package-marker-1
   #:package-marker-2

   #:total-width
   #:cache
   #:name
   #:find-wad-beginning-line
   #:find-wads-containing-position
   #:make-wad-descriptor-from-wad
   #:lines
   #:compute-wad-descriptors
   #:start-line-number
   #:start-column-number
   #:end-line-number
   #:end-column-number
   #:items
   #:previous-sibling
   #:next-sibling
   #:buffer))
