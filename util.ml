 type intexp = Add of intexp * intexp 
			| Subt of intexp * intexp
			| Mult of intexp * intexp
			| Div of intexp * intexp
			| Modd of intexp * intexp 
			| Abs of intexp
			| Unminus of intexp 
			| Ival of int
			| Var of string
			;;

 type boolexp = And of boolexp * boolexp
 			 | Or of boolexp * boolexp 
			 | Not of boolexp
			 | Bval of bool
			 | Equal of intexp * intexp
			 | Gt of intexp * intexp
			 | Lt of intexp * intexp	
			 | Ge of intexp * intexp
			 | Le of intexp * intexp
			 ;;

let rec find e = function
    | [] -> false
    | h::t -> h = e || find e t
;;

let rev list =
    let rec aux acc = function
      | [] -> acc
      | h::t -> aux (h::acc) t in
    aux [] list
;;

let rec union l1 l2 = match l1 with
    | [] -> l2
    | h::t -> if find h l2 then union t l2
              else union t (h::l2)
;;

let rec getvars tree = match tree with
	Add(l,r) -> union (getvars l) (getvars r);
	|Subt(l,r) -> union (getvars l) (getvars r);
	|Mult(l,r) -> union (getvars l) (getvars r);
	|Div(l,r) -> union (getvars l) (getvars r);
	|Modd(l,r) -> union (getvars l) (getvars r);
	|Abs(x) ->  getvars x;
	|Unminus(x) -> getvars x;			
	|Ival(x) -> [];
	|Var(s) -> [s];
;;

let rec bgetvars tree = match tree with
	Or(l,r) -> union (bgetvars l) (bgetvars r);
	|And(l,r) -> union (bgetvars l) (bgetvars r);
	|Not(x) -> bgetvars x;
	|Bval(x) -> [];
	|Equal(l,r) -> union (getvars l) (getvars r);
	|Gt(l,r) -> union (getvars l) (getvars r);
	|Lt(l,r) -> union (getvars l) (getvars r);
	|Ge(l,r) -> union (getvars l) (getvars r);
	|Le(l,r) -> union (getvars l) (getvars r);
;;

let rec askvars l acc= match l with
	[] -> Printf.printf "";acc;
	|x::y -> Printf.printf "\nEnter %s= " x; let vx=read_int () in askvars y (vx::acc) ;
;;

let rec ieval t rho l1 l2 = match t with 
	Add(l,r) -> ieval l rho l1 l2  +  ieval r rho l1 l2;
	|Subt(l,r) -> ieval l rho l1 l2  -  ieval r rho l1 l2;
	|Mult(l,r) -> ieval l rho l1 l2  *  ieval r rho l1 l2;
	|Div(l,r) -> ieval l rho l1 l2  /  ieval r rho l1 l2;
	|Modd(l,r) -> (ieval l rho l1 l2) mod (ieval r rho l1 l2);
	|Abs(x) ->  let t=(ieval x rho l1 l2) in if(t<0)then -1*t else t;
	|Unminus(x) -> -1*(ieval x rho l1 l2);			
	|Ival(x) -> x;
	|Var(s) -> rho s l1 l2 ;
;;

let eval t l1 l2 = 
	let rec rho s a b = match (a , b) with 
	([] , _) -> 0;
	|(_ , []) -> 0;
	|(xa::ya , xb::yb) -> if (xa=s) then xb else rho s ya yb;
 
	in
	ieval t rho l1 l2
;;

let rec beval t rho l1 l2 = match t with 
	Or(l,r) -> beval l rho l1 l2  || beval r rho l1 l2 
	|And(l,r) -> beval l rho l1 l2  && beval r rho l1 l2 
	|Not(x) -> not (beval x rho l1 l2 )
	|Bval(x) -> x
	|Equal(l,r) -> ieval l rho l1 l2  = ieval r rho l1 l2 
	|Gt(l,r) -> ieval l rho l1 l2  > ieval r rho l1 l2 
	|Lt(l,r) -> ieval l rho l1 l2  < ieval r rho l1 l2 
	|Ge(l,r) -> ieval l rho l1 l2  >= ieval r rho l1 l2 
	|Le(l,r) -> ieval l rho l1 l2  <= ieval r rho l1 l2 
;;

let eval2 t l1 l2 = 
	let rec rho2 s a b = match (a , b) with 
	([] , _) -> 0;
	|(_ , []) -> 0;
	|(xa::ya , xb::yb) -> if (xa=s) then xb else rho2 s ya yb;
 
	in
	beval t rho2 l1 l2
;;

let rec iprint a = match a with 
	Add(l,r) -> Printf.printf " Add(" ; iprint l ;Printf.printf ","; iprint r ;Printf.printf ") ";
	|Subt(l,r) -> Printf.printf " Sub("; iprint l ;Printf.printf ","; iprint r ;Printf.printf ") ";
	|Mult(l,r) -> Printf.printf " Mult("; iprint l ;Printf.printf ","; iprint r ;Printf.printf ") ";
	|Div(l,r) -> Printf.printf " Div("; iprint l ;Printf.printf ","; iprint r ;Printf.printf ") ";
	|Modd(l,r) -> Printf.printf " Mod("; iprint l ;Printf.printf ","; iprint r ;Printf.printf ") ";
	|Abs(x) -> Printf.printf " Abs("; iprint x ;Printf.printf ") ";
	|Unminus(x) -> Printf.printf " ~("; iprint x ;Printf.printf ") ";			
	|Ival(x) -> Printf.printf " Int("; Printf.printf "%d) " x;
	|Var(s) -> Printf.printf " Var("; Printf.printf "%s) " s;
;;

let rec bprint b = match b with 
	Or(l,r) -> Printf.printf " Or("; bprint l ;Printf.printf ","; bprint r ;Printf.printf ") ";
	|And(l,r) -> Printf.printf " And("; bprint l ;Printf.printf ","; bprint r ;Printf.printf ") ";
	|Not(x) -> Printf.printf " Not("; bprint x ;Printf.printf ") ";
	|Bval(x) -> Printf.printf " Bool("; Printf.printf "%b) " x;
	|Equal(l,r) -> Printf.printf " =("; iprint l ;Printf.printf ","; iprint r ;Printf.printf ") ";
	|Gt(l,r) -> Printf.printf " >("; iprint l ;Printf.printf ","; iprint r ;Printf.printf ") ";
	|Lt(l,r) -> Printf.printf " <("; iprint l ;Printf.printf ","; iprint r ;Printf.printf ") ";
	|Ge(l,r) -> Printf.printf " >=("; iprint l ;Printf.printf ","; iprint r ;Printf.printf ") ";
	|Le(l,r) -> Printf.printf " <=("; iprint l ;Printf.printf ","; iprint r ;Printf.printf ") ";
;;
