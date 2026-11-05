(defpackage :learn-alien
  (:use :cl :sb-alien))

(in-package :learn-alien)

(load-shared-object "libadder.so")

(define-alien-routine "add_two_numbers" int
                      (num1 int :in)
                      (num2 int :in))

(add-two-numbers 1 4)

(define-alien-type nil
                   (enum operator
                         (:op-add 1)
                         (:op-subtract 2)
                         (:op-multiply 3)
                         (:op-divide 4)))

(define-alien-routine "operate_numbers" int
                      (num1 int :in)
                      (num2 int :in)
                      (op (enum operator) :in))

(operate-numbers 10 4 :op-multiply)

(define-alien-type nil
                   (struct c-atom
                           (num1 int)
                           (num2 int)
                           (op (enum operator))))

(define-alien-routine "operate_atom" int
                      (c-atom (struct c-atom) :in))

(with-alien ((my-atom (struct c-atom)))
  (setf (slot my-atom 'num1) 10
        (slot my-atom 'num2) 2
        (slot my-atom 'op) :op-divide)
  (operate-atom my-atom))

; While I can't quite tell you why. I think I like sbcl-alien over cffi

(define-alien-routine "operate_atom_ref" int
                      (c-atom (* (struct c-atom)) :in))

(with-alien ((my-atom (struct c-atom)))
  (setf (slot my-atom 'num1) 4
        (slot my-atom 'num2) 1
        (slot my-atom 'op) :op-subtract)
  (operate-atom-ref (addr my-atom)))

; This is beautiful and cohesive.
; Like programming was meant to be.
