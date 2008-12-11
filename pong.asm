constantes:
	ldl -1
	mv2reg r9
	ldl 0
	mv2reg r10
	ldl 1
	mv2reg r11
	ldl 2
	mv2reg r12
	ldl 10
	mv2reg r13
	ldl 20
	mv2reg r14
	ldl 80
	mv2reg r15

	ldl 0
	ldh 0x20
	mv2reg r5
	
variables:
	;ball & dot
	ldl 15
	mv2reg r101
	ldl 39
	mv2reg r102
	
	;position x,y
	ldl 40
	mv2reg r1
	ldl 10
	mv2reg r2
	
	;lastposition lx, ly
	ldl 40
	mv2reg r71
	ldl 10
	mv2reg r72
	
	;screensize w, h
	ldl 80
	mv2reg r81
	ldl 60
	mv2reg r82
	
	
	;vitesse dx,dy
	ldl -1
	ldh -1
	mv2reg r3
	ldl -1
	ldh -1
	mv2reg r4
	
boucle:
	;affiche la balle
	ldl 80
	mul r2
	add r1
	add r5
	wrinc r101
	
	;affiche la trace
	ldl 80
	mul r72
	add r71
	add r5
	wrinc r102
	
	;x->lx  y->ly
	mv2acc r1
	mv2reg r71
	mv2acc r2
	mv2reg r72
	
	;simulate x
	
	mv2acc r1
	!s add r3
?p LT ldl 1
?p LT mv2reg r3
	mv2acc r1
	add r3
	!s sub r81
?p GE ldl -1
?p GE ldh -1
?p GE mv2reg r3
	mv2acc r1
	add r3
	mv2reg r1

	;simulate y
	
	mv2acc r2
	!s add r4
?p LT ldl 1
?p LT mv2reg r4
	mv2acc r2
	add r4
	!s sub r82
?p GE ldl -1
?p GE ldh -1
?p GE mv2reg r4
	mv2acc r2
	add r4
	mv2reg r2
	
	jmri boucle	
	
	
	

