%{
open Printf
%}
%token <int> NUM
%token <bool> BCONST
%token <string> IDENTIFIER
%token ADD SUBT MULT DIV EXPO MOD
%token OPEN_PAREN CLOSE_PAREN ABS
%token NOT OR AND
%token EQUAL GREATER_THAN LESS_THAN GREATER_OR_EQUAL LESS_OR_EQUAL
%token IF THEN ELSE DEF SEMICOLON
%token EOF
%start input
%type <unit> input
%%
input:  { }
| line input { }
;
line: SEMICOLON { }
| iexp SEMICOLON { printf " %d\n" $1; flush stdout }
| bexp SEMICOLON { printf " %b\n" $1; flush stdout }
;


iexp: term 			{ $1 }
| iexp ADD term 	{ $1 + $3 }
| iexp SUBT term 	{ $1 - $3 }
;
term:factor			{ $1 }
| term MULT factor 	{ $1 * $3 }
| term DIV factor 	{ $1 / $3 }
| term MOD factor 	{ $1 mod $3 }
;
factor: NUM 					{ $1 }
| SUBT factor 					{ -1 * $2 }
| ABS factor					{ abs($2) }
| OPEN_PAREN iexp CLOSE_PAREN 	{ $2 }	
;


bexp: bterm 			{ $1 }
| bexp OR bterm			{ $1 || $3 }
;
bterm: bfactor			{ $1 }
| bterm AND bfactor     { $1 && $3 }
;
bfactor: BCONST					{ $1 }
| NOT bfactor					{ not ($2) }
| OPEN_PAREN bexp CLOSE_PAREN 	{ $2 }	
;
%%
(*For now ignoring boolean expressions*)




