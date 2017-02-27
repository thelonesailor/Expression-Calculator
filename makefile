test:
	ocamlyacc b.mly
	ocamlc b.mli	
	ocamllex a.mll
	ocamlc a.ml
	ocamlc b.ml
	ocamlc main.ml
clean:
	rm a.cmi a.cmo a.ml a.out 
	rm b.cmi b.cmo b.ml b.mli 

