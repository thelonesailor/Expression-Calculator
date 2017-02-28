test:
	ocamllex lexer.mll
	ocamlyacc parser.mly
	ocamlc -c parser.mli
	ocamlc -c lexer.ml
	ocamlc -c parser.ml
	ocamlc -c main.ml
	ocamlc -o calculator lexer.cmo parser.cmo main.cmo
clean:	
	rm lexer.cmi lexer.cmo lexer.ml  
	rm parser.cmi parser.cmo parser.ml parser.mli 
	rm main.cmi main.cmo calculator

