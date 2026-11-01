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

(defun main ()
  (let ((result (add-two-nums 1 2)))
    (format t "Result: ~a~%" result)))
