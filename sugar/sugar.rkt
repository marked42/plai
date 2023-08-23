#lang racket

(define (strict-if-fn C T E)
  (if (boolean? C)
      (if C T E)
      (error 'strict-if "expected a boolean")
      )
  )

(define-syntax strict-if
  (syntax-rules ()
    [(strict-if-fn C T E)
     (if (boolean? C)
         (error 'strict-if "expected a boolean")
         )
     ]
    )
  )

(define-syntax my-let1
  (syntax-rules ()
    [(my-let1 (var val) body) ((lambda (var) body) val)])
  )

(println (my-let1 (x 3) (+ x x)))

(define-syntax my-let2
  (syntax-rules ()
    [(my-let2 ([var val] ...) body)
     ((lambda (var ...) body) val ...)
     ]
    )
  )

(define-syntax my-cond
  (syntax-rules ()
    [(my-cond) (error 'my-cond "should not get here")]
    [(my-cond [q0 a0] [q1 a1] ...)
     (if q0 a0 (my-cond [q1 a1] ...))])
  )

(define (sign n)
  (my-cond
   [(< n 0) "negative"]
   [(= n 0) "zero"]
   [(> n 0) "positive"])
  )

(println (sign 1))

(define-syntax unless
  (syntax-rules ()
    [(_ cond body ...)
     (if (not cond)
         (begin body ...)
         (void))]))

(unless false (println 1) (println 2))

(let ([not (lambda (v) v)])
  (unless false
    (println 1)
    (println 2)))

(let ([not (lambda (v) v)])
  (if (not false)
      (begin (println 1) (println 2))
      (void)
      )
  )

(define-syntax or-2
  (syntax-rules ()
    [(_ e1 e2) (let ([v e1]) (if v v e2))]))

(println (or-2 (member 'y '(x y z)) "not found"))
(println (or-2 (print "hello") "not found"))

(define-syntax orN
  (syntax-rules ()
    [(_) false]
    [(_ e1 e2 ...)
     (let ([v e1])
       (if v v (orN e2 ...)))]))

(let ([v true]) (orN false v))
