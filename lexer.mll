{
open Parser	
open Printf
}

let integer = (['1'-'9']['0'-'9']*|"0") 
(*sign of an integer?*)
let variable = ['A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' ''']*


rule scanner = parse


| integer as numeral	{ NUM ( int_of_string numeral ) }


| '+'		{ ADD }
| '-'		{ SUBT }
| '*'		{ MULT }
| "div"		{ DIV }
| "mod" 	{ MOD }

| "abs" 	{ ABS }
| '~'		{ UNMINUS }

| '='		{ EQ }
| '>'		{ GT }
| '<'		{ LT }
| ">="		{ GE }
| "<="		{ LE } 



| '('		{ OPEN_PAREN }
| ')' 		{ CLOSE_PAREN }
| ";" 		{ SEMICOLON }



| 't'		{ BCONST(true) }
| 'f' 		{ BCONST(false) }

| "not"  	{ NOT }

| "\\/" 	{ OR }
| "/\\"		{ AND }


| variable as text	{ VARIABLE(text) }


| [' ''\t''\n']+ { scanner lexbuf}


(*let delimiter = ("+"|"-"|"*"|"div"|"^"|"mod"|"("|")"|"\\/"|"/\\"|"="|">"|"<"|">="|"<="|""|";")*)

| [^' ''\t''\n' '+' '-' '~' '*' '(' ')' '=' '>' '<' ';' 'f' 't']+ as invalid 	{ printf " Invalid_token(%s) " invalid;scanner lexbuf}

| eof { EOF }
