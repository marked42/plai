#lang racket

(require [only-in plait test print-only-errors])
(require "msg.rkt")

(print-only-errors)

; object
(define o
  (lambda (m)
    (case m
      [(add0) (lambda (x) (+ x 1))]
      [(sub0) (lambda (x) (- x 1))]))
  )

(test (msg o 'add0 5) 6)

; object pattern
(define (o-constr x)
  (lambda (m)
    (case m
      [(addX) (lambda (y) (+ x y))])))

(test (msg (o-constr 4) 'addX 3) 7)
(test (msg (o-constr 1) 'addX 3) 4)
