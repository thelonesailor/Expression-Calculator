test:
	ocamlyacc b.mly
	ocamlc -c b.mli	
	ocamllex a.mll
	ocamlc -c a.ml
	ocamlc -c b.ml
	ocamlc -c main.ml
	ocamlc -o calc a.cmo b.cmo main.cmo
clean:
	rm a.cmi a.cmo a.ml a.out 
	rm b.cmi b.cmo b.ml b.mli 

