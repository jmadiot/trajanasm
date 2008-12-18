	;Deux types de flocon et espace
	ldl 54	
	mv2reg r1
	;ldl 55
	;mv2reg r2
	ldl 37
	mv2reg r3
	
	;constante 3, 4, 60 et 80
	ldl 3
	mv2reg r103
	ldl 4
	mv2reg r104
	ldl 60
	mv2reg r60
	ldl 80
	mv2reg r80
	
	;colonne
	ldl 80
	mv2reg r10
	
	;ligne
	ldl 4
	mv2reg r11
	mv2reg r12
	
	;parité de la ligne
	ldl 0
	mv2reg r42
	
	;adresse
	ldl 0
	ldh 0x20
	mv2reg r99
	
	
	;les choses marrantes commencent
	;Et hop, 1 ligne de flocons!
boucle:
	mv2acc r99
	wrinc r1
	wrinc r3
	wrinc r3
	wrinc r3
	mv2reg r99
	mv2acc r10
	!s sub r104
	mv2reg r10
?p NE jmri boucle
	
	; changement de parité de "ligne"
	!s not r42
	mv2reg r42
	
	ldl 80
	mv2reg r10
	mul r103
	add r99
	
		?p EQ wrdec r3
		?p EQ wrdec r3
		?p NE wrinc r3
		?p NE wrinc r3
	mv2reg r99
	mv2acc r11
	!s sub r104
	mv2reg r11 
	?p NE jmri boucle
	
	
	mv2acc r80
	mul r12
	sub r99
	mv2reg r99
	ldl 0
	sub r99
	mv2reg r99
	
	mv2acc r104
	add r12
	mv2reg r12
	mv2reg r11
	
	jmri boucle
	
	
	
	
nosegfault:
	jmri nosegfault
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
