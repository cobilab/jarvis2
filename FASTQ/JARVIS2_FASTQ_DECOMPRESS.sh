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
./bbb dqf HEADERS.JV2.bbb HEADERS.JV2 &
./JARVIS2 -f -d DNA.JV2.jc &
bunzip2 -f N.JV2.bz2 &
./bbb dqf QUALITIES.JV2.bbb QUALITIES.JV2 &
wait
mv DNA.JV2.jc.jd DNA.JV2
./MergeFastqStreams > $INPUT.out
rm -f DNA.JV2.jc DNA.JV2.jc.jd N.JV2.bz2 HEADERS.JV2.bbb QUALITIES.JV2.bbb
#
