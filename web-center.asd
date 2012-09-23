;;;; web-center.asd

(asdf:defsystem #:web-center
    :serial t
    :depends-on (#:hunchentoot
                 #:html-template)
    :components ((:file "lisp/packages")
                 (:file "lisp/web-center")))