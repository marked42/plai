#lang racket

(require [only-in plait test print-only-errors])

(print-only-errors)

; private members, use init to initialize private member count, which is not accessible from outside
(define (mk-o-state/priv init)
  (let ([count init])
    (lambda (m)
      (case m
        [(inc) (lambda () (set! count (+ count 1)))]
        [(dec) (lambda () (set! count (- count 1)))]
        [(get) (lambda () count)]))))
