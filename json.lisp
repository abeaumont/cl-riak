(in-package :cl-riak)

(defun join-list (sep lst)
  (cond ((null lst) "")
        ((null (cdr lst)) (car lst))
        (t (concatenate 'string (car lst) sep (join-list sep (cdr lst))))))

(defun join-plist (psep lsep lst)
  (cond ((null lst) "")
        ((null (cdr lst)) (error "odd number of items in plist"))
        ((null (cddr lst)) (concatenate 'string (car lst) psep (cadr lst)))
        (t (concatenate 'string (car lst) psep (cadr lst) lsep 
                        (join-plist psep lsep (cddr lst))))))

(defun list-json (lst)
  (concatenate 'string "[" 
               (join-list ", " (mapcar #'encode-json lst)) "]"))

(defun plist-json (lst)
  (concatenate 'string "{" 
               (join-plist ": " ", " (mapcar #'encode-json lst)) "}"))

(defun pair-json (pair)
  (concatenate 'string (encode-json (car pair)) ": " 
               (encode-json (cdr pair))))

(defun alist-json (lst)
  (concatenate 'string "{" 
               (join-list ", " (mapcar #'pair-json lst)) "}"))

(defun atom-json (atm)
  (cond ((eq atm t) "true")
        ((eq atm nil) "false")
        ((or (integerp atm) (floatp atm) (stringp atm)) (write-to-string atm))
        (t (error (format nil "~a cannot be converted to json" atm)))))

(defun encode-json (obj)
  (if (atom obj) (atom-json obj)
    (let ((ltype (car obj)))
      (case ltype
        (:plist (plist-json (cdr obj)))
        (:alist (alist-json (cdr obj)))
        (otherwise (list-json obj))))))
