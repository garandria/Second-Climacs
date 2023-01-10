(cl:in-package #:second-climacs-clim-view-common-lisp)

(defun scroll-extent (pane x y)
  (multiple-value-bind (width height)
      (text-style-dimensions pane)
    (clim:scroll-extent (clim:sheet-parent pane) (* x width) (* y height))))

(defun move-viewport-to-cursor (pane)
  (let* ((clim-view (clim:stream-default-view pane))
         (climacs-view (clim-base:climacs-view clim-view))
         (cursor (base:cursor climacs-view))
         (cursor-line-number (cluffer:line-number cursor))
         (cursor-column-number (cluffer:cursor-position cursor)))
    (multiple-value-bind (left top right bottom)
        (viewport-area pane)
      (unless (and (<= (1+ top) cursor-line-number (- bottom 2))
                   (<= left cursor-column-number right))
        (scroll-extent pane
                       (max 0 (- cursor-column-number
                                 (floor (- right left) 2)))
                       (max 0 (- cursor-line-number
                                 (floor (- bottom top) 2))))))))

(defun move-cursor-to-viewport (pane)
  (let* ((clim-view (clim:stream-default-view pane))
         (climacs-view (clim-base:climacs-view clim-view))
         (cursor (base:cursor climacs-view))
         (cursor-line-number (cluffer:line-number cursor))
         (cursor-column-number (cluffer:cursor-position cursor))
         (buffer (cluffer:buffer cursor))
         (line-count (cluffer:line-count buffer)))
    (multiple-value-bind (left top right bottom)
        (viewport-area pane)
      (unless (and (<= (1+ top) cursor-line-number (- bottom 2))
                   (<= left cursor-column-number right))
        (let ((new-top (min (1+ top) (1- line-count)))
              (new-bottom (max top (- bottom 2))))
          (cond ((> cursor-line-number new-bottom)
                 (let* ((buffer (cluffer:buffer cursor))
                        (line (cluffer:find-line buffer new-bottom)))
                   (cluffer:detach-cursor cursor)
                   (cluffer:attach-cursor cursor line)))
                ((< cursor-line-number new-top)
                 (let* ((buffer (cluffer:buffer cursor))
                        (line (cluffer:find-line buffer new-top)))
                   (cluffer:detach-cursor cursor)
                   (cluffer:attach-cursor cursor line)))
                ((< cursor-column-number left)
                 (setf (cluffer:cursor-position cursor) left))
                ((> cursor-column-number right)
                 (setf (cluffer:cursor-position cursor) right))
                (t
                 nil)))))))
