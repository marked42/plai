#lang typed/racket

(struct mt ())

(define-type-alias BT (U mt node))

(struct node ([v : Number] [l : BT] [r : BT]))

(define t1
  (node 5
        (node 3
              (node 1 (mt) (mt))
              (mt))
        (node 7
              (mt)
              (node 9 (mt) (mt)))))

(define (size-tr [t : BT]) : Number
  (cond
    [(mt? t) 0]
    ; node? narrows t from type BT to node
    [(node? t) (+ 1 (size-tr (node-l t)) (size-tr (node-r t)))]))

(define (size-tr-wrong [t : BT]) : Number
  ; type error
  (+ 1 (size-tr-wrong (node-l t)) (size-tr-wrong (node-r t))))

(define (size-tr-w2 [t : BT]) : Number
  (cond
    [(node? t) 0]
    [(mt? t) (+ 1 (size-tr-w2 (node-l t)) (size-tr-w2 (node-r t)))])
  )

(define (size-tr-else [t : BT]) : Number
  (cond
    [(mt? t) 0]
    [else (+ 1 (size-tr (node-l t)) (size-tr (node-r t)))]))
