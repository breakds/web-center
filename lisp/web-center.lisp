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

(defun create-bus-info (description route destination stop)
  (let ((stamps (bus-info:get-bus-info route destination stop)))
    (list :description description
	  :time-stamps 
	  (if stamps
	      (loop for every in stamps
		 collect (list :stamp every))
	      (list (list :stamp "Sorry, no bus is coming."))))))

(hunchentoot:define-easy-handler (bus-handler :uri "/bus") (user)
  (setf (hunchentoot:content-type*) "text/html")
  ;; (let ((output (make-string-output-stream)))N
  ;;   (format output "<u>Bus Info v0.2 for <b>breakds</b></u><br><br>~%")
  ;;   (format output "<u>Bus No. 2: campus to home<br>~%")
  ;;   (loop for every in (bus-info:get-bus-info 2 115 886)
  ;;      do (format output "~a <br>" every))
  ;;   (get-output-stream-string output)))
  (cond ((equal "edzhong" user)
	 (with-output-to-string (html-template:*default-template-output*)
	   (html-template:fill-and-print-template
	    (asdf:system-relative-pathname 'web-center "template/bus.template")
	    (list :stops 
		  (list (create-bus-info "Mifflin & Pinckney, Route 6" 6 131 963)
			(create-bus-info "Mifflin & Pinckney, Route 3" 3 131 963)
			(create-bus-info "Mifflin & Pinckney, Route 7" 7 131 963)
			(create-bus-info "Mifflin & Pinckney, Route 2" 2 131 963))))))
	(t 
	 (with-output-to-string (html-template:*default-template-output*)
	   (html-template:fill-and-print-template
	    (asdf:system-relative-pathname 'web-center "template/bus.template")
	    (list :stops 
		  (list (create-bus-info "campus -> home, Route 2" 2 115 886)
			(create-bus-info "campus -> home, Route 28" 28 115 914)
			(create-bus-info "home -> campus, Route 2" 2 131 986)
			(create-bus-info "home -> campus, Route 28" 28 131 986))))))))

	   
                                              



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
  
  

  
  
