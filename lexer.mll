{
open Parser	
open Printf
}

let integer = (['1'-'9']['0'-'9']*|"0") 
(*sign of an integer?*)
let variable = ['A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' ''']*


rule scanner = parse


| integer as numeral	{ NUM ( int_of_string numeral ) }

| "abs" 	{ ABS }
| '~'		{ UNMINUS }

| '+'		{ ADD }
| '-'		{ SUBT }
| '*'		{ MULT }
| "div"		{ DIV }
| "mod" 	{ MOD }

| '='		{ EQ }
| '>'		{ GT }
| '<'		{ LT }
| ">="		{ GE }
| "<="		{ LE } 



| '('		{ OPEN_PAREN }
| ')' 		{ CLOSE_PAREN }
| ";" 		{ SEMICOLON }



| 'T'		{ BCONST(true) }
| 'F' 		{ BCONST(false) }

| "not"  	{ NOT }

| "\\/" 	{ OR }
| "/\\"		{ AND }


| "let" 	{ LET }
| variable as text	{ VARIABLE(text) }


| [' ''\t''\n']+ { scanner lexbuf}


(*let delimiter = ("+"|"-"|"*"|"div"|"^"|"mod"|"("|")"|"\\/"|"/\\"|"="|">"|"<"|">="|"<="|""|";")*)

| [^' ''\t''\n' '+' '-' '~' '*' '^' '(' ')' '=' '>' '<' ';' 'F' 'T']+ as invalid 	{ printf " Invalid_token(%s) " invalid;scanner lexbuf}

| eof { EOF }
