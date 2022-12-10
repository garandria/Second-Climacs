(cl:in-package #:second-climacs-syntax-common-lisp-test)

(defun test-read-1 ()
  (let* ((folio (make-instance 'vector-folio
		  :contents #("(form1 form2"
			      "form3 ;;; not to be seen"
			      "form4)")))
	 (stream (make-instance 'cl-syntax:folio-stream
		   :folio folio)))
    (assert (equal (read stream)
		   '(form1 form2 form3 form4)))))
