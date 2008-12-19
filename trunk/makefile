all:simu asm ex

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
	rm -f ex *.cmi *.cmo

ex:
	ocamlc ex.ml -o ex




