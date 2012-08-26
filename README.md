# Basic usage

## Set
(cl-riak:set key value :bucket "bucket-name")

    * (cl-riak:set "foo" "bar" :bucket "nom") 

    "bar"
    "a85hYGBgzGDKBVIcypz/fvql33qYwZTImMfK8CHsznG+LAA="

If `key` is `nil`, a key will be randomly generated for you.

## Get
(cl-riak:get key value :bucket "bucket-name")

    * (cl-riak:get "foo" :bucket "nom")

    "bar"
    "a85hYGBgzGDKBVIcypz/fvql33qYwZTImMfK8CHsznG+LAA="

## MapReduce

(cl-riak:mapreduce inputs query)
(cl-riak:mrquery type [keyword-args ...])

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
                      (list (cl-riak:mrphase "map" :language "javascript" :keep t
                                :source *over-600-jsfunc*)))))
      (loop for res in over600 do (format t "~a~%" res)))

## Get bucket properties

(cl-riak:get-bucket-props bucket)

Returns the json response parsed into an alist.

## Set bucket properties

(cl-riak:set-bucket-props bucket props)

    (cl-riak:set-bucket-props "test" (("n_val" . 3)))
