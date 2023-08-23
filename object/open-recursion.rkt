#lang racket

(require [only-in plait test print-only-errors])
(require "msg.rkt")

(provide (all-defined-out))

(print-only-errors)

(define (node)
  (let ([self 'dummy])
    (begin
      (set! self
            (lambda (m)
              (case m
                [(left) (lambda (self) (begin (println "node left") 0))]
                [(right) (lambda (self) (begin (println "node right") 1))]
                [(sum) (lambda (self) (+ (msg/self self 'left) (msg/self self 'right)))])))
      self)))

(define (child-node/closed parent-maker)
  (let ([parent-object (parent-maker)]
        [self 'dummy])
    (begin
      (set! self
            (lambda (m)
              (case m
                [(left) (lambda (self) (begin (println "child-node/closed left") 10))]
                [(right) (lambda (self) (begin (println "child-node/closed right") 20))]
                ; closed on parent-object
                [(sum) (lambda (self) (msg/self parent-object m))])
              )
            )
      self)))

(define (child-node/open parent-maker)
  (let ([parent-object (parent-maker)]
        [self 'dummy])
    (begin
      (set! self
            (lambda (m)
              (case m
                [(left) (lambda (self) (begin (println "child-node/open left") 10))]
                [(right) (lambda (self) (begin (println "child-node/open right") 20))]
                ; open recursion
                [(sum) (parent-object m)])
              )
            )
      self)))

(test (msg/self (child-node/closed node) 'sum) (+ 0 1))
(test (msg/self (child-node/open node) 'sum) (+ 10 20))
