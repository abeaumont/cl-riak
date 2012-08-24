# Basic usage

## Set
(cl-riak:set key value :bucket "bucket-name")

    * (cl-riak:set "foo" "bar" :bucket "nom") 

    "bar"
    "a85hYGBgzGDKBVIcypz/fvql33qYwZTImMfK8CHsznG+LAA="

## Get
(cl-riak:get key value :bucket "bucket-name")

    * (cl-riak:get "foo" :bucket "nom")

    "bar"
    "a85hYGBgzGDKBVIcypz/fvql33qYwZTImMfK8CHsznG+LAA="

## MapReduce

An example taken from the "Riak Fast Track" from wiki.basho.com.

http://wiki.basho.com/Loading-Data-and-Running-MapReduce-Queries.html

    (defparameter *over-600-jsfunc*
      "function (value, keyData, arg) {
         var data = Riak.mapValuesJson(value)[0];
         if(data.High && data.High > 600.00)
           return [value.key];
         else return [];
       }")

    (let ((over600 (cl-riak:mapred "goog" 
                      (list (cl-riak:mrquery "map" :language "javascript" :keep t
                                :source *over-600-jsfunc*)))))
      (loop for res in over600 do (format t "~a~%" res)))
