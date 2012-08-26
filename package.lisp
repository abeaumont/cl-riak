;;;; package.lisp

(defpackage #:cl-riak
  (:use #:cl #:split-sequence #:alexandria #:json)
  (:import-from #:drakma #:url-encode)
  (:shadow #:get #:set #:delete)
  (:export #:get #:set #:delete 
           #:mapred #:mrphase
           #:set-bucket-props #:get-bucket-props))
