(cl:in-package #:second-climacs-syntax-common-lisp)

;;; A folio stream is a stream that uses a folio as a source for the
;;; items to return as a result of reading.
(defclass folio-stream (gs:fundamental-character-input-stream)
  ((%folio :initarg :folio :reader folio)
   (%lines :initarg :lines :reader lines)
   (%current-line-number :initform 0 :accessor current-line-number)
   (%current-item-number :initform 0 :accessor current-item-number)))

(defgeneric next-position (lines line-number item-number))

(defmethod next-position ((lines flx:flexichain) line-number item-number)
  (if (= (length (flx:element* lines line-number)) item-number)
      (values (1+ line-number) 0)
      (values line-number (1+ item-number))))

(defgeneric previous-position (lines line-number item-number))

(defmethod previous-position ((lines flx:flexichain) line-number item-number)
  (if (zerop item-number)
      (values (1- line-number)
              (length (flx:element* lines (1- line-number))))
      (values line-number (1- item-number))))

(defgeneric eof-p (folio-stream))

(defmethod eof-p ((stream folio-stream))
  (let* ((lines (lines stream))
         (last-line-number (1- (flx:nb-elements lines)))
         (last-line (flx:element* lines last-line-number))
         (last-line-length (length last-line)))
    (and (= (current-line-number stream) last-line-number)
         (= (current-item-number stream) last-line-length))))

(defgeneric forward (folio-stream))

(defmethod forward ((stream folio-stream))
  (with-accessors ((lines lines)
                   (current-line-number current-line-number)
                   (current-item-number current-item-number))
      stream
    (multiple-value-bind (l c)
        (next-position lines current-line-number current-item-number)
      (setf current-line-number l)
      (setf current-item-number c))))

(defgeneric backward (folio-stream))

(defmethod backward ((stream folio-stream))
  (with-accessors ((lines lines)
                   (current-line-number current-line-number)
                   (current-item-number current-item-number))
      stream
    (multiple-value-bind (l c)
        (previous-position lines current-line-number current-item-number)
      (setf current-line-number l)
      (setf current-item-number c))))

(defmethod gs:stream-peek-char ((stream folio-stream))
  (if (eof-p stream)
      :eof
      (with-accessors ((lines lines)
                       (current-line-number current-line-number)
                       (current-item-number current-item-number))
          stream
        (let ((line (flx:element* lines current-line-number)))
          (if (= (length line) current-item-number)
              #\Newline
              (aref line current-item-number))))))

(defmethod gs:stream-read-char ((stream folio-stream))
  (if (eof-p stream)
      :eof
      (prog1 (gs:stream-peek-char stream)
        (forward stream))))

(defmethod gs:stream-unread-char ((stream folio-stream) char)
  (declare (ignore char))
  (backward stream))

(defun skip-whitespace (stream)
  (loop until (eof-p stream)
        for char = (read-char stream nil nil)
        do (unless (member char '(#\Space #\Tab #\Newline))
             (unread-char char stream)
             (loop-finish))))

(defun compute-max-line-width (folio-stream start-line end-line children)
  (let ((lines (lines folio-stream)))
    (loop with rest = children
          for line-number = start-line then (1+ line-number)
          while (<= line-number end-line)
          if (and (not (null rest)) (= line-number (start-line (first rest))))
            maximize (max-line-width (first rest))
            and do (setf line-number (end-line (first rest)))
                   (pop rest)
          else
            maximize (length (flx:element* lines line-number)))))
