(cl:in-package #:second-climacs-syntax-common-lisp)

;;; As usual, we don't really compute the indentation of the
;;; expression itself, in this case the type specifier.  Instead, we
;;; compute the indentation of the sub-expressions of that expression.
(defgeneric compute-type-specifier-indentation (wad pawn client))

;;; This method is applicable when the caller specifies NIL for the
;;; pawn, meaning that we do not know the nature of the wad att all,
;;; only that it ought to be a type specifier.  It could be an atomic
;;; wad, in which case it should not have its indentation computed at
;;; all.  Or it could be a compound wad, but with an unknown type
;;; identifier, in which case we also do not compute its indentation.
(defmethod compute-type-specifier-indentation (wad (pawn null) client)
  (when (typep wad 'expression-wad)
    (let ((expression (expression wad)))
      (when (consp expression)
        (compute-type-specifier-indentation
         wad (first expression) client)))))

;;; This method is applicable when we are given a pawn, but there is
;;; no more specific method applicable, meaning we have not defined a
;;; method for this particular pawn.  So we do nothing.
(defmethod compute-type-specifier-indentation (wad (pawn pawn) client)
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Type specifiers AND, OR, NOT, CONS.
;;;
;;; While some of these type specifiers take a bounded number of
;;; arguments, we still treat them as if they can take an arbitrary
;;; number, because it is not the purpose of the indentation code to
;;; detect syntax violations like this.

(define-indentation-automaton compute-type-and/or-indentations
  (tagbody
     (next)
     ;; The current wad must be the symbol AND or the symbol OR, or
     ;; else we would not be here.
     (maybe-assign-indentation 1 3)
     (next)
     ;; The remaining wads represent type specifiers.
   type-specifier
     (maybe-assign-indentation 3 3)
     (compute-type-specifier-indentation current-wad nil client)
     (next)
     (go type-specifier)))

(defmethod compute-type-specifier-indentation
    (wad (pawn (eql (intern-pawn '#:common-lisp '#:and))) client)
  (let* ((indentation-units
           (compute-indentation-units (children wad)))
         (indentations
           (compute-ignore-indentations indentation-units client)))
    (assign-indentation-of-wads-in-units indentation-units indentations)))

(defmethod compute-type-specifier-indentation
    (wad (pawn (eql (intern-pawn '#:common-lisp '#:or))) client)
  (let* ((indentation-units
           (compute-indentation-units (children wad)))
         (indentations
           (compute-ignore-indentations indentation-units client)))
    (assign-indentation-of-wads-in-units indentation-units indentations)))

(defmethod compute-type-specifier-indentation
    (wad (pawn (eql (intern-pawn '#:common-lisp '#:not))) client)
  (let* ((indentation-units
           (compute-indentation-units (children wad)))
         (indentations
           (compute-ignore-indentations indentation-units client)))
    (assign-indentation-of-wads-in-units indentation-units indentations)))

(defmethod compute-type-specifier-indentation
    (wad (pawn (eql (intern-pawn '#:common-lisp '#:cons))) client)
  (let* ((indentation-units
           (compute-indentation-units (children wad)))
         (indentations
           (compute-ignore-indentations indentation-units client)))
    (assign-indentation-of-wads-in-units indentation-units indentations)))