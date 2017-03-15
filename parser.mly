%{
open Printf
open Util
%}

%token <int> NUM
%token <bool> BCONST
%token <string> VARIABLE
%token OPEN_PAREN CLOSE_PAREN 
%token ADD SUBT MULT DIV MOD ABS UNMINUS OR AND NOT EQ GT LT GE LE
%left OR
%left AND
%left EQ 
%left GT LT GE LE
%left ADD SUBT 
%left MULT DIV MOD
%right ABS UNMINUS
%right NOT
%token SEMICOLON EOF
%start input
%type <unit> input
%%
input:  { exit(0); }
| line input { }
;

line: SEMICOLON { }
| iexp SEMICOLON { printf "\nParse tree:- "; iprint ($1) ; printf "\n\n"; printf "\n\t intexp= %d\n\n" (eval $1 (getvars $1) (rev(askvars (getvars $1) [] ))) ; flush stdout }
| bexp SEMICOLON { printf "\nParse tree:- "; bprint ($1) ; printf "\n\n"; printf "\n\t boolexp= %b\n\n" (eval2 $1 (bgetvars $1) (rev(askvars (bgetvars $1) [] ))) ; flush stdout }
;


iexp: 
  iexp ADD iexp 	{ Add($1,$3) }
| iexp SUBT iexp 	{ Subt($1,$3) }
| iexp MULT iexp 	{ Mult($1,$3) }
| iexp DIV iexp 	{ Div($1,$3) }
| iexp MOD iexp 	{ Modd($1,$3) }

| ABS iexp			{ Abs($2) }
| UNMINUS iexp		{ Unminus($2) }

| NUM 				{ Ival($1) }
| VARIABLE	 		{ Var($1) }
| OPEN_PAREN iexp CLOSE_PAREN 	{ $2 }	
;


bexp: 
  bexp OR bexp					{ Or($1,$3) }
| bexp AND bexp   	  			{ And($1,$3) }
| BCONST						{ Bval($1) }
| NOT bexp						{ Not($2) }
| iexp EQ iexp					{ Equal($1,$3) }
| iexp LT iexp					{ Lt($1,$3) }
| iexp GT iexp					{ Gt($1,$3) }
| iexp LE iexp					{ Le($1,$3) }
| iexp GE iexp					{ Ge($1,$3) }
| OPEN_PAREN bexp CLOSE_PAREN 	{ $2 }	
;
%%
(*
http://ee.hawaii.edu/~tep/EE160/Book/chap5/subsection2.1.4.1.html
*)