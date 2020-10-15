#============================================================================#
BIN    = .
CC     = gcc
CPLP   =
#-----------------------------------------------------------------------------
CFLAGS = -O3 -Wall $(CPLP)
#-----------------------------------------------------------------------------
PROGS  = $(BIN)/MergeFastqStreams $(BIN)/SplitFastqStreams
#-----------------------------------------------------------------------------
all:
	$(MAKE) progs
progs: $(PROGS)
$(BIN)/MergeFastqStreams: MergeFastqStreams.c 
	$(CC) $(CFLAGS) -o $(BIN)/MergeFastqStreams MergeFastqStreams.c 
$(BIN)/SplitFastqStreams: SplitFastqStreams.c 
	$(CC) $(CFLAGS) -o $(BIN)/SplitFastqStreams SplitFastqStreams.c 
clean:
	/bin/rm -f *.o
cleanall:
	/bin/rm -f *.o $(PROGS)
#-----------------------------------------------------------------------------
