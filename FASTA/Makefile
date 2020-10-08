#============================================================================#
BIN    = .
CC     = gcc
CPLP   =
#-----------------------------------------------------------------------------
CFLAGS = -O3 -Wall $(CPLP)
#-----------------------------------------------------------------------------
PROGS  = $(BIN)/MergeFastaStreams $(BIN)/SplitFastaStreams
#-----------------------------------------------------------------------------
all:
	$(MAKE) progs
progs: $(PROGS)
$(BIN)/MergeFastaStreams: MergeFastaStreams.c 
	$(CC) $(CFLAGS) -o $(BIN)/MergeFastaStreams MergeFastaStreams.c 
$(BIN)/SplitFastaStreams: SplitFastaStreams.c 
	$(CC) $(CFLAGS) -o $(BIN)/SplitFastaStreams SplitFastaStreams.c 
clean:
	/bin/rm -f *.o
cleanall:
	/bin/rm -f *.o $(PROGS)
#-----------------------------------------------------------------------------
