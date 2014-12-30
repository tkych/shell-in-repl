;;;; shell-in-repl/shell-in-repl.asd

;; This software is released under the Public Domain.

;;====================================================================
;; SHELL-IN-REPL: CL-USER> #> ls -la
;;====================================================================
;; shell-in-repl/
;;   README.md
;;   shell-in-repl.asd
;;   shell-in-repl.lisp


;;====================================================================
;; System for SHELL-IN-REPL
;;====================================================================

(asdf:defsystem #:shell-in-repl
  :name        "shell-in-repl"
  :description "A trivial read-macro for uiop:run-program."
  :version     "0.1.00"
  :licence     "Public Domain"
  :author      "Takaya OCHIAI <tkych.repl@gmail.com>"
  :depends-on  (:uiop :named-readtables)
  :components  ((:file "shell-in-repl")))


;;====================================================================
