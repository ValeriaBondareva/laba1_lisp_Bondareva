<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Функціональний і імперативний підходи до роботи зі списками"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студентка</b>: Бондарева Валерія Романівна КВ-22</p>
<p align="right"><b>Рік</b>: 2025</p>

## Загальне завдання

Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і
імперативно.

1. Функціональний варіант реалізації має базуватись на використанні рекурсії і
   конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного
   списку. Не допускається використання: псевдо-функцій, деструктивних операцій,
   циклів . Також реалізована функція не має бути функціоналом (тобто приймати на
   вхід функції в якості аргументів).

2. Імперативний варіант реалізації має базуватись на використанні циклів і
   деструктивних функцій (псевдофункцій). Не допускається використання функцій
   вищого порядку або функцій для роботи зі списками/послідовностями, що
   використовуються як функції вищого порядку. Тим не менш, оригінальний список
   цей варіант реалізації також не має змінювати, тому перед виконанням
   деструктивних змін варто застосувати функцію copy-list (в разі необхідності).
   Також реалізована функція не має бути функціоналом (тобто приймати на вхід
   функції в якості аргументів).

## Варіант 1

Алгоритм сортування вибором за незменшенням.

## Лістинг функції з використанням конструктивного підходу

```lisp
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
```

## Лістинг функції з використанням деструктивного підходу

```lisp
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
```

### Тестування

```lisp
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



CL-USER> (test-selection-sort-imp)
passed  imp test 1
passed  imp test 2
passed  imp test 3
passed  imp test 4
FAILED  imp test 5
NIL
CL-USER> (test-selection-sort-func)
passed  func test 1
passed  func test 2
passed  func test 3
passed  func test 4
FAILED  func test 5
NIL
```
