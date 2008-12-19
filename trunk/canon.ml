(*Canon à neige pour neige.asm*)
(*Génère du code pour chaque flocon à insérer dans neige.asm*)
(*Indispensable pour avoir des bons flocons biens chaotiques*)

(*Nombre de flocons*)
let n=50;;

(*Dimensions de l'écran*)
let w=80;;
let h=60;;

(*Afficher des commentaires et indenter ?*)
let v=true;;

(*Indenter avec tab*)
let tab="\t";;

if v then Printf.printf "%s;NUMBER OF SNOW FLAKES\n" tab;
Printf.printf "%s%sldl %d\n" tab tab n;
Printf.printf "%s%smv2reg r14\n" tab tab;
	print_newline();

for i=0 to n-1 do
	if v then Printf.printf "%s;FLOCON #%d\n" tab i;

	if v then Printf.printf "%s%s;POSITION x,y\n" tab tab;
	Printf.printf "%s%s%sldl %d\n" tab tab tab (Random.int w);
	Printf.printf "%s%s%smv2reg r20\n" tab tab tab;
	Printf.printf "%s%s%sldl %d\n" tab tab tab (Random.int h);
	Printf.printf "%s%s%smv2reg r21\n" tab tab tab;
	
	(*if v then Printf.printf "%s%s;POSITION PRECEDENTE\n" tab tab;
	Printf.printf "%s%s%sldl 0\n" tab tab tab;
	Printf.printf "%s%s%sadd r5\n" tab tab tab;
	Printf.printf "%s%s%smv2reg r22\n" tab tab tab;*)
	
	if v then Printf.printf "%s%s;VITESSE\n" tab tab;
	if Random.bool () then
		Printf.printf "%s%s%sldl 1\n" tab tab tab
	else begin
		Printf.printf "%s%s%sldl -1\n" tab tab tab;
		Printf.printf "%s%s%sldh -1\n" tab tab tab
	end;
	Printf.printf "%s%s%smv2reg r23\n" tab tab tab;

	if v then Printf.printf "%s%s;TIMER\n" tab tab;
	Printf.printf "%s%s%sldl %d\n" tab tab tab (Random.int 10);
	Printf.printf "%s%s%smv2reg r24\n" tab tab tab;
	
	if v then Printf.printf "%s%s;PERIODE\n" tab tab;
	Printf.printf "%s%s%sldl %d\n" tab tab tab (2+(Random.int 20));
	Printf.printf "%s%s%smv2reg r25\n" tab tab tab;
	
	if v then Printf.printf "%s%s;STOCKAGE\n" tab tab;
	Printf.printf "%s%s%smv2acc r16\n" tab tab tab;
	Printf.printf "%s%s%swrinc r20\n" tab tab tab;
	Printf.printf "%s%s%swrinc r21\n" tab tab tab;
	Printf.printf "%s%s%swrinc r22\n" tab tab tab;
	Printf.printf "%s%s%swrinc r23\n" tab tab tab;
	Printf.printf "%s%s%swrinc r24\n" tab tab tab;
	Printf.printf "%s%s%swrinc r25\n" tab tab tab;
	Printf.printf "%s%s%smv2reg r16\n" tab tab tab;
	if v then print_newline();

done;;
