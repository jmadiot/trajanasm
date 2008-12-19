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
	rm -f jmsimu


jm:jmsimu jmasm


jmsimu:
	g++ jmsimu.cc -lX11 -L/usr/X11R6/lib -lX11 -o jmsimu

jmasm:
	




