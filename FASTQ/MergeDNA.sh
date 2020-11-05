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
D_NAMES="";
IDX_T=1;
IDX_POS=1;
#
for file in "${FILES[@]}" #
  do
  ./JARVIS2 -d $file 2> .tmp_report_$file &
  if [[ "$IDX_T" -eq "$THREADS" ]] || [[ "${#FILES[@]}" -eq "$IDX_POS" ]]
    then
    wait;
    IDX_T=0;
    fi
  ((++IDX_T));  
  ((++IDX_POS));  
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
