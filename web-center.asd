;;;; web-center.asd

(asdf:defsystem #:web-center
    :serial t
    :depends-on (#:hunchentoot
                 #:trivial-http
                 #:cl-ppcre
                 #:html-template)
    :components ((:file "lisp/packages")
                 (:file "lisp/bus-info")
                 (:file "lisp/web-center")))