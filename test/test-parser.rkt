#lang racket/base

(require "../parser.rkt" "../tokenizer.rkt")
(require brag/support)
(require rackunit rackunit/text-ui)

(define (parse program)
  (parse-to-datum (apply-tokenizer make-tokenizer program)))

(define test-parser
  (test-suite
   "Parser"
   (check-equal? (parse "") '(table))
   (check-equal?
    (parse "a , b\n2")
    '(table
      (record (field "a ") (field " b"))
      (record (field "2"))))
   (check-equal?
    (parse  "\"a\",\"b\nc\\\"\"")
    '(table
      (record (field "a") (field "b" "\n" "c" "\""))))
   ))

(run-tests test-parser)
