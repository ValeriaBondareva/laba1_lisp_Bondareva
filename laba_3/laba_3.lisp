(defun extract-min (lst)
  (cond
    ((null lst) (error "extract-min: empty list"))
    ((null (cdr lst)) (values (car lst) nil))
    (t
     (multiple-value-bind (m rest) (extract-min (cdr lst))
       (if (< (car lst) m)
          
           (values (car lst) (cons m rest))
         
           (values m (cons (car lst) rest)))))))

(defun selection-sort-func (lst)

  (if (null lst)
      nil
      (multiple-value-bind (m rest) (extract-min lst)
        (cons m (selection-sort-func rest)))))

(defun selection-sort-imp (lst)
 
  (let ((head (copy-list lst)))
    (labels ((swap-cars (cell-a cell-b)
               (rotatef (car cell-a) (car cell-b))))
      (loop
        for i on head do
        (let ((min-cell i))
          (loop for j on (cdr i) do
                (when (< (car j) (car min-cell))
                  (setf min-cell j)))
          (swap-cars i min-cell))))
    head))
(defun check-sort (name fn input expected)
  (format t "~:[FAILED~;passed~]  ~a~%"
          (equal (funcall fn input) expected)
          name))

(defun test-selection-sort-func ()
  (check-sort "func test 1" #'selection-sort-func '() '())
  (check-sort "func test 2" #'selection-sort-func '(3 2 1) '(1 2 3))
  (check-sort "func test 3" #'selection-sort-func '(4 1 2 5 3) '(1 2 3 4 5))
  (check-sort "func test 4" #'selection-sort-func '(6 7 6 5 5) '(5 5 6 6 7))
  (check-sort "func test 5" #'selection-sort-func '(2 6 -8 -12) '(-8 -12 2 6)))

(defun test-selection-sort-imp ()
  (check-sort "imp test 1" #'selection-sort-imp '() '())
  (check-sort "imp test 2" #'selection-sort-imp '(3 2 1) '(1 2 3))
  (check-sort "imp test 3" #'selection-sort-imp '(4 1 2 5 3) '(1 2 3 4 5))
  (check-sort "imp test 4" #'selection-sort-imp '(6 7 6 5 5) '(5 5 6 6 7))
  (check-sort "imp test 5" #'selection-sort-imp '(2 6 -8 -12) '(-8 -12 2 6)))

