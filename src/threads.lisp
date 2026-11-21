;;;; Simple illustration of using sbcl native threads 
;;;; References: https://lispcookbook.github.io/cl-cookbook/process.html

(defpackage :learn-threads
  (:use cl sb-thread))

(in-package :learn-threads)

(defun print-thread-info ()
  (let* ((cur-thread sb-thread:*current-thread*)
         (cur-thread-name (thread-name cur-thread))
         (all-threads (list-all-threads)))
    (format t "thread: ~a~%" cur-thread)
    (format t "thread name: ~a~%" cur-thread-name)
    (format t "all:~%~{~a~%~}" all-threads)
    )
  )

(print-thread-info)

(defparameter *counter* 0
  "counter variable for testing mutation from threads")

(defun update-global-variable ()
  (make-thread
    (lambda ()
      (sleep 1)
      (incf *counter*)))
  *counter*)


(update-global-variable) ; will return zero, but inspecting the variable 1s later will return 1

(defun print-toplevel ()
  (make-thread
    (lambda ()
      (format t "hi~%"))))

(print-toplevel)

(defun print-toplevel-fixed ()
  (make-thread
    (lambda ()
      (format #.*standard-output* "hi~%"))))

(print-toplevel-fixed)

;; thread locks for avoiding race condition

(defclass bank-account ()
  ((lock
     :initform (make-mutex)
     :accessor :lock) 
   (owner 
     :initarg :owner
     :type string
     :accessor :owner)
   (balance
     :type number
     :initarg :balance
     :initform 0
     :accessor :balance))
  (:documentation "bank account class"))

(defgeneric deposit (account amount)
  (:documentation "method to deposit amount into account"))

(defmethod deposit ((account bank-account) amount)
  (declare (type number amount))
  (with-accessors ((lock :lock)
                   (balance :balance)) account
    (with-mutex (lock)
      (incf balance amount))))

(defparameter *neph-acct* (make-instance 'bank-account :owner "Nephis"
                                         :balance 100000))

(defun slow-gains (acct total)
  (let ((incrementals (floor total 10)))
    (loop
      :for x from 1 to 10
      :do
      (make-thread
        (lambda ()
          (sleep 1)
          (deposit acct incrementals)))
      :finally (return nil))))

(:balance *neph-acct*)

(deposit *neph-acct* 90)

(slow-gains *neph-acct* 100)
