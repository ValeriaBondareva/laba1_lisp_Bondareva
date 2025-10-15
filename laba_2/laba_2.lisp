(defun reverse-and-nest-head (lst)
  (cond
    ((null lst) nil)
    ((null (cdr lst)) (list (car lst)))             
    (t (list (reverse-and-nest-head (cdr lst))       
             (car lst)))))

(defun repeat-onto (x n acc)
  (if (<= n 0)
      acc
      (repeat-onto x (1- n) (cons x acc))))

(defun duplicate-elements (lst n)
  (duplicate-elements-aux lst n nil))

(defun duplicate-elements-aux (xs n acc)
  (if (null xs)
      acc
      (let ((acc-tail (duplicate-elements-aux (cdr xs) n acc)))
        (repeat-onto (car xs) n acc-tail))))

(defun check-ranh (name input expected)
  (format t "~:[FAILED~;passed~]  reverse-and-nest-head ~a~%"
          (equal (reverse-and-nest-head input) expected)
          name))

(defun test-reverse-and-nest-head ()
  (check-ranh "test 1" '(a b c) '(((C) B) A))
  (check-ranh "test 2" '(a) '(A))
  (check-ranh "test 3" '() nil))

(defun check-dup (name input n expected)
  (format t "~:[FAILED~;passed~]  duplicate-elements ~a~%"
          (equal (duplicate-elements input n) expected)
          name))

(defun test-duplicate-elements ()
  (check-dup "test 1" '(a b c) 3 '(A A A B B B C C C))
  (check-dup "test 2" '(x y) 1 '(X Y))
  (check-dup "test 3" '(a b) 0 nil))
