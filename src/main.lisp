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

(defcfun ("operate_numbers" operate-numbers) :int
  (num1 :int)
  (num2 :int)
  (op :operator))

(defun main ()
  (let ((result (add-two-nums 1 2))
        (result/op (operate-numbers 10 2 :op-divide)))
    (format t "Result: ~a~%" result)  
    (format t "Result/OP: ~a~%" result/op)))
