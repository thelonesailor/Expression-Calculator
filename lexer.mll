{
open Parser	
open Printf
}

let integer = ['-']?(['1'-'9']['0'-'9']*|"0")
let identifier = ['a'-'z']['a'-'z' 'A'-'Z' '0'-'9']*


rule scanner = parse


| integer as numeral	{ printf " integer(%s) " numeral ; scanner lexbuf}

| "abs" 	{ ABS }


| '+'		{ ADD }
| '-'		{ SUBT }
| '*'		{ MULT }
| "div"		{ DIV }
| '^'		{ EXPO }
| "mod" 	{ MOD }


| '('		{ OPEN_PAREN }
| ')' 		{ CLOSE_PAREN }


| 'T'		{ TRUE }
| 'F' 		{ FALSE }


| "not"  	{ NOT }


| "\\/" 	{ OR }
| "/\\"		{ AND }



| '='		{ EQUAL }
| '>'		{ GREATER_THAN }
| '<'		{ LESS_THAN }
| ">="		{ GREATER_OR_EQUAL }
| "<="		{ LESS_OR_EQUAL } 


| "if"		{ IF }
| "then" 	{ THEN }
| "else" 	{ ELSE }

| "def" 	{ DEF }
| ";" 		{ SEMICOLON }

| identifier as text	{ printf " identifier(%s) " text; scanner lexbuf}


| [' ''\t''\n']+ { scanner lexbuf}


(*let delimiter = ("+"|"-"|"*"|"div"|"^"|"mod"|"("|")"|"\\/"|"/\\"|"="|">"|"<"|">="|"<="|""|";")*)

| [^' ''\t''\n' '+' '-' '*' '^' '(' ')' '=' '>' '<' ';' 'F' 'T']+ as invalid 	{ printf " Invalid_token(%s) " invalid;scanner lexbuf}

| eof { EOF }

(*
In a different file now 
{
let main () =
let cin =
if Array.length Sys.argv > 1
then open_in Sys.argv.(1)
else stdin
in
let lexbuf = Lexing.from_channel cin in
scanner lexbuf
let _ = Printexc.print main ()
}
*)