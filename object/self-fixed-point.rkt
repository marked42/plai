#lang racket

(require [only-in plait test print-only-errors])
(require "msg.rkt")

(print-only-errors)

(define o-self-no!
  (lambda (m)
    (case m
      [(first) (lambda (self x) (msg/self self 'second (+ x 1)))]
      [(second) (lambda (self x) (+ x 1))]))
  )

(test (msg/self o-self-no! 'first 5) 7)
