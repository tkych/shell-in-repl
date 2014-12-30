;;;; shell-in-repl/shell-in-repl.lisp

;; This software is released under the Public Domain.

;;====================================================================
;; Core
;;====================================================================

(in-package #:cl-user)

(defpackage #:shell-in-repl
  (:export #:shell-syntax)
  (:use #:cl)
  (:import-from #:named-readtables
                #:defreadtable))

(in-package #:shell-in-repl)


;;--------------------------------------------------------------------

(defun run-command (cmd)
  "Trivial wrapper for uiop:RUN-PROGRAM. Returns (values condition exit-code)"
  (handler-case
      (progn
        (uiop:run-program cmd :output *standard-output*
                              :error-output *error-output*)
        (force-output *standard-output*)
        (force-output *error-output*))
    (:no-error (c)
      (values c 0))
    (uiop/run-program:subprocess-error (c)
      (values c (uiop/run-program:subprocess-error-code c)))))

(defun parse-command (stream)
  (with-output-to-string (s)
    (loop :with in-single-quoting? := nil
          :with in-double-quoting? := nil 
          :for char := (read-char stream)
          :do (case char
                (#\'
                 (setf in-single-quoting? (not in-single-quoting?))
                 (write-char #\' s))
                (#\"
                 (setf in-double-quoting? (not in-double-quoting?))
                 (write-char #\" s))
                (#\Newline
                 (if (or in-single-quoting? in-double-quoting?)
                     (write-char #\Newline s)
                     (return (unread-char #\Newline stream))))
                (#\\
                 (write-char #\\ s)
                 (write-char (read-char stream) s)) ; ! read next character.
                (t
                 (write-char char s))))))

(defun greater-than-reader (stream char parameter)
  (declare (ignore char parameter))
  (let ((*readtable* (copy-readtable nil)))
    `(run-command ,(parse-command stream))))

(defreadtable shell-syntax
  (:merge :standard)
  (:dispatch-macro-char #\# #\> #'greater-than-reader))


;;====================================================================
