;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#lang br
(require brag/support)
(provide csv-lexer)

(define-lex-abbrev newline (:or "\r\n" (char-set "\r\n")))

(define csv-lexer
  (lexer-srcloc
   ["," (token 'DELIMITER lexeme)]
   ["\\" (token 'ESCAPE lexeme)]
   ["\"" (token 'QUOTE lexeme)]
   [newline (token 'NEWLINE lexeme)]
   [(:seq (:+ (:~ "," "\"" "\n" "\\")))
    (token 'VALUE lexeme)]))

(define (lex str) (apply-port-proc csv-lexer str))
