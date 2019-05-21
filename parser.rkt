#lang brag
table : record*
record : field [DELIMITER field]* /NEWLINE
field : (VALUE | ESCAPED-QUOTE)*
      | /QUOTE (VALUE | ESCAPED-QUOTE | NEWLINE | DELIMITER)* /QUOTE
