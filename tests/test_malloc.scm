(use-modules (oop goops)
             (unit-test)
             (aiscm malloc))
(define m (make-malloc 10))
(define-class <test-malloc> (<test-case>))
(define-method (test-make-malloc-three-elements (self <test-malloc>))
  (assert-equal 3 (length m)))
(define-method (test-make-malloc-equal-pointers (self <test-malloc>))
  (assert-equal (car m) (cadr m)))
(define-method (test-make-malloc-stores-size (self <test-malloc>))
  (assert-equal 10 (caddr m)))
(define-method (test-malloc-plus-reduces-size (self <test-malloc>))
  (assert-equal 4 (caddr (malloc-plus m 6))))
(define-method (test-malloc-plus-check-offset-gt-zero (self <test-malloc>))
  (assert-exception (malloc-plus m -1)))
(define-method (test-malloc-plus-check-offset-lt-size (self <test-malloc>))
  (assert-exception (malloc-plus m 11)))
(define-method (test-malloc-read-write (self <test-malloc>))
  (begin
    (malloc-write m #vu8(2 3 5 7))
    (assert-equal #vu8(2 3 5) (malloc-read m 3))))
(define-method (test-malloc-read-write-with-offset (self <test-malloc>))
  (begin
    (malloc-write m #vu8(2 3 5 7))
    (assert-equal #vu8(3 5 7) (malloc-read (malloc-plus m 1) 3))))
(define-method (test-malloc-read-write-overlap (self <test-malloc>))
  (begin
    (malloc-write m #vu8(1 1 1 1))
    (malloc-write m #vu8(2 2))
    (assert-equal #vu8(2 2 1 1) (malloc-read m 4))))
(define-method (test-malloc-read-overrun (self <test-malloc>))
  (assert-exception (malloc-read m 11)))
(define-method (test-malloc-write-overrun (self <test-malloc>))
  (assert-exception (malloc-write m #vu8(1 2 3 4 5 6 7 8 9 10 11))))
(exit-with-summary (run-all-defined-test-cases))
