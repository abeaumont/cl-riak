(in-package :cl-riak)

(defun mapred (inputs query &key (server "localhost:8098"))
  (let ((request (encode-json (list :plist "inputs" inputs "query" query)))
        (request-url (concatenate 'string "http://" server "/mapred")))
    (multiple-value-bind (response status headers)
      (drakma:http-request request-url
          :method :post
          :content-type "application/json"
          :content request)
      (when (= status 200) response))))

(defun plist->alist (lst)
  (when lst 
    (cons (cons (car lst) (cadr lst))
          (plist->alist (cddr lst)))))

(defmacro mrquery (qtype &body body)
  `(list :plist ,qtype
         (list :alist 
               ,@(loop for (key . val) in (plist->alist body)
                       collect `(cons ,(string-downcase (symbol-name key)) 
                                      ,val)))))

