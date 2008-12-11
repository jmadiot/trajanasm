	ldl 0
	mv2reg r100
	ldl 14
	mv2reg r114
	ldl 5
	mv2reg r105
	ldl 17
	mv2reg r117
	ldl 7
	mv2reg r107
	ldl 12
	mv2reg r112
	ldl 20
	mv2reg r120
	ldl 22
	mv2reg r122
	ldl 15
	mv2reg r115
	ldl 3
	mv2reg r103
	ldl 37
	mv2reg r37
	
	ldl 27
	mv2reg r50
	ldl 28
	mv2reg r51
	ldl 46
	mv2reg r49
	
	ldl 80
	mv2reg r7
	
	ldl 0
	ldh 0x20
	mv2reg r5
	
	
	;test GT GE EQ NE LE LT OV NC
	
	ldl 0
	!s add r100
	mv2acc r5
	wrinc r50
	wrinc r37

?p GT wrinc r107
?p GT wrinc r120
?p GT wrinc r37

?p GE wrinc r107
?p GE wrinc r105
?p GE wrinc r37

?p EQ wrinc r105
?p EQ wrinc r117
?p EQ wrinc r37

?p NE wrinc r114
?p NE wrinc r105
?p NE wrinc r37

?p LE wrinc r112
?p LE wrinc r105
?p LE wrinc r37

?p LT wrinc r112
?p LT wrinc r120
?p LT wrinc r37

?p OV wrinc r115
?p OV wrinc r122
?p OV wrinc r37

?p NC wrinc r114
?p NC wrinc r103
?p NC wrinc r37






	ldl 1
	!s add r100
	mv2acc r5
	add r7
	wrinc r51
	wrinc r37

?p GT wrinc r107
?p GT wrinc r120
?p GT wrinc r37

?p GE wrinc r107
?p GE wrinc r105
?p GE wrinc r37

?p EQ wrinc r105
?p EQ wrinc r117
?p EQ wrinc r37

?p NE wrinc r114
?p NE wrinc r105
?p NE wrinc r37

?p LE wrinc r112
?p LE wrinc r105
?p LE wrinc r37

?p LT wrinc r112
?p LT wrinc r120
?p LT wrinc r37

?p OV wrinc r115
?p OV wrinc r122
?p OV wrinc r37

?p NC wrinc r114
?p NC wrinc r103
?p NC wrinc r37



	



	ldl -1
	ldh -1
	!s add r100
	mv2acc r5
	add r7
	add r7
	wrinc r49
	wrinc r51
	wrinc r37

?p GT wrinc r107
?p GT wrinc r120
?p GT wrinc r37

?p GE wrinc r107
?p GE wrinc r105
?p GE wrinc r37

?p EQ wrinc r105
?p EQ wrinc r117
?p EQ wrinc r37

?p NE wrinc r114
?p NE wrinc r105
?p NE wrinc r37

?p LE wrinc r112
?p LE wrinc r105
?p LE wrinc r37

?p LT wrinc r112
?p LT wrinc r120
?p LT wrinc r37

?p OV wrinc r115
?p OV wrinc r122
?p OV wrinc r37

?p NC wrinc r114
?p NC wrinc r103
?p NC wrinc r37



	
	
	
	
	
	
	
	
