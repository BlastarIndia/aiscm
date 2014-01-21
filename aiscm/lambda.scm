(define-module (aiscm lambda)
  #:use-module (oop goops)
  #:use-module (aiscm element)
  #:use-module (aiscm pointer)
  #:export (<lambda>
            make-lambda
            get-index
            get
            set))
(define-class <lambda> (<element>)
  (index #:init-keyword #:index #:getter get-index))
(define (make-lambda index term)
  (make <lambda> #:index index #:value term))
(define-method (get (self <lambda>) (i <integer>))
  (let ((ptr (subst (get-value self) (list (cons (get-index self) i)))))
    (get-value (fetch ptr))))
(define-method (set (self <lambda>) (i <integer>) value)
  (let ((ptr (subst (get-value self) (list (cons (get-index self) i))))
        (element (make (typecode self) #:value value)))
    (get-value (store ptr element))))
(define-method (typecode (self <lambda>))
  (typecode (get-value self)))
(define-method (size (self <lambda>))
  (let ((value (get-value self)))
    (* (dimension value (get-index self)) (size value))))
(define-method (shape (self <lambda>))
  (let ((value (get-value self)))
    (append (shape value) (list (dimension value (get-index self))))))
