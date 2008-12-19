all:simu asm

.PHONY = all clean

asm:  asm.cc
	g++ -Wall $< -o $@

SRC = simu.cc
PROG = $(SRC:.cc=)

.PHONY = all clean

$(PROG): %: %.cc
	g++ -O2 -Wall -Wextra -pedantic -ansi $< -L/usr/X11R6/lib -lX11 -o $@

#clean:
#	rm -f *~ \#*\#

clean:
	rm -f *~ \#*\# *.o
	rm -f simu
	rm -f asm
	@#rm -f ex *.cmi *.cmo
	rm -f *.obj



obj:asm
	./asm < neige.asm > neige.obj
	./asm < noel.asm > noel.obj
	./asm < plot.asm > plot.obj
	./asm < plottext.asm > plottext.obj
	./asm < polynome.asm > polynome.obj
	./asm < pong.asm > pong.obj


