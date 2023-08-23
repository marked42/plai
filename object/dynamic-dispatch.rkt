#lang racket

(require [only-in plait test print-only-errors])
(require "msg.rkt")

(provide (all-defined-out))

(print-only-errors)

; dynamic dispatch
(define (mt)
  (let ([self 'dummy])
    (begin
      (set! self
            (lambda (m)
              (case m
                [(sum) (lambda () 0)])))
      self)))

(define (node v l r)
  (let ([self 'dummy])
    (begin
      (set! self
            (lambda (m)
              (case m
                [(sum) (lambda () (+ v (msg l 'sum) (msg r 'sum)))])))
      self)))

(define a-tree
  (node 10
        (node 5 (mt) (mt))
        (node 15 (node 6 (mt) (mt)) (mt))))

(test (msg a-tree 'sum) (+ 10 5 15 6))
