#lang racket

#| Part 2 isn't solved yet. |#

(define file-contents (string-trim (file->string "inputs/day2")))

(define id-pairs (string-split file-contents ","))

(define id-ranges
  (map (lambda (pair)
         (let ([split (map string->number (string-split pair "-"))])
           (inclusive-range (first split) (second split))))
       id-pairs))

(define ids-flattened (flatten id-ranges))

(define (repeated? n)
  (let* ([as-string (number->string n)]
         [digits# (string-length as-string)])
    (and (> digits# 1)
         (even? digits#)
         (equal? (substring as-string 0 (/ digits# 2))
                 (substring as-string (/ digits# 2) digits#)))))

(define ids-with-repetition
  (filter repeated? ids-flattened))

(define part1-answer (apply + ids-with-repetition))

(define (odd-length-repeats? s)
  (let ([first-char (string-ref s 0)])
    (equal? s
            (list->string (make-list (string-length s)
                                     first-char)))))

(define (string-repeated k s)
  (if (zero? k)
      ""
      (string-append s (string-repeated (- k 1) s))))

(define (even-length-repeats? s)
  (let ([str-len (string-length s)])
    (define (iter end)
      (cond [(zero? end) #f]
            [(zero? (modulo str-len end))
             (or (equal? s (string-repeated (/ str-len end)
                                            (substring s 0 end)))
                 (iter (- end 1)))]
            [else (iter (- end 1))]))

    (if (odd? str-len)
        (iter (floor (/ str-len 2)))
        (iter (/ str-len 2)))))

(define (repeated2+? n)
  (let* ([as-string (number->string n)]
         [str-len (string-length as-string)])
    (cond [(= 1 str-len) #f]
          [else (even-length-repeats? as-string)])))

(define part2-answer
  (apply + (filter repeated2+? ids-flattened)))
