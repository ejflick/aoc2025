#lang racket

(require racket/list/iteration)

(define file-lines (file->lines "inputs/day1"))

(define lines-as-clicks
  (map (λ (l)
         (let ([tail-as-number (string->number (substring l 1 (string-length l)))])
           (if (equal? (string-ref l 0) #\R)
               tail-as-number
               (* -1 tail-as-number))))
       file-lines))

(define running-totals
  (map (let ([total 50])
         (λ (x)
           (set! total (+ total x))
           total))
       lines-as-clicks))

(define running-totals-adjusted
  (map (λ (t)
         (modulo t 100))
       running-totals))

(define part1-answer
  (count zero? running-totals-adjusted))

(define (each-pair f lst)
  (if (or (empty? lst) (empty? (cdr lst)))
      '()
      (cons (f (first lst) (second lst)) (each-pair f (rest lst)))))

(define part2-answer
  (let* ([adjusted-clicks (cons 50 lines-as-clicks)]
         [running-totals (running-foldl +
                                        0
                                        adjusted-clicks)]
         [hmm (map (λ (t)
                     (floor (/ t 100)))
                   running-totals)]
         [combined (each-pair cons hmm)]
         [deltas (map (λ (x)
                        (abs (- (cdr x) (car x))))
                      combined)])
    (foldl + 0 deltas)))