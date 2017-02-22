{
open Printf
}

let integer = ['+' '-']?(['1'-'9']['0'-'9']*|"0")
let identifier = ['a'-'z']['a'-'z' 'A'-'Z' '0'-'9']*

rule toy_lang = parse


| integer as numeral	{ printf " integer(%s) " numeral ; toy_lang lexbuf}


| '+'		{ printf " addition(+) " ; toy_lang lexbuf}
| '-'		{ printf " subtraction(-) " ; toy_lang lexbuf}
| '*'		{ printf " multiplication(*) " ; toy_lang lexbuf}
| "div"		{ printf " division(div) " ; toy_lang lexbuf}
| '^'		{ printf " exponentiation(^) " ; toy_lang lexbuf}
| "mod" 	{ printf " modulo(mod) " ; toy_lang lexbuf}



| '('		{ printf " open_parenthesis " ; toy_lang lexbuf}
| ')' 		{ printf " close_parenthesis " ; toy_lang lexbuf}


| 'T'		{ printf " boolean_true " ; toy_lang lexbuf}
| 'F' 		{ printf " boolean_false " ; toy_lang lexbuf}


| "not"  	{ printf " boolean_negation(not) " ; toy_lang lexbuf}
| "abs" 	{ printf " absolute(abs) " ; toy_lang lexbuf}


| "\\/" 	{ printf " boolean_or " ; toy_lang lexbuf}
| "/\\"		{ printf " boolean_and " ; toy_lang lexbuf}


| identifier as text	{ printf " identifier(%s) " text; toy_lang lexbuf}


| '='		{ printf " equal " ; toy_lang lexbuf}
| '>'		{ printf " greater_than " ; toy_lang lexbuf}
| '<'		{ printf " less_than " ; toy_lang lexbuf}
| ">="		{ printf " greater_or_equal " ; toy_lang lexbuf}
| "<="		{ printf " less_or_equal " ; toy_lang lexbuf} 


| "if"		{ printf " conditional_if " ; toy_lang lexbuf}
| "then" 	{ printf " conditional_then " ; toy_lang lexbuf}
| "else" 	{ printf " conditional_else " ; toy_lang lexbuf}

| "def" 	{ printf " definition_construct(def) " ; toy_lang lexbuf}
| ";" 		{ printf " delimiter(;) " ; toy_lang lexbuf}



| [' ''\t']+ { toy_lang lexbuf}
| '\n' 		 { printf "\n" ; toy_lang lexbuf}


| eof { }

| [^' ''\t''\n'';''+''-''*''('')']+ as invalid 	{ printf " Invalid_token(%s) " invalid;toy_lang lexbuf}

{
let main () =
let cin =
if Array.length Sys.argv > 1
then open_in Sys.argv.(1)
else stdin
in
let lexbuf = Lexing.from_channel cin in
toy_lang lexbuf
let _ = Printexc.print main ()
}
