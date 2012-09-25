;;;; packages.lisp

(defpackage #:breakds.bus-info
  (:nicknames #:bus)
  (:use #:cl)
  (:export #:get-bus-info))

(defpackage #:breakds.web-center
  (:nicknames #:web-center)
  (:use #:cl
        #:breakds.bus-info)
  (:export #:start-server
           #:stop-server))

