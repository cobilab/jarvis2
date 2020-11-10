#!/bin/bash
#
INSTALL=0;
DOWNLOAD=0;
BENCHMARK=0;
#
# ==============================================================================
# INSTALL TOOLS:
#
if [[ "$INSTALL" -eq "0" ]];
  then
  conda install sra-tools --yes # FASTQ-DUMP
  #
  conda install -c bioconda spring --yes #SPRING
  #
  conda install -c bioconda fqzcomp --yes # FQZ_COMP
  #
  git clone https://github.com/refresh-bio/FaStore # FASTORE
  cd FaStore/
  make
  cp bin/fastore_* ..
  cd ..
  #
  git clone https://github.com/mariusmni/lfqc # LFQC
  #
  fi
#
# ==============================================================================
#
declare -a DATASET=("SRR12175231" "SRR12175232" "SRR12175233" "SRR12175234"
                "SRR12175235" "SRR327342" "ERP001775" "ERR174310" "SRR1284073");
#
# ==============================================================================
# DOWNLOAD READS:
#
if [[ "$DOWNLOAD" -eq "0" ]];
  then
  for file in "${DATASET[@]}"
    do
    fastq-dump $file
    awk -v count="1" '++count==4{$0="+" count=0} 1' $file.fastq > $file.fq
    rm -f $file.fastq;
    done
  fi
#
# ==============================================================================
#
if [[ "$BENCHMARK" -eq "0" ]];
  then
  for file in "${DATASET[@]}"
    do
    echo "Running $file ...";
    (time ./JARVIS2.sh --level $LEVEL --block 24MB --threads 8 --input $file ) 2> Report_JARVIS2_$file
    (time spring -c -i SRR12175232.f -o file.spring ) 2> Report_SPRING_$file
    done
  fi
#
# ==============================================================================
#
