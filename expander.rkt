#lang racket/base

(provide
 ; Table syntax
 table record field

 ; Parameters controlling interpretation of syntax.
 has-header?
 )

(define has-header? (make-parameter #f))
(define is-header-record? (make-parameter #f))

(define-syntax table
  (syntax-rules ()
    [(table first-record rest-records ...)
     (if (has-header?)
         (list 'table
               (list 'thead (parameterize ([is-header-record? #t]) first-record))
               (list 'tbody rest-records ...))
         (list 'table (list 'tbody first-record rest-records ...)))]))

(define-syntax record
  (syntax-rules ()
    [(record fields ...) (list 'tr fields ...)]))

(define-syntax field
  (syntax-rules ()
    [(field contents ...)
     (list (if (is-header-record?) 'th 'td) (string-append contents ...))]))
