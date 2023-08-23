#lang typed/racket

(define (f [s : String]) : Number
  (+ 1 (or (string->number s) 0)))

; type error
; (define (f [s : String]) : Number
;   (+ 1 (string->number s)))
