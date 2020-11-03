#!/bin/bash
#
INPUT="$1";
#
# Make sure file name supplied
[ $# -eq 0 ] && { echo "Usage: $0 filename"; exit 1; }
# Make sure file exits else die
[ ! -f $INPUT ] && { echo "$0: file $INPUT not found."; exit 2; }
#
./SplitFastaStreams < $INPUT
./SplitDNA.sh "DNA.JV2" "70MB" "8" &
./bbb cfm10q HEADERS.JV2 HEADERS.JV2.bbb &
bzip2 -f EXTRA.JV2 &
wait
tar -cvf $INPUT.tar DNA.JV2.tar EXTRA.JV2.bz2 HEADERS.JV2.bbb 1> .rep_out_enc
#
ls -lah HEADERS.JV2.bbb | awk '{ print "HEADS:\t"$5; }'
ls -lah DNA.JV2.tar | awk '{ print "DNA:\t"$5; }'
ls -lah EXTRA.JV2.bz2 | awk '{ print "EXTRA:\t"$5; }'
echo "------";
ls -lah $INPUT.tar | awk '{ print "TOTAL:\t"$5; }'
#
rm -f DNA.JV2.tar EXTRA.JV2 HEADERS.JV2 .rep_out_enc
#
