;;;; bus-info.lisp
;;;; Used to fetch real time information about bus in Madison, WI

(in-package breakds.bus-info)


(defun time-stamp-filter (http-stream)
  "return a list of all the time stamps appear in the stream"
  (loop for line = (read-line http-stream nil 'eof) 
     until (eq line 'eof)
     for re = (nth-value 1 (ppcre:scan-to-strings "colspan=\"1\".*>.*<a class.*>(.*)</td><" line))
     when re collect (aref re 0)))

(defun get-info-from-url (url)
  "get list of time stamps from a web page"
  (let ((response (trivial-http:http-get url)))
    (when (= 200 (first response))
      (time-stamp-filter (third response)))))

(defun get-bus-info (route d s)
  "get list of time stamps given route number and two street id"
  (get-info-from-url 
   (format nil "http://webwatch.cityofmadison.com/webwatch/ada.aspx?r=~2,'0d&d=~a&s=~a" route d s)))

   



  
  