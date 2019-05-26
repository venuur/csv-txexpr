#lang brag
table : [record (/NEWLINE record)*]
record : field [/DELIMITER field]*
field : (VALUE | escaped-quote)*
      | /QUOTE (VALUE | escaped-quote | NEWLINE | DELIMITER)* /QUOTE
@escaped-quote : /ESCAPE QUOTE