#lang racket

(require [only-in plait test print-only-errors])
(require "msg.rkt")

(print-only-errors)

; class
(define (mk-o-state count)
  (lambda (m)
    (case m
      [(inc) (lambda () (set! count (+ count 1)))]
      [(dec) (lambda () (set! count (- count 1)))]
      [(get) (lambda () count)])))

(test (let ([o (mk-o-state 5)])
        (begin (msg o 'inc)
               (msg o 'inc)
               (msg o 'dec)
               (msg o 'get))) 6)

(test (let ([o1 (mk-o-state 3)]
            [o2 (mk-o-state 3)])
        (begin (msg o1 'inc)
               (msg o1 'inc)
               (+ (msg o1 'get)
                  (msg o2 'get)))) 8)
