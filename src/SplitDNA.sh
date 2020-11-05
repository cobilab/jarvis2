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
split --bytes=$SIZE --verbose $INPUT $INPUT- \
| tr -d "\'" | awk '{ print $3;}' > .ENC_F_JV2 2> .tmp_report;
#
mapfile -t FILES < .ENC_F_JV2;
#
C_NAMES="";
IDX_T=1;
IDX_POS=1;
#
for file in "${FILES[@]}" #
  do
  ./JARVIS2 -l 9 $file 2> .tmp_report_$file &
  if [[ "$IDX_T" -eq "$THREADS" ]] || [[ "${#FILES[@]}" -eq "$IDX_POS" ]]
    then
    wait;
    IDX_T=0;
    fi
  C_NAMES+=" $file.jc ";
  ((++IDX_T));
  ((++IDX_POS));
  done
#
tar -cvf $INPUT.tar $C_NAMES 1>> .tmp_report 2>> .tmp_err; 
for file in "${FILES[@]}" #
  do
  rm -f $file.jc $file .tmp_report_$file;
  done
#
rm -f .ENC_F_JV2 .tmp_report .tmp_err;
#
# ==============================================================================
