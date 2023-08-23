#lang plait

(define-type Exp
  [num (n : Number)]
  [bool (b : Boolean)]
  [plus (left : Exp) (right : Exp)]
  [cnd (test : Exp) (then : Exp) (else : Exp)]
  )

(define-type Value
  [numV (the-number : Number)]
  [boolV (the-boolean : Boolean)]
  )

(define (calc e)
  (type-case Exp e
    [(num n) (numV n)]
    [(bool b) (boolV b)]
    [(plus l r) (add (calc l) (calc r))]
    ; treats 0 as true, other value as false
    [(cnd c t e) (if (boolean-decision (calc c)) (calc t) (calc e))]
    )
  )

(define (boolean-decision v)
  (type-case Value v
    [(boolV b) b]
    [else (error 'if "expects conditional to evaluate to a boolean")]
    )
  )

(define (add v1 v2)
  (type-case Value v1
    [(numV n1)
     (type-case Value v2
       [(numV n2) (numV (+ n1 n2))]
       [else (error '+ "expects RHS to be a number")]
       )
     ]
    [else (error '+ "expects LHS to be a number")]
    )
  )

(print-only-errors #true)

(test (calc (num 1)) (numV 1))
(test (calc (num 2.3)) (numV 2.3))
(test (calc (plus (num 1) (num 2))) (numV 3))
(test (calc (plus (plus (num 1) (num 2)) (num 3))) (numV 6))
(test (calc (plus (num 1) (plus (num 2) (num 3)))) (numV 6))
(test (calc (plus (num 1)
                  (plus (plus (num 2) (num 3))
                        (num 4)
                        )))
      (numV 10))

(define (parse s)
  (cond
    [(s-exp-number? s) (num (s-exp->number s))]
    [(s-exp-list? s)
     (let ([l (s-exp->list s)])
       (if (symbol=? '+ (s-exp->symbol (first l)))
           (plus (parse (second l))
                 (parse (third l))
                 )
           (error 'parse "list not an addition")
           )
       )
     ]
    )
  )

(test (parse `1) (num 1))
(test (parse `2.3) (num 2.3))
(test (parse `{+ 1 2}) (plus (num 1) (num 2)))
(test (parse `{+ 1
                 {+ {+ 2 3}
                    4}})
      (plus (num 1)
            (plus (plus (num 2)
                        (num 3))
                  (num 4)))
      )

(test/exn (parse `{1 + 2}) "")

(define (run s)
  (calc (parse s))
  )

(test (run `1) (numV 1))
(test (run `2.3) (numV 2.3))
(test (run `{+ 1 2}) (numV 3))
(test (run `{+ {+ 1 2} 3}) (numV 6))
(test (run `{+ 1 {+ 2 3}}) (numV 6))
(test (run `{+ 1 {+ {+ 2 3} 4}}) (numV 10))
