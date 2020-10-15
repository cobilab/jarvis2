#!/bin/bash
#
INPUT="$1";
#
# Make sure file name supplied
[ $# -eq 0 ] && { echo "Usage: $0 filename"; exit 1; }
# Make sure file exits else die
[ ! -f $INPUT ] && { echo "$0: file $INPUT not found."; exit 2; }
#
tar -xvf $INPUT
./JARVIS2 -f -d DNA.JV2.jc &
bunzip2 -f EXTRA.JV2.bz2 &
lzma -f -d HEADERS.JV2.lzma &
wait
mv DNA.JV2.jc.jd DNA.JV2
./MergeFastaStreams > $INPUT.out
rm -f DNA.JV2.jc DNA.JV2.jc.jd EXTRA.JV2.bz2 HEADERS.JV2.lzma
#