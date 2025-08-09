;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDF) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;signature: number -> number
; 2 times fo the given number

;examples
(check-expect (double 3) 6)
(check-expect (double 3.2) 6.4)

;(define (double a) 0); stub

;(define (double a) ;template
;  (... a))

(define (double a)
  (* 2 a))