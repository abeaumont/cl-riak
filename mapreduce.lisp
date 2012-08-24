(in-package :cl-riak)

(defun mapred (mapreduce &key (server "localhost:8098"))
  (let ((request-url (concatenate 'string "http://" server "/mapred")))
    (multiple-value-bind (response status headers)
      (drakma:http-request request-url
          :method :post
          :content-type "application/json"
          :content mapreduce)
      (when (= status 200) response))))
