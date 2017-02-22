{
open Printf
}

let integer = ['+' '-']?(['1'-'9']['0'-'9']*|"0")
let identifier = ['a'-'z']['a'-'z' 'A'-'Z' '0'-'9']*


rule scanner = parse


| integer as numeral	{ printf " integer(%s) " numeral ; scanner lexbuf}

| "abs" 	{ printf " absolute(abs) " ; scanner lexbuf}


| '+'		{ printf " addition(+) " ; scanner lexbuf}
| '-'		{ printf " subtraction(-) " ; scanner lexbuf}
| '*'		{ printf " multiplication(*) " ; scanner lexbuf}
| "div"		{ printf " division(div) " ; scanner lexbuf}
| '^'		{ printf " exponentiation(^) " ; scanner lexbuf}
| "mod" 	{ printf " modulo(mod) " ; scanner lexbuf}


| '('		{ printf " open_parenthesis " ; scanner lexbuf}
| ')' 		{ printf " close_parenthesis " ; scanner lexbuf}


| 'T'		{ printf " boolean_True " ; scanner lexbuf}
| 'F' 		{ printf " boolean_False " ; scanner lexbuf}


| "not"  	{ printf " boolean_negation(not) " ; scanner lexbuf}


| "\\/" 	{ printf " boolean_or " ; scanner lexbuf}
| "/\\"		{ printf " boolean_and " ; scanner lexbuf}



| '='		{ printf " equal(=) " ; scanner lexbuf}
| '>'		{ printf " greater_than(>) " ; scanner lexbuf}
| '<'		{ printf " less_than(<) " ; scanner lexbuf}
| ">="		{ printf " greater_or_equal(>=) " ; scanner lexbuf}
| "<="		{ printf " less_or_equal(<=) " ; scanner lexbuf} 


| "if"		{ printf " conditional(if) " ; scanner lexbuf}
| "then" 	{ printf " conditional(then) " ; scanner lexbuf}
| "else" 	{ printf " conditional(else) " ; scanner lexbuf}

| "def" 	{ printf " definition_construct(def) " ; scanner lexbuf}
| ";" 		{ printf " delimiter(;) " ; scanner lexbuf}

| identifier as text	{ printf " identifier(%s) " text; scanner lexbuf}


| [' ''\t']+ { scanner lexbuf}
| '\n' 		 { printf "\n" ; scanner lexbuf}


| eof {}

(*let delimiter = ("+"|"-"|"*"|"div"|"^"|"mod"|"("|")"|"\\/"|"/\\"|"="|">"|"<"|">="|"<="|""|";")*)

| [^' ''\t''\n' '+' '-' '*' '^' '(' ')' '=' '>' '<' ';']+ as invalid 	{ printf " Invalid_token(%s) " invalid;scanner lexbuf}

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
