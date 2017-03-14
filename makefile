test:
	ocamlc -c util.ml
	ocamllex lexer.mll
	ocamlyacc parser.mly
	ocamlc -c parser.mli
	ocamlc -c lexer.ml
	ocamlc -c parser.ml
	ocamlc -c main.ml
	ocamlc -o calc util.cmo lexer.cmo parser.cmo main.cmo 
	rm lexer.cmi lexer.cmo lexer.ml  
	rm parser.cmi parser.cmo parser.ml parser.mli 
	rm main.cmi main.cmo
	rm util.cmi util.cmo
clean:	
	rm calc

