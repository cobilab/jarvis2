#!/bin/bash
#
# ==============================================================================
#
INPUT="$1";
SIZE="$2";
THREADS="$3";
#
# ==============================================================================
#
split --bytes=$SIZE --numeric-suffixes=10 --verbose $INPUT $INPUT- \
| tr -d "\'" | awk '{ print $3;}' > .ENC_F_JV2;
#
mapfile -t FILES < .ENC_F_JV2;
#
C_NAMES="";
IDX=1;
#
for file in "${FILES[@]}" #
  do
  ./JARVIS2 -l 9 $file &
  if [[ "$IDX" -eq "$THREADS" ]] || [[ "${#FILES[@]}" -eq "$IDX" ]]
    then
    wait;
    fi
  C_NAMES+=" $file.jc ";
  ((++IDX));
  done
#
tar -cvf $INPUT.tar $C_NAMES; 
for file in "${FILES[@]}" #
  do
  rm -f $file.jc $file;
  done
#
rm -f .ENC_F_JV2;
#
# ==============================================================================
