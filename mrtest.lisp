(require 'cl-riak)

(defparameter *over-600-jsfunc*
  "function (value, keyData, arg) {
     var data = Riak.mapValuesJson(value)[0];
     if(data.High && data.High > 600.00)
       return [value.key];
     else return [];
   }")

(let ((over600 (cl-riak:mapred "goog" 
                  (list (cl-riak:mrphase "map" :language "javascript" :keep t
                            :source *over-600-jsfunc*)))))
  (loop for res in over600 do (format t "~a~%" res)))
