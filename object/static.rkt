#lang racket

(require [only-in plait test print-only-errors])
(require "msg.rkt")

(print-only-errors)

; static member
(define mk-o-static
  (let ([counter 0])
    (lambda (amount)
      (begin
        (set! counter (+ 1 counter))
        (lambda (m)
          (case m
            [(inc) (lambda () (set! amount (+ amount 1)))]
            [(dec) (lambda () (set! amount (- amount 1)))]
            [(count) (lambda () counter)]
            [(get) (lambda () amount)]))))))

(test (let ([o (mk-o-static 1000)])
        (msg o 'count)) 1)
(test (let ([o (mk-o-static 0)])
        (msg o 'count)) 2)
