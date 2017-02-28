%{
open Printf
%}
%token <int> NUM
%token ADD SUBT MULT DIV EXPO MOD
%token OPEN_PAREN CLOSE_PAREN
%token TRUE FALSE NOT OR AND
%token EQUAL GREATER_THAN LESS_THAN GREATER_OR_EQUAL LESS_OR_EQUAL
%token IF THEN ELSE DEF SEMICOLON
%token PLUS MINUS MULTIPLY DIVIDE CARET UMINUS
%token NEWLINE EOF
%start input
%type <unit> input
%%
input:  { }
| input line { }
;

line: NEWLINE { }
| exp NEWLINE { printf "\t%d\n" $1; flush stdout }
;
exp: NUM { $1 }
| exp exp PLUS { $1 + $2 }
| exp exp MINUS { $1 - $2 }
| exp exp MULTIPLY { $1 * $2 }
| exp exp DIVIDE { $1 / $2 }
/* Exponentiation */
/* Unary minus */
;