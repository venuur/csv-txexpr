#lang racket/base

(require "parser.rkt" "tokenizer.rkt" "expander.rkt")
(require brag/support)

(define (parse-csv-string csv-string)
  (parse-to-datum (apply-tokenizer make-tokenizer csv-string)))

(define (csv->xexpr csv-string
                    #:has-header? [csv-has-header? #f])
  (let ([parsed-csv (parse-csv-string csv-string)])
    (parameterize ([has-header? csv-has-header?])
      (eval parsed-csv))))
