(defpackage :raylib-example
  (:use :cl :sb-alien :sb-thread))

(in-package :raylib-example)

(load-shared-object "libraylib.so")

;; Types
(define-alien-type nil
                   (struct color
                           (r unsigned-char)
                           (g unsigned-char)
                           (b unsigned-char)
                           (a unsigned-char)))

(define-alien-type nil 
                   (enum keyboardkey
                         (:key-null 0) ; key: null, used for no key pressed
                         ; alphanumeric keys
                         (:key-apostrophe 39) ; key: '
                         (:key-comma 44) ; key: ,
                         (:key-minus 45) ; key: -
                         (:key-period 46) ; key: .
                         (:key-slash 47) ; key: /
                         (:key-zero 48) ; key: 0
                         (:key-one 49) ; key: 1
                         (:key-two 50) ; key: 2
                         (:key-three 51) ; key: 3
                         (:key-four 52) ; key: 4
                         (:key-five 53) ; key: 5
                         (:key-six 54) ; key: 6
                         (:key-seven 55) ; key: 7
                         (:key-eight 56) ; key: 8
                         (:key-nine 57) ; key: 9
                         (:key-semicolon 59) ; key: ;
                         (:key-equal 61) ; key: =
                         (:key-a 65) ; key: a | a
                         (:key-b 66) ; key: b | b
                         (:key-c 67) ; key: c | c
                         (:key-d 68) ; key: d | d
                         (:key-e 69) ; key: e | e
                         (:key-f 70) ; key: f | f
                         (:key-g 71) ; key: g | g
                         (:key-h 72) ; key: h | h
                         (:key-i 73) ; key: i | i
                         (:key-j 74) ; key: j | j
                         (:key-k 75) ; key: k | k
                         (:key-l 76) ; key: l | l
                         (:key-m 77) ; key: m | m
                         (:key-n 78) ; key: n | n
                         (:key-o 79) ; key: o | o
                         (:key-p 80) ; key: p | p
                         (:key-q 81) ; key: q | q
                         (:key-r 82) ; key: r | r
                         (:key-s 83) ; key: s | s
                         (:key-t 84) ; key: t | t
                         (:key-u 85) ; key: u | u
                         (:key-v 86) ; key: v | v
                         (:key-w 87) ; key: w | w
                         (:key-x 88) ; key: x | x
                         (:key-y 89) ; key: y | y
                         (:key-z 90) ; key: z | z
                         (:key-left-bracket 91) ; key: [
                         (:key-backslash 92) ; key: '\'
                         (:key-right-bracket 93) ; key: ]
                         (:key-grave 96) ; key: `
                         ; function keys
                         (:key-space 32) ; key: space
                         (:key-escape 256) ; key: esc
                         (:key-enter 257) ; key: enter
                         (:key-tab 258) ; key: tab
                         (:key-backspace 259) ; key: backspace
                         (:key-insert 260) ; key: ins
                         (:key-delete 261) ; key: del
                         (:key-right 262) ; key: cursor right
                         (:key-left 263) ; key: cursor left
                         (:key-down 264) ; key: cursor down
                         (:key-up 265) ; key: cursor up
                         (:key-page-up 266) ; key: page up
                         (:key-page-down 267) ; key: page down
                         (:key-home 268) ; key: home
                         (:key-end 269) ; key: end
                         (:key-caps-lock 280) ; key: caps lock
                         (:key-scroll-lock 281) ; key: scroll down
                         (:key-num-lock 282) ; key: num lock
                         (:key-print-screen 283) ; key: print screen
                         (:key-pause 284) ; key: pause
                         (:key-f1 290) ; key: f1
                         (:key-f2 291) ; key: f2
                         (:key-f3 292) ; key: f3
                         (:key-f4 293) ; key: f4
                         (:key-f5 294) ; key: f5
                         (:key-f6 295) ; key: f6
                         (:key-f7 296) ; key: f7
                         (:key-f8 297) ; key: f8
                         (:key-f9 298) ; key: f9
                         (:key-f10 299) ; key: f10
                         (:key-f11 300) ; key: f11
                         (:key-f12 301) ; key: f12
                         (:key-left-shift 340) ; key: shift left
                         (:key-left-control 341) ; key: control left
                         (:key-left-alt 342) ; key: alt left
                         (:key-left-super 343) ; key: super left
                         (:key-right-shift 344) ; key: shift right
                         (:key-right-control 345) ; key: control right
                         (:key-right-alt 346) ; key: alt right
                         (:key-right-super 347) ; key: super right
                         (:key-kb-menu 348) ; key: kb menu
                         ; keypad keys
                         (:key-kp-0 320) ; key: keypad 0
                         (:key-kp-1 321) ; key: keypad 1
                         (:key-kp-2 322) ; key: keypad 2
                         (:key-kp-3 323) ; key: keypad 3
                         (:key-kp-4 324) ; key: keypad 4
                         (:key-kp-5 325) ; key: keypad 5
                         (:key-kp-6 326) ; key: keypad 6
                         (:key-kp-7 327) ; key: keypad 7
                         (:key-kp-8 328) ; key: keypad 8
                         (:key-kp-9 329) ; key: keypad 9
                         (:key-kp-decimal 330) ; key: keypad .
                         (:key-kp-divide 331) ; key: keypad /
                         (:key-kp-multiply 332) ; key: keypad *
                         (:key-kp-subtract 333) ; key: keypad -
                         (:key-kp-add 334) ; key: keypad +
                         (:key-kp-enter 335) ; key: keypad enter
                         (:key-kp-equal 336) ; key: keypad =
                         ; android key buttons
                         (:key-back 4) ; key: android back button
                         (:key-menu 5) ; key: android menu button
                         (:key-volume-up 24) ; key: android volume up button
                         (:key-volume-down 25) ; key: android volume down button
                         ))



;; Window
(define-alien-routine ("InitWindow" init-window) void
                      (width int)
                      (height int)
                      (title c-string))

(define-alien-routine ("CloseWindow" close-window) void)

(define-alien-routine ("SetTargetFPS" set-target-fps) void
                      (fps int))

(define-alien-routine ("WindowShouldClose" window-should-close) boolean)

(define-alien-routine ("GetFPS" get-fps) int)

;; Input
(define-alien-routine ("IsKeyPressed" key-pressedp) boolean
                      (key (enum keyboardkey)))

;; Drawing
(define-alien-routine ("BeginDrawing" begin-drawing) void)
(define-alien-routine ("EndDrawing" end-drawing) void)

(define-alien-routine ("DrawCircle" draw-circle) void
                      (center-x int)
                      (center-y int)
                      (radius float)
                      (color (struct color)))

(define-alien-routine ("ClearBackground" clear-bg) void
                      (color (struct color)))

(define-alien-routine ("DrawFPS" draw-fps) void
                      (posx int)
                      (posy int))

;; Utility functions
(defun make-color (r g b &optional (a #xFF))
  (let ((color (make-alien (struct color))))
    (setf (slot color 'r) r)
    (setf (slot color 'g) g)
    (setf (slot color 'b) b)
    (setf (slot color 'a) a)
    color))

;; Player class

(defclass player ()
  ((x 
     :type number
     :initarg :x
     :initform 0
     :accessor :x
     :documentation "x coordinate of the player")
   (y 
     :type number
     :initarg :y
     :initform 0
     :accessor :y
     :documentation "y coordinate of the player")
   (color
     :initform (make-color #xff #x00 #xff)
     :accessor :color)))

(defgeneric draw (object)
  (:documentation "draws a an object in raylib"))

(defmethod draw ((object player))
  (with-accessors ((x :x)
                   (y :y)
                   (color :color)) object
    (draw-circle x y 50.0 (deref color))))

(defgeneric update (object)
  (:documentation "updates an object"))

(defmethod update ((object player))
  (let ((speed 5))
    (when (key-pressedp :key-j) (decf (:y object) speed))
    (when (key-pressedp :key-k) (incf (:y object) speed)) 
    (when (key-pressedp :key-h) (incf (:x object) speed)) 
    (when (key-pressedp :key-l) (decf (:x object) speed))))

;; Working Area
(defun main () 
  (init-window 400 400 "hello world")
  (set-target-fps 60)
  (let ((bg-color (make-color #x00 #x00 #x00)) 
        (player (make-instance 'player :x 100 :y 100)))
    (unwind-protect 
      (loop
        :when (window-should-close) :do (return)
        :do
        ;; game loop
        (update player)
        ;; update window
        (clear-bg (deref bg-color))
        (begin-drawing)
        (draw player)
        (draw-fps 0 0)
        (end-drawing))

      (free-alien bg-color)
      (free-alien (:color player))
      (close-window))))

(make-thread #'main :name "primary-game-thread")
