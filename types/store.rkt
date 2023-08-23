#lang plait

(require (typed-in racket/base
                   [char->integer : (Char -> Number)]
                   [integer->char : (Number -> Char)]
                   [number->string : (Number -> String)]))

(print-only-errors #t)

(define NUMBER-TAG 1337)
(define STRING-TAG 5712)
(define MEMORY (make-vector 100 -1))
(define next-addr 0)
(define (write-and-bump v)
  (let ([n next-addr])
    (begin
      (vector-set! MEMORY n v)
      (set! next-addr (add1 next-addr))
      n
      )))

(define (store-num n)
  (let ([a0 (write-and-bump NUMBER-TAG)])
    (write-and-bump n)))

(define (read-num a)
  (vector-ref MEMORY a))

(define (safe-read-num a)
  (if (= (vector-ref MEMORY a) NUMBER-TAG)
      (vector-ref MEMORY (add1 a))
      (error 'number (number->string a))))

(define (store-str s)
  (let ([a0 (write-and-bump STRING-TAG)])
    (begin
      (write-and-bump (string-length s))
      (map write-and-bump
           (map char->integer (string->list s)))
      a0)))

(define (read-str a)
  (letrec ([loop
            (lambda (count a)
              (if (zero? count)
                  empty
                  (cons (vector-ref MEMORY a)
                        (loop (sub1 count) (add1 a)))))])
    (list->string
     (map integer->char (loop (vector-ref MEMORY a) (add1 a))))))

(define (safe-read-str a)
  (if (= (vector-ref MEMORY a) STRING-TAG)
      (letrec ([loop
                (lambda (count a)
                  (if (zero? count)
                      empty
                      (cons (vector-ref MEMORY a)
                            (loop (sub1 count) (add1 a)))))])
        (list->string
         (map integer->char (loop (vector-ref MEMORY a) (add1 a)))))
      (error 'string (number->string a)))
  )
