
TGT_ARCH=cc90

DEFS=

GFTN_DEB_FLAGS=-g -O0 -Wall -Wextra -fcheck=all
NVFTN_REL_FLAGS=-DNDEBUG -O3 -gopt -fast -mp=gpu -Minfo=all -gpu=$(TGT_ARCH),ptxinfo,lineinfo,maxregcount:64,nomanaged,nounified -cuda -lnvToolsExt -lcuda

FLAGS=$(NVFTN_REL_FLAGS)

FC=mpif90
CC=mpicc

fa.out: main.F90
	$(FC) $(DEFS) $(FLAGS) -o $@ $^

ca.out: main.c
	$(CC) $(DEFS) $(FLAGS) -o $@ $^

.PHONY: clean
clean:
	rm -f fa.out ca.out *.mod *.o
