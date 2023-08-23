#lang racket

(require [only-in plait test print-only-errors])
(require "msg.rkt" "dynamic-dispatch-self.rkt")

(print-only-errors)

(define (node/self/size parent-maker v l r)
  (let ([parent-object (parent-maker v l r)])
    (lambda (m)
      (case m
        [(size) (lambda (self) (+ 1 (msg/self l 'size) (msg/self r 'size)))]
        [else (parent-object m)]))
    ))

(define (mt/self/size parent-maker)
  (let ([parent-object (parent-maker)])
    (lambda (m)
      (case m
        [(size) (lambda (self) 0)]
        [else (parent-object m)]))))

(define a-tree/self/size
  (node/self/size node/self
                  10
                  (node/self/size node/self 5 (mt/self/size mt/self) (mt/self/size mt/self))
                  (node/self/size node/self 15
                                  (node/self/size node/self 6 (mt/self/size mt/self) (mt/self/size mt/self))
                                  (mt/self/size mt/self))))

(test (msg/self a-tree/self/size 'sum) (+ 10 5 15 6))
(test (msg/self a-tree/self/size 'size) 4)
