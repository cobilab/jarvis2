#!/bin/bash
#
# ==============================================================================
#
INPUT="$1";    # "Filename"
THREADS="$2";  # "8"
#
# ==============================================================================
#
tar -xvf $INPUT 1> .DEC_F_JV2;
#
mapfile -t FILES < .DEC_F_JV2;
#
IDX=1;
D_NAMES="";
#
for file in "${FILES[@]}" #
  do
  ./JARVIS2 -d $file 2> .tmp_report_$file &
  if [[ "$IDX" -eq "$THREADS" ]] || [[ "${#FILES[@]}" -eq "$IDX" ]]
    then
    wait;
    fi
  ((++IDX));  
  done
#
rm -f $INPUT.out;
for file in "${FILES[@]}" #
  do
  cat $file.jd >> $INPUT.out;
  rm -f $file.jd $file .tmp_report_$file
  done
#
rm -f .DEC_F_JV2 
#
# ==============================================================================
