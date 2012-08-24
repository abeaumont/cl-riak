;;;; cl-riak.asd

(asdf:defsystem #:cl-riak
  :serial t
  :depends-on (#:drakma
               #:cl-json
               #:alexandria
               #:split-sequence)
  :components ((:file "package")
               (:file "basicops")
               (:file "mapreduce")))

