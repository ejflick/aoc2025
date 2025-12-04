#lang racket

(define file-contents (file->lines "inputs/day4"))

(define cells
  (list->vector (map (λ (row)
                       (list->vector (string->list (string-trim row))))
                     file-contents)))

(define (cell-at x y)
  (vector-ref (vector-ref cells y) x))

(define directions (list '(-1 . -1) '(0 . -1) '(1 . -1)
                         '(-1 . 0) '(1 . 0)
                         '(-1 . 1) '(0 . 1) '(1 . 1)))

(define (dir-x d) (car d))
(define (dir-y d) (cdr d))

(define (within-grid? pos)
  (let ([x (car pos)]
        [y (cdr pos)])
    (and (>= x 0) (< x (vector-length cells))
         (>= y 0) (< y (vector-length (vector-ref cells 0))))))

(define (neighbor-positions x y)
  (filter within-grid?
          (map (λ (dir)
                 (cons (+ x (dir-x dir))
                       (+ y (dir-y dir))))
               directions)))

(define (neighbor-x n) (car n))
(define (neighbor-y n) (cdr n))

(define (neighbors x y)
  (map (λ (neighbor)
         (cell-at (neighbor-x neighbor) (neighbor-y neighbor)))
       (neighbor-positions x y)))

(define (is-roll? x)
  (char=? x #\@))

(define (adjacent-rolls x y)
  (count is-roll? (neighbors x y)))

(define part1-answer
  (for/sum ([y (range 0 (vector-length cells))])
    (for/sum ([x (range 0 (vector-length (vector-ref cells y)))])
      (if (and (char=? (cell-at x y) #\@) (< (adjacent-rolls x y) 4))
          1
          0))))