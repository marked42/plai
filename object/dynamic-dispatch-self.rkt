#lang racket

(require [only-in plait test print-only-errors])
(require "msg.rkt")

(provide (all-defined-out))

(print-only-errors)

; dynamic dispatch using self-application
(define (mt/self)
  (lambda (m)
    (case m
      [(sum) (lambda (self) 0)])))

(define (node/self v l r)
  (lambda (m)
    (case m
      [(sum) (lambda (self)
               (+ v (msg/self l 'sum) (msg/self r 'sum)))])))

(define a-tree/self
  (node/self 10
             (node/self 5 (mt/self) (mt/self))
             (node/self 15 (node/self 6 (mt/self) (mt/self)) (mt/self))))

(test (msg/self a-tree/self 'sum) (+ 10 5 15 6))
