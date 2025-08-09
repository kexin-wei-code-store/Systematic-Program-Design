;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname yell-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; String -> String
;; a "!" to the end of the string

(check-expect (yell "hello") "hello!") ; examples
(check-expect (yell "yes") "yes!")


;(define (yell str) "") ;stub
;(define (yell str) ; tempalte
;  (... str))
(define (yell str)
  (string-append str "!")
  )