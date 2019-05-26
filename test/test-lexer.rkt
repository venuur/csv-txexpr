#lang br
(require "../lexer.rkt" brag/support rackunit rackunit/text-ui)

(define (lex str) (apply-port-proc csv-lexer str))

;; (srcloc 'string line column position span)
(define (delimiter line column position)
  (srcloc-token (token 'DELIMITER ",") (srcloc 'string line column position 1)))
(define (csv-quote line column position)
  (srcloc-token (token 'QUOTE "\"") (srcloc 'string line column position 1)))
(define (escape line column position)
  (srcloc-token (token 'ESCAPE "\\") (srcloc 'string line column position 1)))
(define (newline line column position)
  (srcloc-token (token 'NEWLINE "\n") (srcloc 'string line column position 1)))
(define (value value line column position)
  (srcloc-token (token 'VALUE value)
                (srcloc 'string line column position (string-length value))))

(define test-lexer
  (test-suite
   "Test ../lexer.rkt"
   (check-equal? (lex "") empty)
   (check-equal? (lex "a , b\n2")
                 (list (value "a " 1 0 1)
                       (delimiter 1 2 3)
                       (value " b" 1 3 4)
                       (newline 1 5 6)
                       (value "2" 2 0 7)))
   (check-equal? (lex "\"a\",\"b\nc\\\"\"")
                 (list (csv-quote 1 0 1)
                       (value "a" 1 1 2)
                       (csv-quote 1 2 3)
                       (delimiter 1 3 4)
                       (csv-quote 1 4 5)
                       (value "b" 1 5 6)
                       (newline 1 6 7)
                       (value "c" 2 0 8)
                       (escape 2 1 9)
                       (csv-quote 2 2 10)
                       (csv-quote 2 3 11)))
   ))

(run-tests test-lexer)
