#!/bin/bash
#
INPUT="$1";
#
# Make sure file name supplied
[ $# -eq 0 ] && { echo "Usage: $0 filename"; exit 1; }
# Make sure file exits else die
[ ! -f $INPUT ] && { echo "$0: file $INPUT not found."; exit 2; }
#
tar -xvf $INPUT 1> .rep_out_dec
./MergeDNA.sh "DNA.JV2.tar" "70MB" "8" &
bunzip2 -f EXTRA.JV2.bz2 &
./bbb -fqd HEADERS.JV2.bbb HEADERS.JV2 &
wait
mv DNA.JV2.tar.out DNA.JV2
./MergeFastaStreams > $INPUT.out
rm -f DNA.JV2.jc DNA.JV2.tar.out EXTRA.JV2.bz2 HEADERS.JV2.bbb .rep_out_dec
#
