(use-modules (aiscm element)
             (aiscm mem)
             (aiscm int)
             (aiscm var)
             (aiscm pointer)
             (aiscm lookup)
             (aiscm lambda)
             (oop goops)
             (guile-tap))
(planned-tests 11)
(define m (make <mem> #:size 8))
(write-bytes m #vu8(1 2 3 4 5 6 7 8))
(define p (make (pointer <ubyte>) #:value m))
(define v (make <var>))
(define l (make <lookup> #:value p #:var v #:stride 2))
(define s (make <lambda> #:value l #:index v #:length 4))
(ok (equal? l (get-value s))
  "query term of lambda")
(ok (equal? v (get-index s))
  "query index variable of lambda")
(ok (eqv? 4 (get-length s))
  "query dimension of index of lambda")
(ok (eqv? 5 (get s 2))
  "apply lambda by passing integer")
(ok (eqv? 9 (begin (set s 3 9) (get s 3)))
  "write value to array and read it back")
(ok (eqv? 9 (set s 3 9))
  "write value returns input value")
(ok (equal? <ubyte> (typecode s))
  "query element type of lambda")
(ok (eqv? 4 (size s))
  "query size of lambda")
(ok (equal? '(4) (shape s))
  "query shape of lambda")
(ok (equal? 3 (size (slice s 1 3)))
  "query size of slice")
(ok (equal? (make <lookup> #:value (+ p 2) #:var v #:stride 2)
            (get-value (slice s 1 3)))
  "query lambda term of slice")
(format #t "~&")
