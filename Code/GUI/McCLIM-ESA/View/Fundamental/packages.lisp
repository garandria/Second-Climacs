(cl:in-package #:common-lisp-user)

(defpackage #:second-climacs-clim-view-fundamental
  (:use #:common-lisp)
  (:local-nicknames (#:clim-base #:second-climacs-clim-base)
                    (#:base #:second-climacs-base))
  (:export #:fundamental-view))