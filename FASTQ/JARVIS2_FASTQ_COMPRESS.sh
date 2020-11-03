#!/bin/bash
#
INPUT="$1";
#
# Make sure file name supplied
[ $# -eq 0 ] && { echo "Usage: $0 filename"; exit 1; }
# Make sure file exits else die
[ ! -f $INPUT ] && { echo "$0: file $INPUT not found."; exit 2; }
#
./SplitFastqStreams < $INPUT
./SplitDNA.sh "DNA.JV2" "10MB" "8" &
bzip2 -f N.JV2 &
./bbb cfm10q HEADERS.JV2 HEADERS.JV2.bbb &
./bbb cfm10q QUALITIES.JV2 QUALITIES.JV2.bbb &
wait
tar -cvf $INPUT.tar DNA.JV2.tar N.JV2.bz2 HEADERS.JV2.bbb QUALITIES.JV2.bbb
#
ls -lah HEADERS.JV2.bbb | awk '{ print "HEADS:\t"$5; }'
ls -lah DNA.JV2.tar | awk '{ print "DNA:\t"$5; }'
ls -lah N.JV2.bz2 | awk '{ print "Ns:\t"$5; }'
ls -lah QUALITIES.JV2.bbb | awk '{ print "QUALS:\t"$5; }'
ls -lah $INPUT.tar | awk '{ print "TOTAL:\t"$5; }'
#
rm -f DNA.JV2 N.JV2 HEADERS.JV2 QUALITIES.JV2
#
