#lang plait

(print-only-errors #t)

(define-type Exp
  [num (n : Number)]
  [str (s : String)]
  [plus (l : Exp) (r : Exp)]
  [cat (l : Exp) (r : Exp)])

(define-type Value
  [numV (n : Number)]
  [strV (s : String)])

(define (calc e)
  (type-case Exp e
    [(num n) (numV n)]
    [(str s) (strV s)]
    [(plus l r) (num+ (calc l) (calc r))]
    [(cat l r) (str++ (calc l) (calc r))]))

(define (num+ lv rv)
  (type-case Value lv
    [(numV ln)
     (type-case Value rv
       [(numV rn) (numV (+ ln rn))]
       [else (error '+ "right not a number")])]
    [else (error '+ "left not a number")])
  )

(define (str++ lv rv)
  (type-case Value lv
    [(strV ls)
     (type-case Value rv
       [(strV rs) (strV (string-append ls rs))]
       [else (error '++ "right not a string")])]
    [else (error '++ "left not a string")])
  )

(test (calc (plus (num 1) (num 2))) (numV 3))
(test (calc (plus (num 1) (plus (num 2) (num 3)))) (numV 6))
(test (calc (cat (str "hel") (str "lo"))) (strV "hello"))
(test (calc (cat (cat (str "hel") (str "l")) (str "o"))) (strV "hello"))
(test/exn (calc (cat (num 1) (str "hello"))) "left")
(test/exn (calc (plus (num 1) (str "hello"))) "right")
