;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#lang br
(require brag/support)
(provide csv-lexer)

(define-lex-abbrev newline (:or "\r\n" (char-set "\r\n")))

(define csv-lexer
  (lexer-srcloc
   [(:= 1 ",") (token 'DELIMITER lexeme)]
   [(:= 1 "\"") (token 'QUOTE lexeme)]
   [(:= 1 newline) (token 'NEWLINE lexeme)]
   [(:seq (:+ (:~ "," "\"" "\n")))
    (token 'VALUE lexeme)]))

(define (lex str) (apply-port-proc csv-lexer str))
