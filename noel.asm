	
	;TOPLEFT
		ldl 0
		ldh 0x20
		mv2reg r5
	
	;CARACTERES r52 = '*' r53 = ' '
		ldl 54
		mv2reg r52
		ldl 37
		mv2reg r53
	
	;CONSTANTES r80=80; r82=60; r81=1; r79=-1; r83=0
		ldl 80
		mv2reg r80
		ldl 1
		mv2reg r81
		ldl -1
		ldh -1
		mv2reg r79
		ldl 60
		mv2reg r82
		ldl 0
		mv2reg r83

	
	;CADRE DANS LEQUEL IL NE FAUT PAS ECRIRE  x,y=r10,r11 w,h=r12,r13
		ldl 30
		mv2reg r10
		ldl 25
		mv2reg r11
		ldl 20
		mv2reg r12
		ldl 10
		mv2reg r13
	
	;AFFICHAGE DE "JOYEUX NOEL"
		ldl 5
		mv2reg r26
		ldlline
		ldhline
		add r26
		mv2reg r26
		
		jmri skipnoel
			data 10 15 25 5 21 24 37 14 15 5 12 0
		skipnoel:
		
		;r26 : tête de lecture
		;r27 : tête d'écriture
		
		ldl 80
		;mul r11
		;add r10
		;add r5
		;mv2reg r27
		;nop
		;nop
		;nop
		;nop
		;nop   ;quand on décommente ces nop, ça merde comme pas possible. Pourquoi ? Je sais pas.
		;; je "commit". Finirai plus tard.
	
		;boucle:
		;	mv2acc r26
		;	rdinc r99
		;	mv2reg r26
		;	mv2acc r99
		;	!s add r83
		;	?p NE mv2acc r22
		;	?p NE wrinc r99
		;	?p NE mv2reg r22
		;?p NE jmri boucle


	
	
	;ADRESSE DU PREMIER FLOCON
		ldl 0x00
		ldh 0x10
		mv2reg r15
		mv2reg r16
	

	;UTILISER canon.ml POUR GENERER LE CODE DES FLOCONS DE NEIGE CI-DESSOUS
	
	
	


	;NUMBER OF SNOW FLAKES
		ldl 90
		mv2reg r14

	;FLOCON #0
		;POSITION x,y
			ldl 74
			mv2reg r20
			ldl 27
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 10
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #1
		;POSITION x,y
			ldl 5
			mv2reg r20
			ldl 40
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 5
			mv2reg r24
		;PERIODE
			ldl 19
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #2
		;POSITION x,y
			ldl 36
			mv2reg r20
			ldl 20
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 4
			mv2reg r24
		;PERIODE
			ldl 14
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #3
		;POSITION x,y
			ldl 40
			mv2reg r20
			ldl 15
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 10
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #4
		;POSITION x,y
			ldl 34
			mv2reg r20
			ldl 2
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 18
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #5
		;POSITION x,y
			ldl 2
			mv2reg r20
			ldl 20
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 4
			mv2reg r24
		;PERIODE
			ldl 3
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #6
		;POSITION x,y
			ldl 20
			mv2reg r20
			ldl 40
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 21
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #7
		;POSITION x,y
			ldl 28
			mv2reg r20
			ldl 29
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 6
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #8
		;POSITION x,y
			ldl 65
			mv2reg r20
			ldl 42
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 12
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #9
		;POSITION x,y
			ldl 12
			mv2reg r20
			ldl 21
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 5
			mv2reg r24
		;PERIODE
			ldl 21
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #10
		;POSITION x,y
			ldl 72
			mv2reg r20
			ldl 36
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 4
			mv2reg r24
		;PERIODE
			ldl 3
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #11
		;POSITION x,y
			ldl 6
			mv2reg r20
			ldl 25
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 10
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #12
		;POSITION x,y
			ldl 46
			mv2reg r20
			ldl 56
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 0
			mv2reg r24
		;PERIODE
			ldl 13
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #13
		;POSITION x,y
			ldl 15
			mv2reg r20
			ldl 44
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 6
			mv2reg r24
		;PERIODE
			ldl 8
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #14
		;POSITION x,y
			ldl 64
			mv2reg r20
			ldl 0
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 8
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #15
		;POSITION x,y
			ldl 64
			mv2reg r20
			ldl 30
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 19
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #16
		;POSITION x,y
			ldl 17
			mv2reg r20
			ldl 12
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 13
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #17
		;POSITION x,y
			ldl 57
			mv2reg r20
			ldl 42
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 15
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #18
		;POSITION x,y
			ldl 32
			mv2reg r20
			ldl 51
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 1
			mv2reg r24
		;PERIODE
			ldl 12
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #19
		;POSITION x,y
			ldl 76
			mv2reg r20
			ldl 13
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 5
			mv2reg r24
		;PERIODE
			ldl 8
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #20
		;POSITION x,y
			ldl 14
			mv2reg r20
			ldl 25
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 6
			mv2reg r24
		;PERIODE
			ldl 19
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #21
		;POSITION x,y
			ldl 74
			mv2reg r20
			ldl 20
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 5
			mv2reg r24
		;PERIODE
			ldl 17
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #22
		;POSITION x,y
			ldl 59
			mv2reg r20
			ldl 42
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 0
			mv2reg r24
		;PERIODE
			ldl 3
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #23
		;POSITION x,y
			ldl 13
			mv2reg r20
			ldl 13
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 21
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #24
		;POSITION x,y
			ldl 44
			mv2reg r20
			ldl 16
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 4
			mv2reg r24
		;PERIODE
			ldl 19
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #25
		;POSITION x,y
			ldl 74
			mv2reg r20
			ldl 52
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 6
			mv2reg r24
		;PERIODE
			ldl 19
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #26
		;POSITION x,y
			ldl 26
			mv2reg r20
			ldl 24
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 5
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #27
		;POSITION x,y
			ldl 14
			mv2reg r20
			ldl 6
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 6
			mv2reg r24
		;PERIODE
			ldl 4
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #28
		;POSITION x,y
			ldl 12
			mv2reg r20
			ldl 21
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 6
			mv2reg r24
		;PERIODE
			ldl 11
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #29
		;POSITION x,y
			ldl 53
			mv2reg r20
			ldl 40
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 6
			mv2reg r24
		;PERIODE
			ldl 4
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #30
		;POSITION x,y
			ldl 11
			mv2reg r20
			ldl 37
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 18
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #31
		;POSITION x,y
			ldl 31
			mv2reg r20
			ldl 15
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 4
			mv2reg r24
		;PERIODE
			ldl 11
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #32
		;POSITION x,y
			ldl 71
			mv2reg r20
			ldl 42
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 7
			mv2reg r24
		;PERIODE
			ldl 15
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #33
		;POSITION x,y
			ldl 42
			mv2reg r20
			ldl 12
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 15
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #34
		;POSITION x,y
			ldl 51
			mv2reg r20
			ldl 41
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 0
			mv2reg r24
		;PERIODE
			ldl 7
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #35
		;POSITION x,y
			ldl 53
			mv2reg r20
			ldl 9
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 1
			mv2reg r24
		;PERIODE
			ldl 21
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #36
		;POSITION x,y
			ldl 12
			mv2reg r20
			ldl 23
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 18
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #37
		;POSITION x,y
			ldl 62
			mv2reg r20
			ldl 31
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 0
			mv2reg r24
		;PERIODE
			ldl 5
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #38
		;POSITION x,y
			ldl 19
			mv2reg r20
			ldl 33
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 9
			mv2reg r24
		;PERIODE
			ldl 17
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #39
		;POSITION x,y
			ldl 61
			mv2reg r20
			ldl 23
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 0
			mv2reg r24
		;PERIODE
			ldl 9
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #40
		;POSITION x,y
			ldl 22
			mv2reg r20
			ldl 31
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 20
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #41
		;POSITION x,y
			ldl 32
			mv2reg r20
			ldl 6
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 7
			mv2reg r24
		;PERIODE
			ldl 19
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #42
		;POSITION x,y
			ldl 26
			mv2reg r20
			ldl 3
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 5
			mv2reg r24
		;PERIODE
			ldl 13
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #43
		;POSITION x,y
			ldl 63
			mv2reg r20
			ldl 4
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 0
			mv2reg r24
		;PERIODE
			ldl 21
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #44
		;POSITION x,y
			ldl 65
			mv2reg r20
			ldl 31
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 14
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #45
		;POSITION x,y
			ldl 6
			mv2reg r20
			ldl 42
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 13
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #46
		;POSITION x,y
			ldl 60
			mv2reg r20
			ldl 51
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 15
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #47
		;POSITION x,y
			ldl 50
			mv2reg r20
			ldl 15
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 7
			mv2reg r24
		;PERIODE
			ldl 5
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #48
		;POSITION x,y
			ldl 55
			mv2reg r20
			ldl 37
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 1
			mv2reg r24
		;PERIODE
			ldl 20
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #49
		;POSITION x,y
			ldl 6
			mv2reg r20
			ldl 56
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 7
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #50
		;POSITION x,y
			ldl 20
			mv2reg r20
			ldl 4
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 7
			mv2reg r24
		;PERIODE
			ldl 11
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #51
		;POSITION x,y
			ldl 70
			mv2reg r20
			ldl 17
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 12
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #52
		;POSITION x,y
			ldl 43
			mv2reg r20
			ldl 26
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 8
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #53
		;POSITION x,y
			ldl 19
			mv2reg r20
			ldl 53
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 10
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #54
		;POSITION x,y
			ldl 22
			mv2reg r20
			ldl 15
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 0
			mv2reg r24
		;PERIODE
			ldl 18
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #55
		;POSITION x,y
			ldl 39
			mv2reg r20
			ldl 57
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 3
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #56
		;POSITION x,y
			ldl 11
			mv2reg r20
			ldl 18
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 5
			mv2reg r24
		;PERIODE
			ldl 20
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #57
		;POSITION x,y
			ldl 5
			mv2reg r20
			ldl 41
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 9
			mv2reg r24
		;PERIODE
			ldl 8
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #58
		;POSITION x,y
			ldl 76
			mv2reg r20
			ldl 34
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 3
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #59
		;POSITION x,y
			ldl 41
			mv2reg r20
			ldl 32
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 4
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #60
		;POSITION x,y
			ldl 14
			mv2reg r20
			ldl 58
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 4
			mv2reg r24
		;PERIODE
			ldl 17
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #61
		;POSITION x,y
			ldl 12
			mv2reg r20
			ldl 59
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 0
			mv2reg r24
		;PERIODE
			ldl 9
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #62
		;POSITION x,y
			ldl 31
			mv2reg r20
			ldl 28
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 3
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #63
		;POSITION x,y
			ldl 1
			mv2reg r20
			ldl 7
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 4
			mv2reg r24
		;PERIODE
			ldl 7
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #64
		;POSITION x,y
			ldl 1
			mv2reg r20
			ldl 29
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 7
			mv2reg r24
		;PERIODE
			ldl 9
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #65
		;POSITION x,y
			ldl 23
			mv2reg r20
			ldl 56
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 9
			mv2reg r24
		;PERIODE
			ldl 21
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #66
		;POSITION x,y
			ldl 1
			mv2reg r20
			ldl 47
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 1
			mv2reg r24
		;PERIODE
			ldl 3
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #67
		;POSITION x,y
			ldl 2
			mv2reg r20
			ldl 50
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 1
			mv2reg r24
		;PERIODE
			ldl 16
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #68
		;POSITION x,y
			ldl 52
			mv2reg r20
			ldl 8
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 7
			mv2reg r24
		;PERIODE
			ldl 16
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #69
		;POSITION x,y
			ldl 17
			mv2reg r20
			ldl 35
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 17
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #70
		;POSITION x,y
			ldl 62
			mv2reg r20
			ldl 53
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 11
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #71
		;POSITION x,y
			ldl 57
			mv2reg r20
			ldl 21
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 12
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #72
		;POSITION x,y
			ldl 51
			mv2reg r20
			ldl 0
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 7
			mv2reg r24
		;PERIODE
			ldl 6
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #73
		;POSITION x,y
			ldl 12
			mv2reg r20
			ldl 10
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 14
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #74
		;POSITION x,y
			ldl 75
			mv2reg r20
			ldl 59
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 0
			mv2reg r24
		;PERIODE
			ldl 14
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #75
		;POSITION x,y
			ldl 15
			mv2reg r20
			ldl 2
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 11
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #76
		;POSITION x,y
			ldl 58
			mv2reg r20
			ldl 34
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 20
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #77
		;POSITION x,y
			ldl 30
			mv2reg r20
			ldl 4
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 2
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #78
		;POSITION x,y
			ldl 72
			mv2reg r20
			ldl 57
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 0
			mv2reg r24
		;PERIODE
			ldl 3
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #79
		;POSITION x,y
			ldl 36
			mv2reg r20
			ldl 40
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 1
			mv2reg r24
		;PERIODE
			ldl 18
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #80
		;POSITION x,y
			ldl 5
			mv2reg r20
			ldl 6
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 7
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #81
		;POSITION x,y
			ldl 10
			mv2reg r20
			ldl 44
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 0
			mv2reg r24
		;PERIODE
			ldl 4
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #82
		;POSITION x,y
			ldl 66
			mv2reg r20
			ldl 59
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 1
			mv2reg r24
		;PERIODE
			ldl 5
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #83
		;POSITION x,y
			ldl 5
			mv2reg r20
			ldl 26
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 1
			mv2reg r24
		;PERIODE
			ldl 14
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #84
		;POSITION x,y
			ldl 12
			mv2reg r20
			ldl 58
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 6
			mv2reg r24
		;PERIODE
			ldl 20
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #85
		;POSITION x,y
			ldl 12
			mv2reg r20
			ldl 51
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 6
			mv2reg r24
		;PERIODE
			ldl 11
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #86
		;POSITION x,y
			ldl 67
			mv2reg r20
			ldl 7
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 4
			mv2reg r24
		;PERIODE
			ldl 20
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #87
		;POSITION x,y
			ldl 63
			mv2reg r20
			ldl 24
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 9
			mv2reg r24
		;PERIODE
			ldl 10
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #88
		;POSITION x,y
			ldl 28
			mv2reg r20
			ldl 6
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 9
			mv2reg r24
		;PERIODE
			ldl 13
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #89
		;POSITION x,y
			ldl 35
			mv2reg r20
			ldl 22
			mv2reg r21
		;POSITION PRECEDENTE
			ldl 0
			add r5
			mv2reg r22
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 10
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16


	
	;FIN DU CODE GENERE AUTOMATIQUEMENT
	




	
	;BOUCLE D'AFFICHAGE
	aff:
		
		mv2acc r14
		mv2reg r34
		
		mv2acc r15
		mv2reg r16
		
		;BOUCLE DE PARCOURS DES FLOCONS
		flocon:
			
			;CHARGEMENT DES DONNEES DU FLOCON
				mv2acc r16
				rdinc r20
				rdinc r21
				rdinc r22
				rdinc r23
				rdinc r24
				rdinc r25
			
			;TIMER
				mv2acc r24
				!s sub r81
					;SI NUL REINITIALISER
					?p LE mv2acc r25
				mv2reg r24
				;SI NUL INVERSER LA VITESSE r23
					?p LE mv2acc r23
					?p LE mul r79
					?p LE mv2reg r23
			
			;EFFACER LE FLOCON PRECEDENT
				mv2acc r22
				wr r53
			
			;MAJ FLOCON
				mv2acc r20
				add r23
				mv2reg r20
				
				mv2acc r21
				add r81
				mv2reg r21
				!s sub r82
				?p GT clr r21
			
			
			;LE FLOCON EST-IL DANS LE CADRE
				mv2acc r20
				!s sub r10
				?p LT jmri letitbe
				!s sub r12
				?p GT jmri letitbe
				mv2acc r21
				!s sub r11
				?p LT jmri letitbe
				!s sub r13
				?p GT jmri letitbe
				ldl 0
				jmri stopit
				letitbe:
				ldl 1
				stopit:
				!s add r83
			
			
			;AFFICHER LE FLOCON
				?p EQ jmri dontdisp
					ldl 80
					mul r21
					add r20
					add r5
					wr r52
					mv2reg r22
				dontdisp:
				
			
			;SAUVEGARDE DES DONNEES DU FLOCON
				mv2acc r16
				wrinc r20
				wrinc r21
				wrinc r22
				wrinc r23
				wrinc r24
				wrinc r25
				mv2reg r16
			
			;COMPTEUR
				mv2acc r34
				!s sub r81
				mv2reg r34
			
				
		?p GT jmri flocon

	jmri aff
	
