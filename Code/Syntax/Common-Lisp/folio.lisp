(cl:in-package #:second-climacs-syntax-common-lisp)

;;; This file contains the definition of a protocol called FOLIO.
;;; Conceptually, a folio consists of a certain number of LINEs, each
;;; line containing a certain number of ITEMs.  Lines are numbered
;;; sequentially starting at 0 within a folio, and items are numbered
;;; sequentially starting at 0 within each line.

;;; The base class for all folios.
(defclass folio () ())

;;; Given a folio, a line number an item number within that line,
;;; return the item at that position in that line.
(defgeneric item (folio line-number item-number))
