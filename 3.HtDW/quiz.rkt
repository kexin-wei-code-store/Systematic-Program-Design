;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname quiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; =========== Constants ==============
(define WIDTH 600)
(define HEIGHT 30)

(define TEXT-SIZE HEIGHT)
(define TEXT-WIDTH 12.2)
(define TEXT-COLOR "black")
(define CURSOR-COLOR "red")

(define MTS (empty-scene WIDTH HEIGHT))

;; =========== Data =====================

(define-struct textbox (context cursor))
;; Textbox is made by (String Number[0,len(String)]
;; interp. content that with cursor showing at index of the string

#;
(define (fn-for-textbox tb)
  (... (textbox-context tb)
       (textbox-cursor tb)
       ))
(define TB1 (make-textbox "testeds" 0))
(define TB2 (make-textbox "testeds" 4))
(define TB3 (make-textbox "testeds" 7))
;; ========= Functions ==================
;; main
(define (main tb)
  (big-bang tb
    (to-draw render-textbox)    ; Textbox->Image
    (on-key edit-textbox)       ; Textbox, KeyEvent->Textbox
    ))

; Textbox->Image
(check-expect (render-textbox TB1)
  (place-image/align
   (add-line
    (text "testeds"
        TEXT-SIZE
        TEXT-COLOR)
    (text-width-to-cursor TB1) 0
    (text-width-to-cursor TB1) HEIGHT CURSOR-COLOR)
    2 0 "left" "top" MTS)
)

(check-expect (render-textbox TB2)
  (place-image/align
   (add-line
    (text "testeds"
        TEXT-SIZE
        TEXT-COLOR)
    (text-width-to-cursor TB2) 0
    (text-width-to-cursor TB2) HEIGHT CURSOR-COLOR)
    2 0 "left" "top" MTS)
)

(check-expect (render-textbox TB3)
  (place-image/align
   (add-line
    (text "testeds"
        TEXT-SIZE
        TEXT-COLOR)
    (text-width-to-cursor TB3) 0
    (text-width-to-cursor TB3) HEIGHT CURSOR-COLOR)
    2 0 "left" "top" MTS)
)

(define (render-textbox tb)
  (place-image/align
   (add-line
    (text
     (textbox-context tb)
        TEXT-SIZE
        TEXT-COLOR)
     (text-width-to-cursor tb) 0
     (text-width-to-cursor tb) HEIGHT CURSOR-COLOR)
    2 0 "left" "top" MTS)
)

; Textbox -> Number
(check-expect (text-width-to-cursor (make-textbox "231" 0)) 0)
(check-expect (text-width-to-cursor (make-textbox "231" 2)) 34)
(check-expect (text-width-to-cursor (make-textbox "testetw" 7)) 92)
(check-expect (text-width-to-cursor (make-textbox "2123:!sasd" 9)) 131)

;(define (text-width-to-cursor tb) 1)   ; stub
(define (text-width-to-cursor tb)
  (image-width
   (text (text-before-cursor tb)
    TEXT-SIZE TEXT-COLOR)))

; Textbox->String
(check-expect (text-before-cursor (make-textbox "tests" 3)) "tes")
(check-expect (text-before-cursor (make-textbox "tests" 0)) "")
;(define (text-before-cursor tb) "test") ; stub
(define (text-before-cursor tb)
  (substring
     (textbox-context tb)
     0 (textbox-cursor tb)))

; Textbox->String
(check-expect (text-after-cursor (make-textbox "tests" 3)) "ts")
(check-expect (text-after-cursor (make-textbox "tests" 0)) "tests")
(check-expect (text-after-cursor (make-textbox "tests" 5)) "")
;(define (text-after-cursor tb) "test") ; stub
(define (text-after-cursor tb)
  (substring
     (textbox-context tb)
      (textbox-cursor tb) (string-length (textbox-context tb))))

; Textbox->Textbox
(check-expect (edit-textbox (make-textbox "test" 2) ;; insert
                            "3")
              (make-textbox "te3st" 3))

(check-expect (edit-textbox (make-textbox "test" 2) ;; delete
                            "\b")
              (make-textbox "tst" 1))

(check-expect (edit-textbox (make-textbox "test" 2) ;; move right
                            "right")
              (make-textbox "test" 3))
(check-expect (edit-textbox (make-textbox "test" 4) ;; move right
                            "right")
              (make-textbox "test" 4))

(check-expect (edit-textbox (make-textbox "test" 2) ;; move left
                            "left")
              (make-textbox "test" 1))
(check-expect (edit-textbox (make-textbox "test" 0) ;; move left
                            "left")
              (make-textbox "test" 0))

;(define (edit-textbox tb ke) (make-textbox "test" 2)) ;stub
(define (edit-textbox tb ke)
  (limit-cursor
   (cond [(key=? ke "left") (make-textbox (textbox-context tb) (- (textbox-cursor tb) 1))]
         [(key=? ke "right") (make-textbox (textbox-context tb) (+ (textbox-cursor tb) 1))]
         [(key=? ke "\b") (make-textbox
                           (string-append (remove-last-char (text-before-cursor tb)) (text-after-cursor tb))
                           (- (textbox-cursor tb) 1))]
         [(= (string-length ke) 1) (make-textbox
                                    (string-append (text-before-cursor tb) ke (text-after-cursor tb))
                                    (+ (textbox-cursor tb) 1))]
         [else tb])))

; String -> String
(check-expect (remove-last-char "test") "tes")
(check-expect (remove-last-char "") "")
;(define (remove-last-char str) "") ; stub
(define (remove-last-char str)
  (if (> (string-length str) 0)
      (substring str 0 (- (string-length str) 1))
      ""))
  
; Textbox -> Textbox
(check-expect (limit-cursor (make-textbox "tests" -1)) (make-textbox "tests" 0))
(check-expect (limit-cursor (make-textbox "tests" 6)) (make-textbox "tests" 5))
(check-expect (limit-cursor (make-textbox "tests" 3)) (make-textbox "tests" 3))
;(define (limit-cursor tb) (make-textbox "testete" 4)) ; stub
(define (limit-cursor tb)
  (cond [(< (textbox-cursor tb) 0)
         (make-textbox (textbox-context tb) 0)]
        [(> (textbox-cursor tb) (string-length (textbox-context tb)))
           (make-textbox (textbox-context tb) (string-length (textbox-context tb))) ]
        [else tb]))