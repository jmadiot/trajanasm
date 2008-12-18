	;Deux types de flocon et espace
	ldl 54	
	mv2reg r1
	;ldl 55
	;mv2reg r2
	ldl 37
	mv2reg r3
	
	;constante test
	ldl 79
	mv2reg r70
	
	;constante 2
	ldl 2
	mv2reg r102
	
	;colonne
	ldl 6
	mv2reg r10
	
	;ligne
	ldl 60
	mv2reg r11
	
	;parité de la ligne
	ldl 0
	mv2reg r42
	
	;adresse
	ldl 0
	ldh 0x20
	mv2reg r99
		
	boucle:
		mv2acc r99
		wrinc r1
		wrinc r3
		mv2reg r99
		mv2acc r10
		!s sub r102
		mv2reg r10
	?p NE jmri boucle


	!s not r42
	mv2reg r42
	ldl 80
	mv2reg r10
	mv2acc r99
	add r79
		?p EQ wrinc r3
	mv2reg r99
	mv2acc r11
	!s sub r102
	mv2reg r11 
	?p NE jmri boucle
	
	
nosegfault:
	jmri nosegfault
