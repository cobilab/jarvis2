#!/bin/bash
#
LEVEL=5;
#
# ==============================================================================
#
declare -a DATASET=("HoSa" "GaGa" "DaRe" "OrSa" "DrMe" "EnIn" "ScPo" "PlFa" 
                    "EsCo" "HaHi" "AeCa" "HePy" "YeMi" "AgPh" "BuEb");
#
# ==============================================================================
#
for sequence in "${DATASET[@]}"
  do
  echo "Running JARVIS2 in $sequence ...";
  (time ./JARVIS2 -l $LEVEL $sequence ) 2> Report_JARVIS2_$sequence 
  done
#
# ==============================================================================
#
for sequence in "${DATASET[@]}"
  do
  SIZE=`cat Report_JARVIS2_$sequence | grep Compression | awk '{ print $4;}'`;
  TIME=`cat Report_JARVIS2_$sequence | grep real | awk '{ print $2}'`;
  printf "$sequence\t"
  if [[ "$SIZE" -gt "1048576" ]];
    then 
    MBYTES=`echo "scale=5;$SIZE/1024/1024" | bc -l`;
    printf "$MBYTES MB\t";
    else
    KBYTES=`echo "scale=5;$SIZE/1024" | bc -l`;
    printf "$KBYTES KB\t";
    fi
  echo "$TIME";
  done
#
# ==============================================================================
#
  
# level 8  -> 108535491
# level 4  -> 108421836 31m
# level 1  -> 110016976  24m
# level 16 -> 108379732 33m
