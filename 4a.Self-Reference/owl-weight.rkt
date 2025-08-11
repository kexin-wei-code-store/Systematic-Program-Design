;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname owl-weight) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ================ Data definitions ====================
;; ListOfNumber is one of :
;; - empty
;; - (cons Number ListOfNumber)
;; interp. each number is an owl weight

(define LON1 empty)
(define LON2 (cons 60 (cons 42 empty)))

(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]
        ))
;; template used
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Number ListOfString)
;; - self-reference: (rest lon) is ListOfNumber

;; =============== Functions ============================

;; ListOfNumber -> Number
;; produce total weight of owls
(check-expect (sum empty) 0)
(check-expect (sum (cons 60 empty)) 60)
(check-expect (sum (cons 60 (cons 42 empty))) 102)

;(define (sum lon) 0) ;; stub
(define (sum lon)
  (cond [(empty? lon) 0]
        [else
         (+ (first lon)
              (sum (rest lon)))]
        ))

;; ListOfNumber -> Natural
;; propduce total number of weights
(check-expect (count empty) 0)
(check-expect (count (cons 60 empty)) 1)
(check-expect (count (cons 60 (cons 52 empty))) 2)

;(define (count lon) 0) ;;stub
(define (count lon)
  (cond [(empty? lon) 0]
        [else
         (+ 1 (count (rest lon)))]
        ))