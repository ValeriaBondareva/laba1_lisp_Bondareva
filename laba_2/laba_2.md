<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент(-ка)</b>: Бондарева Валерія Романівна КВ-22</p>
<p align="right"><b>Рік</b>: 2025</p>

## Загальне завдання
Реалізуйте дві рекурсивні функції, що виконують деякі дії з вхідним(и) списком(-ами), за
можливості/необхідності використовуючи різні види рекурсії. Функції, які необхідно
реалізувати, задаються варіантом (п. 2.1.1). Вимоги до функцій:
1. Зміна списку згідно із завданням має відбуватись за рахунок конструювання нового
списку, а не зміни наявного (вхідного).
2. Не допускається використання функцій вищого порядку чи стандартних функцій
для роботи зі списками, що не наведені в четвертому розділі навчального
посібника.
3. Реалізована функція не має бути функцією вищого порядку, тобто приймати функції
в якості аргументів.
4. Не допускається використання псевдофункцій (деструктивного підходу).
5. Не допускається використання циклів.
Кожна реалізована функція має бути протестована для різних тестових наборів. Тести
мають бути оформленні у вигляді модульних тестів (див. п. 2.3).

## Варіант 1
Написати функцію reverse-and-nest-head , яка обертає вхідний список та утворює
вкладeну структуру з підсписків з його елементами, починаючи з голови.

Написати функцію duplicate-elements , що дублює елементи вхідного списку
задану кількість разів.

## Лістинг функції reverse-and-nest-head 
```lisp
(defun reverse-and-nest-head (lst)
  (cond
    ((null lst) nil)
    ((null (cdr lst)) (list (car lst)))             
    (t (list (reverse-and-nest-head (cdr lst))       
             (car lst)))))
```
### Тестові набори та утиліти
```lisp
(defun check-ranh (name input expected)
  (format t "~:[FAILED~;passed~]  reverse-and-nest-head ~a~%"
          (equal (reverse-and-nest-head input) expected)
          name))

(defun test-reverse-and-nest-head ()

  (check-ranh "test 1" '(a b c) '(((C) B) A))

  (check-ranh "test 2" '(a) '(A))

  (check-ranh "test 3" '() nil))

```
## Лістинг функції duplicate-elements
```lisp
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
```
### Тестові набори та утиліти
```lisp
(defun check-dup (name input n expected)
  (format t "~:[FAILED~;passed~]  duplicate-elements ~a~%"
          (equal (duplicate-elements input n) expected)
          name))

(defun test-duplicate-elements ()

  (check-dup "test 1" '(a b c) 3 '(A A A B B B C C C))

  (check-dup "test 2" '(x y) 1 '(X Y))

  (check-dup "test 3" '(a b) 0 nil))

```
### Тестування
```lisp
CL-USER> (test-duplicate-elements)
passed  duplicate-elements test 1
passed  duplicate-elements test 2
passed  duplicate-elements test 3
NIL
CL-USER> (test-reverse-and-nest-head)
passed  reverse-and-nest-head test 1
passed  reverse-and-nest-head test 2
passed  reverse-and-nest-head test 3
NIL
```
