#lang racket

(require [only-in plait test print-only-errors])
(require "msg.rkt")

(print-only-errors)

; self without mutation, use fixed-point technique
(define o-self!
  (let ([self 'dummy])
    (begin
      (set! self (lambda (m)
                   (case m
                     [(first) (lambda (x) (msg self 'second (+ x 1)))]
                     [(second) (lambda (x) (+ x 1))])))
      self)))

(test (msg o-self! 'first 5) 7)
