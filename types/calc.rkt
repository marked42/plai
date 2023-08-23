#lang plait

(print-only-errors #true)

(define-type BinOp
  [plus])

(define-type Expr
  [binE (operator : BinOp) (left : Expr) (right : Expr)]
  [numE (value : Number)]
  )

; calc: (Expr -> Boolean)
(define (calc e)
  (type-case Expr e
    [(binE o l r)
     (type-case BinOp o
       [(plus) (+ (calc l) (calc r))])]
    [(numE v) v]))

(test (calc (binE (plus) (numE 5) (numE 6))) 11)
