(cl:in-package #:climacs-syntax-common-lisp)

;;; Compute the indentation for a wad representing a single LET or
;;; LET* binding.
(defgeneric compute-binding-indentation (wad client))

(defmethod compute-binding-indentation (wad client)
  (let ((expression (expression wad)))
    (when (and (consp expression)
               (proper-list-p expression))
      (let* ((children (children wad))
             (first-child (first children))
             (start-column (start-column first-child))
             (remaining-children (rest children)))
        ;; We indent every remaining child as the first one, plus 2
        ;; columns.
        (loop for child in remaining-children
              unless (zerop (start-line child))
                do (setf (indentation child) (+ start-column 2))
              do (compute-child-indentations child client))))))

;;; Compute the indentation for a wad representing a list of LET or
;;; LET* bindings.
(defgeneric compute-binding-indentations (wad client))

(defmethod compute-binding-indentations (wad client)
  (let ((expression (expression wad)))
    (when (and (consp expression)
               (proper-list-p expression))
        ;; We indent every remaining child as the first one.
      (let* ((children (children wad))
             (first-child (first children))
             (start-column (start-column first-child))
             (remaining-children (rest children)))
        (compute-binding-indentation first-child client)
        ;; We indent every remaining child as the first one, plus 2
        ;; columns.
        (loop for child in remaining-children
              unless (zerop (start-line child))
                do (setf (indentation child) start-column)
              when (typep child 'expression-wad)
                do (compute-binding-indentation child client))))))

(defun compute-let-and-letstar-indentation (wad client)
  (compute-indentation-single-distinguished
   wad
   (lambda (wad) (compute-binding-indentations wad client))
   (lambda (indentation wads)
     (indent-body indentation wads client))))

(defmethod compute-sub-form-indentations
    (wad (pawn (eql (intern-pawn '#:common-lisp '#:let))) client)
  (compute-let-and-letstar-indentation wad client))

(defmethod compute-sub-form-indentations
    (wad (pawn (eql (intern-pawn '#:common-lisp '#:let*))) client)
  (compute-let-and-letstar-indentation wad client))
