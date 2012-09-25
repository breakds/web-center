;;;; Personal Web Center
;;;; Author: BreakDS
;;;; Date: Sun Sep 23 15:28:48 CDT 2012

(in-package #:breakds.web-center)

(defparameter *acceptor* nil "the acceptor")

;;; Handlers are here

;; ==================== Module Status ====================
;; test the server status
(hunchentoot:define-easy-handler (test-handler :uri "/status") ()
  (setf (hunchentoot:content-type*) "text/html")
  (format nil "Web center is running.~%"))




;; ==================== Module Bus Info ====================
(hunchentoot:define-easy-handler (test-handler :uri "/bus") ()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((output (make-string-output-stream)))
    (format output "<u>Bus Info v0.2 for <b>breakds</b></u><br><br>~%")
    (format output "<u>Bus No. 2: campus to home<br>~%")
    (loop for every in (bus-info:get-bus-info 2 115 886)
         (format output "~a <br>" every))
    (get-output-stream-string output)))
                                              



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
  
  

  
  