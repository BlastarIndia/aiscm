(use-modules (aiscm element)
             (aiscm int)
             (oop goops)
             (guile-tap))
(planned-tests 27)
(ok (eqv? 64 (bits (make-int-class 64 signed)))
  "number of bits of integer class")
(ok (signed? (make-int-class 64 signed))
  "signed-ness of signed integer class")
(ok (not (signed? (make-int-class 64 unsigned)))
  "signed-ness of unsigned integer class")
(ok (eqv? 1 (storage-size <byte>))
  "storage size of byte")
(ok (eqv? 2 (storage-size <sint>))
  "storage size of short integer")
(ok (eqv? 4 (storage-size <uint>))
  "storage size of unsigned integer")
(ok (eqv? 8 (storage-size <long>))
  "storage size of long integer")
(ok (equal? (make-ubyte #x21) (make-ubyte #x21))
  "equal integer objects")
(ok (not (equal? (make-ubyte #x21) (make-usint #x4321)))
  "unequal integer objects")
(ok (not (equal? (make-ubyte #x21) (make-usint #x21)))
  "unequal integer objects of different classes")
(ok (eqv? 128 (bits (make-int-class 128 signed)))
  "integer class maintains number of bits")
(ok (signed? (make-int-class 128 signed))
  "integer class maintains signedness for signed integer")
(ok (not (signed? (make-int-class 128 unsigned)))
  "integer class maintains signedness for unsigned integer")
(ok (equal?
      #vu8(#x01 #x02)
      (pack (make (make-int-class 16 unsigned) #:value #x0201)))
  "pack custom integer value")
(ok (equal? #vu8(#xff) (pack (make-ubyte #xff)))
  "pack unsigned byte value")
(ok (equal? #vu8(#x01 #x02) (pack (make-usint #x0201)))
  "pack unsigned short integer value")
(ok (equal? #vu8(#x01 #x02 #x03 #x04) (pack (make-uint #x04030201)))
  "pack unsigned integer value")
(ok (equal? (unpack <ubyte> #vu8(#xff)) (make-ubyte #xff))
  "unpack unsigned byte value")
(ok (equal? (unpack <usint> #vu8(#x01 #x02)) (make-usint #x0201))
  "unpack unsigned short integer value")
(ok (equal? (unpack <uint> #vu8(#x01 #x02 #x03 #x04)) (make-uint #x04030201))
  "unpack unsigned integer value")
(ok (eqv? 127 (get-value (unpack <byte> (pack (make-byte 127)))))
  "pack and unpack signed byte")
(ok (eqv? -128 (get-value (unpack <byte> (pack (make-byte -128)))))
  "pack and unpack signed byte with negative number")
(ok (eqv? 32767 (get-value (unpack <sint> (pack (make-sint 32767)))))
  "pack and unpack signed short integer")
(ok (eqv? -32768 (get-value (unpack <sint> (pack (make-sint -32768)))))
  "pack and unpack signed short integer with negative number")
(ok (eqv? 2147483647 (get-value (unpack <int> (pack (make-int 2147483647)))))
  "pack and unpack signed integer")
(ok (eqv? -2147483648 (get-value (unpack <int> (pack (make-int -2147483648)))))
  "pack and unpack signed integer with negative number")
(ok (equal? (make-byte 123) (subst (make-byte 123) '()))
  "ignores substitutions")
(format #t "~&")
