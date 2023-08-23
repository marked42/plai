#lang racket

(provide (all-defined-out))

(define (msg o m . a)
  (apply (o m) a)
  )

(define (msg/self o m . a)
  (apply (o m) o a))
