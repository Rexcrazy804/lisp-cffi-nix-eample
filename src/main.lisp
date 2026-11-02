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

(defcfun ("operate_atom_ref" operate-atom-ref) :int
  (op-atom (:pointer (:struct x-atom))))

(defun new-x-atom (num1 num2 operator)
  "creates new atom and returns its pointer"
  (let ((obj (foreign-alloc `(:struct x-atom))))
    (setf (foreign-slot-value obj `(:struct x-atom) 'num1) num1
          (foreign-slot-value obj `(:struct x-atom) 'num2) num2
          (foreign-slot-value obj `(:struct x-atom) 'op) operator)
    obj))


(defun main ()
  (let* ((result (add-two-nums 1 2))
         (result/op (operate-numbers 10 2 :op-divide))
         (atom1 (new-x-atom 4 2 :op-multiply))
         (atom2 (new-x-atom 3 2 :op-subtract)))
    (unwind-protect ; I may or may not have lost two pointers somewhere
      (progn 
        (format t "Result: ~a~%" result)  
        (format t "Result/OP: ~a~%" result/op)  
        (format t "Result/OP-A: ~a~%" (operate-atom (mem-ref atom1 `(:struct x-atom))))
        (format t "Result/OP-AR: ~a~%" (operate-atom-ref atom2)))
      (foreign-free atom1)
      (foreign-free atom2))))
