(defpackage :audio
  (:use :cl :cffi))

(in-package :audio)

(define-foreign-library simple-lib
  (:unix (:default "libadder"))
  (t (:default "libadder")))

(use-foreign-library simple-lib)

(defcfun ("add_two_numbers" add-two-nums) :int
  (num1 :int)
  (num2 :int))

(defcenum :operator
          (:op-add 1)
          (:op-subtract 2)
          (:op-multiply 3)
          (:op-divide 4))

(defcstruct x-atom
  "simple atom structure holding operands and operator"
  (num1 :int)
  (num2 :int)
  (op :operator))

(defcfun ("operate_numbers" operate-numbers) :int
  (num1 :int)
  (num2 :int)
  (op :operator))

(defcfun ("operate_atom" operate-atom) :int
  (op-atom (:struct x-atom)))

(defun main ()
  (let ((result (add-two-nums 1 2))
        (result/op (operate-numbers 10 2 :op-divide))
        (result/op-a 
          ; a little janky will cleanup later
          (with-foreign-object (obj 'x-atom)
            (setf (foreign-slot-value obj 'x-atom 'num1) 2
                  (foreign-slot-value obj 'x-atom 'num2) 8
                  (foreign-slot-value obj 'x-atom 'op ) :op-add)
            (operate-atom (cffi:mem-ref obj `(:struct x-atom))))))
    (format t "Result: ~a~%" result)  
    (format t "Result/OP: ~a~%" result/op)  
    (format t "Result/OP-A: ~a~%" result/op-a)))

