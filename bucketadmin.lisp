(in-package :cl-riak)

(defun set-bucket-props (bucket props &key (server "localhost:8098"))
  (let ((content (encode-json-to-string (list (cons "props" props))))
        (request-url (concatenate 'string "http://" server "/riak/"
                                  (url-encode bucket :utf-8))))
    (multiple-value-bind (response status headers)
      (drakma:http-request request-url
        :method :put
        :content-type "application/json"
        :content content)
      (= status 204))))

(defun sym-to-arg (sym)
  (cond ((eq sym t) "true")
        ((eq sym nil) "false")
        (t (string-downcase (symbol-name sym)))))

(defun get-bucket-props (bucket &key (props t) (keys nil) 
                                (server "localhost:8098"))
  (let ((request-url (concatenate 'string "http://" server "/riak/"
                                  (url-encode bucket :utf-8))))
    (multiple-value-bind (response status headers)
      (drakma:http-request request-url
        :method :get
        :parameters (list (cons "props" (sym-to-arg props)) 
                          (cons "keys" (sym-to-arg keys))))
      (when (= status 200) (decode-json-from-string response)))))

