;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname quiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDD Design Quiz

;; Age is Natural
;; interp. the age of a person in years
(define A0 18)
(define A1 25)

#;
(define (fn-for-age a)
  (... a))

;; Template rules used:
;; - atomic non-distinct: Natural


; Problem 1:
; 
; Consider the above data definition for the age of a person.
; 
; Design a function called teenager? that determines whether a person
; of a particular age is a teenager (i.e., between the ages of 13 and 19).

(check-expect (teenager? 12) false)
(check-expect (teenager? 13) true)
(check-expect (teenager? 18) true)
(check-expect (teenager? 19) true)
(check-expect (teenager? 25) false)

;(define (teenager? t) true) ;; stub

; <template borrowed from Age>
(define (teenager? a)
  (<= 13 a 19))



; Problem 2:
; 
; Design a data definition called MonthAge to represent a person's age
; in months.

;; MonthAge is Natual
;; interp. the age in months as a number
(define M0 2)
(define M1 23)

#;
(define (fn-for-month-age m)
  (...m))

; Problem 3:
; 
; Design a function called months-old that takes a person's age in years 
; and yields that person's age in months.
; 

;; Number -> MonthAge
;; given age in years produce 12*years for monthage

(check-expect (months-old 0) 0)
(check-expect (months-old 2) 24)
(check-expect (months-old 21) 252)

;(define (months-old m) 2) ;; stub

; <template borrowed from MonthAge>

(define (months-old m)
  (* 12 m))

; Problem 4:
; 
; Consider a video game where you need to represent the health of your
; character. The only thing that matters about their health is:
; 
;   - if they are dead (which is shockingly poor health)
;   - if they are alive then they can have 0 or more extra lives
; 
; Design a data definition called Health to represent the health of your
; character.
; 
; Design a function called increase-health that allows you to increase the
; lives of a character.  The function should only increase the lives
; of the character if the character is not dead, otherwise the character
; remains dead.

;; Health is one of
;; - false
;; - Number [0,1,2,3...]
;; interp. whether the character is alive or not

(define H1 false)
(define H2 0)
(define H3 2)

#;
(define (fn-for-health h)
  (cond [(false? h) (...)]
        [else (...h)]
        ))

;; Health -> Health
;; if still alive increase life and produce new health, else return old health

(check-expect (increase-health false) false)
(check-expect (increase-health 0) 1)
(check-expect (increase-health 1) 2)
(check-expect (increase-health 3) 4)

;(define (increase-health h) false) ;; stub
; <template borrowed from Health>

(define (increase-health h)
  (cond [(false? h) false]
        [else (+ 1 h)]
        ))
