let main () =
try
let lexbuf = Lexing.from_channel stdin in
while true do
B.input A.token lexbuf
done
with End_of_file -> exit 0
let _ = Printexc.print main ()