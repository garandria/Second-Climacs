(cl:in-package #:second-climacs-base)

;;; A BUFFER is an object that holds data to be operated on and
;;; displayed.  An instance of this class typically contains a
;;; reference to another object, perhaps provided by an external
;;; library.
;;;
;;; A typical situation would be that a subclass of BUFFER contains a
;;; slot holding a reference to a Cluffer buffer object.

(defclass buffer ()
  ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Generic function FILL-BUFFER-FROM-STREAM.
;;;
;;; This function takes a cursor, and inserts the contents of the
;;; character stream STREAM at the position of the cursor.

(defgeneric fill-buffer-from-stream (cursor stream))
