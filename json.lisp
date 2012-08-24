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

(defun join-alist (psep lsep lst)
  (cond ((null lst) "")
        ((null (cdr lst)) (concatenate 'string (caar lst) psep (cdar lst)))
        (t (concatenate 'string (caar lst) psep (cdar lst) lsep
                        (join-alist psep lsep (cdr lst))))))

(defun list-json (lst)
  (concatenate 'string "[" 
               (join-list ", " (mapcar #'encode-json lst)) "]"))

(defun plist-json (lst)
  (concatenate 'string "{" 
               (join-plist ": " ", " (mapcar #'encode-json lst)) "}"))

(defun alist-join (lst)
  (concatenate 'string "{" 
               (join-alist ": " ", " (mapcar #'encode-json lst)) "}"))

(defun encode-json (obj)
  (if (atom obj) (write-to-string obj)
    (let ((ltype (car obj)))
      (case ltype
        (:plist (plist-json (cdr obj)))
        (:alist (alist-json (cdr obj)))
        (otherwise (list-json obj))))))
