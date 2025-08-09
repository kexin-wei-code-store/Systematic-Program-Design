;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cat) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; My world program  (make this more specific)
;; a cat walks from the left of the screen to the right
;; =================
;; Constants:
(define WIDTH 600)
(define HEIGHT 400)

(define CTR_Y  (/ HEIGHT 2))

(define SPEED 3)

(define MTS (empty-scene WIDTH HEIGHT))
(define CAT_IMG (star 40 "solid" "gray"))


;; =================
;; Data definitions:

;; Cat is Number
;; interp. x position of the cat in the screen
(define C1 0)
(define C2 (/ WIDTH 2))
(define C3 WIDTH)

#;
(define (fn-for-cat c)
  (...c))



;; =================
;; Functions:

;; Cat -> Cat
;; start the world with (main 0)
;; 
(define (main c)
  (big-bang c                           
    (on-tick   advance-cat)         ; Cat -> Cat
    (to-draw   render)              ; Cat -> Image
    (on-key    back-to-start)       ; Cat KeyEvent -> Cat
    )
  )

;; Cat -> Cat
;; produce the next cat by advancing it SPPED pixel to right
(check-expect (advance-cat 3) (+ 3 SPEED))
;(define (advance-cat c) 0)   ; stub
(define (advance-cat c)
  (+ c SPEED))


;; Cat -> Image
;; render the image at appropriate place on MTS
(check-expect (render 4) (place-image CAT_IMG 4 CTR_Y MTS))

;(define (render c) MTS) ;  stub
(define (render c)
  (place-image CAT_IMG c CTR_Y MTS))

;; Cat KeyEvent -> Cat
;; reset the cat to the start of the screen when space is pressed
(check-expect (back-to-start 10 " ") 0)
(check-expect (back-to-start 10 "a") 10)
(check-expect (back-to-start 0  "a") 0)
(check-expect (back-to-start 0 "a")  0)

; (define (back-to-start c ke) 0) ; stub
;(define (back-to-start c ke)
;  (cond [(key=? ke " ") (...c)]
;        [else (...c)]
;        ))

(define (back-to-start c ke)
  (cond [(key=? ke " ") 0]
        [else c]))
        