	ldl 0
	mv2reg r1

	ldl 0
	mv2reg r2

	ldl 1
	mv2reg r3

	ldl 5
	mv2reg r4




	ldl 0
	ldh 0x20
	mv2reg r5 

	jmri init

plot:
	ldl 80
	mul r2
	add r1
	add r5
	wr r3
	jmri lab

init:
	ldl 1           
	mv2reg r6
	; constante 1

	mv2acc r3
	sub r6
	mv2reg r3

	mv2acc r5
	sub r6
	mv2reg r5


lab:
	clr r66
	mv2acc r4
	!s add r66
	?p EQ jmri end
	; vérifie s'il reste encore des caractères à afficher

	mv2acc r4
	sub r6
	mv2reg r4
	; décrémente le nombre de caractères à afficher
	
	mv2acc r5
	add r6
	mv2reg r5
	; incrémente la localisation sur l'écran


	mv2acc r3
	add r6
	mv2reg r3
	; incrémente l'adresse du caractère à afficher
	
	jmri plot
		
end:



	
