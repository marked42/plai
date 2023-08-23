#lang plait

(print-only-errors #t)

(define-type Type
  [numT]
  [strT])

(define-type BinOp
  [plus] [++] [/])

(define-type Expr
  [binE (operator : BinOp) (left : Expr) (right : Expr)]
  [numE (value : Number)]
  [strE (value : String)]
  )

(define (tc e)
  (type-case Expr e
    [(binE o l r)
     (type-case BinOp o
       [(plus) (if (and (numT? (tc l)) (numT? (tc r)))
                   (numT)
                   (error 'tc "not both numbers"))]
       [(/) (if (and (numT? (tc l)) (numT? (tc r)))
                (numT)
                (error 'tc "not both numbers"))]
       [(++) (if (and (strT? (tc l)) (strT? (tc r)))
                 (strT)
                 (error 'tc "not both strings"))])]
    [(numE v) (numT)]
    [(strE s) (strT)])
  )

(test (tc (binE (plus) (numE 5) (numE 6))) (numT))
(test (tc (binE (/) (numE 5) (numE 6))) (numT))
(test (tc (binE (++) (strE "hello") (strE "world"))) (strT))

(test/exn (tc (binE (++) (numE 5) (numE 6))) "strings")
(test/exn (tc (binE (plus) (strE "hello") (strE "world"))) "numbers")
(test/exn (tc (binE (/) (strE "hello") (strE "world"))) "numbers")
