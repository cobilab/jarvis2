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
./JARVIS2 -f -v DNA.JV2 &
bzip2 -f N.JV2 &
lzma -f HEADERS.JV2 &
lzma -f QUALITIES.JV2 &
wait
tar -cvf $INPUT.tar DNA.JV2.jc N.JV2.bz2 HEADERS.JV2.lzma QUALITIES.JV2.lzma
#
ls -la HEADERS.JV2.lzma | awk '{ print "HEADS:\t"$5; }'
ls -la DNA.JV2.jc | awk '{ print "DNA:\t"$5; }'
ls -la N.JV2.bz2 | awk '{ print "Ns:\t"$5; }'
ls -la QUALITIES.JV2.lzma | awk '{ print "QUALS:\t"$5; }'
ls -la $INPUT.tar | awk '{ print "TOTAL:\t"$5; }'
#
rm -f DNA.JV2 N.JV2 HEADERS.JV2 QUALITIES.JV2
#
