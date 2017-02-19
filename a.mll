{
open Printf
}
let digit = ['0'-'9']
let integer = ['+' '-']?(['1'-'9'] ['0'-'9']*|"0")
let id = ['a'-'z'] ['a'-'z' '0'-'9']*
let add = '+'
let sub = '-'
let mul = '*'
let divide = "div"
let modulo = "mod"
let id = ['a'-'z']['a'-'z''A'-'Z''0'-'9']
rule toy_lang = parse

| integer as inum
{ printf "integer: %s (%d)\n" inum (int_of_string inum);
toy_lang lexbuf
}

| "abs" as absolute
{ printf "Unary arithmetic operator: %s\n" absolute;
toy_lang lexbuf
}


| "+"
| "-"
| "*"
| "div"
| "^"	
| "mod" as op
{ printf "binary operator: %s\n" op;
toy_lang lexbuf
}

| '('
| ')' as parenthesis
{ printf "parenthesis: %c\n" parenthesis;
toy_lang lexbuf
}

| 'T'
| 'F' as bool
{ printf "boolean constant: %c\n" bool;
toy_lang lexbuf
}

| "not"  as negation
{
printf "Unary boolean operation: %s\n" negation;
toy_lang lexbuf
}

| "\\/" 
{ printf "or  ";
toy_lang lexbuf
}

| "/\\"
{ printf "and  ";
toy_lang lexbuf
}

| id as text
{ printf "identifier: %s " text;
toy_lang lexbuf
}

| '='
| '>'
| '<'
| ">="
| "<=" as text 
{ printf "Comparison_op: %s " text;
toy_lang lexbuf
}

| "if"
| "then" 
| "else" as text 
{ printf "Conditional_op: %s " text;
toy_lang lexbuf
}


| id as identifier
{ printf "Identifier: %s " identifier;
toy_lang lexbuf
}



| "def" as definition
{ printf "definition construct: %s " definition;
toy_lang lexbuf
}

| ";" as delimiter
{ printf "Delimiter: %c " delimiter ;
toy_lang lexbuf
}


| [' ''\t''\n']+ 
{ 
	toy_lang lexbuf 
} 

| _ as c
{ printf "Unrecognized character: %c\n" c;
toy_lang lexbuf
}
| eof { }
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
