	;affiche l'entier n contenu dans la mémoire à l'adresse r99 à la position r1,r2 sur l'ecran
	
	ldl 5
	mv2reg r1
	ldl 5
	mv2reg r2
	ldl -1
	ldh -1
	mv2reg r99
	
	;r98 : adresse du pixel ou il faut écrire
	ldl 0
	ldh 0x20
	mv2reg r98
	ldl 80
	mul r2
	add r1
	add r98
	mv2reg r98
	
	;r50 : chiffre à afficher
	ldl 26
	mv2reg r50
		
	;constantes 0, 1, 10, 100, 1000, 10 000
	ldl 0
	mv2reg r100
	ldl 1
	mv2reg r101
	ldl 10
	mv2reg r102
	ldl 100
	mv2reg r103
	ldl -24
	ldh 3
	mv2reg r104
	ldl 16
	ldh 39
	mv2reg r105
		
	; chercher le premier chiffre non nul en base 10
 

	;n<10 000?
	mv2acc r99
	!s sub r105
?p GE jmri affiche5 

	;n<1000?
	mv2acc r99
	!s sub r104
?p GE jmri affiche4


	;n<100?
	mv2acc r99
	!s sub r103
?p GE jmri affiche3


	;n<10?	
	mv2acc r99
	!s sub r102
?p GE jmri affiche2


	jmri affiche1
	
	

	
affiche5:
	;r50++
	mv2acc r50
	add r101
	mv2reg r50
	
	;r99 <- r99 - 10 000
	mv2acc r99
	!s sub r105
	mv2reg r99
	
?p GE jmri affiche5
	
	mv2acc r99
	add r105
	mv2reg r99
	
	;afficher le chiffre r50 et incrémenter l'emplacement sur l'écran
	mv2acc r98
	wrinc r50
	mv2reg r98
			
	ldl 26
	mv2reg r50
	
affiche4:
	;r50++
	mv2acc r50
	add r101
	mv2reg r50
	
	;r99 <- r99 - 1 000
	mv2acc r99
	!s sub r104
	mv2reg r99
	
?p GE jmri affiche4
	
	mv2acc r99
	add r104
	mv2reg r99
	
	;afficher le chiffre r50 et incrémenter l'emplacement sur l'écran
	mv2acc r98
	wrinc r50
	mv2reg r98
			
	ldl 26
	mv2reg r50

affiche3:
	;r50++
	mv2acc r50
	add r101
	mv2reg r50
	
	;r99 <- r99 - 100
	mv2acc r99
	!s sub r103
	mv2reg r99
	
?p GE jmri affiche3
	
	mv2acc r99
	add r103
	mv2reg r99
	
	;afficher le chiffre r50 et incrémenter l'emplacement sur l'écran
	mv2acc r98
	wrinc r50
	mv2reg r98
			
	ldl 26
	mv2reg r50

affiche2:
	;r50++
	mv2acc r50
	add r101
	mv2reg r50
	
	;r99 <- r99 - 10
	mv2acc r99
	!s sub r102
	mv2reg r99
	
?p GE jmri affiche2
	
	mv2acc r99
	add r102
	mv2reg r99
	
	;afficher le chiffre r50 et incrémenter l'emplacement sur l'écran
	mv2acc r98
	wrinc r50
	mv2reg r98

	ldl 26
	mv2reg r50

affiche1:
	;r50++
	mv2acc r50
	add r101
	mv2reg r50
	
	;r99 <- r99 - 1
	mv2acc r99
	!s sub r101
	mv2reg r99
	
?p GE jmri affiche1
	
	mv2acc r99
	add r101
	mv2reg r99
	
	;afficher le chiffre r50 et incrémenter l'emplacement sur l'écran
	mv2acc r98
	wr r50
	
	
	
reste_affiché:
	jmri reste_affiché
		



















	

	
