#lang plait

(print-only-errors #true)

(define-type BinOp
  [plus] [++])

(define-type Expr
  [binE (operator : BinOp) (left : Expr) (right : Expr)]
  [numE (value : Number)]
  [strE (value : String)]
  )

; tc: (Expr -> Boolean)
(define (tc e)
  (type-case Expr e
    [(binE o l r)
     (type-case BinOp o
       [(plus) (and (tc l) (tc r))]
       [(++) (and (tc l) (tc r))])]
    [(numE v) #true]
    [(strE s) #t]))

(test (tc (binE (plus) (numE 5) (numE 6))) #t)
; type checker tc: (Expr -> Boolean) cannot detect type errors below
; ++ should apply to strings, plus should apply to numbers only.
(test (tc (binE (++) (numE 5) (numE 6))) #f)
(test (tc (binE (plus) (strE "hello") (strE "world"))) #f)
