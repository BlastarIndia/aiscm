(use-modules (aiscm variable)
             (aiscm element)
             (oop goops)
             (guile-tap))
(define v1 (make-var))
(define v2 (make-var))
(planned-tests 2)
(ok (eqv? 1 (subst v1 (list (cons v1 1))))
  "substitute variable")
(ok (equal? v2 (subst v2 (list (cons v1 1))))
  "don't substitute variable")
(format #t "~&")
