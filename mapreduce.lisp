(in-package :cl-riak)

(defun mapred (inputs query &key (server "localhost:8098"))
  (let ((request (encode-json-to-string (list (cons "inputs" inputs) 
                                              (cons "query" query))))
        (request-url (concatenate 'string "http://" server "/mapred")))
    (multiple-value-bind (response status headers)
      (drakma:http-request request-url
          :method :post
          :content-type "application/json"
          :content request)
      (when (= status 200) (decode-json-from-string response)))))

(defun plist->alist (lst)
  (when lst 
    (cons (cons (car lst) (cadr lst))
          (plist->alist (cddr lst)))))

(defun mrphase (qtype &rest body)
  (list (cons qtype (plist->alist body))))
