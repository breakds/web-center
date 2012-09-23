;;;; Personal Web Center
;;;; Author: BreakDS
;;;; Date: Sun Sep 23 15:28:48 CDT 2012

(in-package #:breakds.web-center)

(defparameter *acceptor* nil "the acceptor")

;;; Handlers are here
(hunchentoot:define-easy-handler (test-handler :uri "/test") ()
  (setf (hunchentoot:content-type*) "text/html")
  (format nil "Web center is running.~%"))



;;; Control of the Web Center
(defun start-server (&optional (port 8801))
  "Start the server, default port 8801"
  ;; no document-root specified. Serve dynamic content only, for now.
  (setf *acceptor* (make-instance 'hunchentoot:easy-acceptor :port port))
  (hunchentoot:start *acceptor*)
  (format t "web center started.~%"))

(defun stop-server ()
  "Stop the server"
  (hunchentoot:stop *acceptor*)
  (format t "server stopped.~%"))
  
  

  
  