%{
open Printf
open Util
%}

%token <int> NUM
%token <bool> BCONST
%token <string> VARIABLE
%token ADD SUBT MULT DIV MOD
%token OPEN_PAREN CLOSE_PAREN ABS UNMINUS
%token NOT OR AND LET
%token EQ GT LT GE LE
%token SEMICOLON
%token EOF
%start input
%type <unit> input
%%
input:  { }
| line input { }
;

line: SEMICOLON { }
| iexp SEMICOLON { printf "\t"; iprint ($1) ; printf "\n\t %d\n" (eval $1 (getvars $1) (rev(askvars (getvars $1) [] ))) ; flush stdout }
| bexp SEMICOLON { printf "\t"; bprint ($1) ; printf "\n\t %b\n" (eval2 $1 (bgetvars $1) (rev(askvars (bgetvars $1) [] ))) ;flush stdout }
;


iexp: term 			{ $1 }
| iexp ADD term 	{ Add($1,$3) }
| iexp SUBT term 	{ Subt($1,$3) }
;
term:factor			{ $1 }
| term MULT factor 	{ Mult($1,$3) }
| term DIV factor 	{ Div($1,$3) }
| term MOD factor 	{ Modd($1,$3) }
;
factor: NUM 					{ Ival($1) }
| VARIABLE						{ Var($1) }
| UNMINUS factor				{ Unminus($2) }
| ABS factor					{ Abs($2) }
| OPEN_PAREN iexp CLOSE_PAREN 	{ $2 }	
;


bexp: bterm 			{ $1 }
| bexp OR bterm			{ Or($1,$3) }
;
bterm: bfactor			{ $1 }
| bterm AND bfactor     { And($1,$3) }
;
bfactor: BCONST					{ Bval($1) }
| NOT bfactor					{ Not($2) }
| OPEN_PAREN bexp CLOSE_PAREN 	{ $2 }	
| iexp EQ iexp					{ Equal($1,$3) }
| iexp LT iexp					{ Lt($1,$3) }
| iexp GT iexp					{ Gt($1,$3) }
| iexp LE iexp					{ Le($1,$3) }
| iexp GE iexp					{ Ge($1,$3) }
;
%%
