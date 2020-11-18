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
  git clone --recursive https://github.com/GATB/leon.git
  cd leon
  sh INSTALL
  #
  fi
#
# ==============================================================================
#
declare -a DATASET=("SRR12175231" "SRR12175232" "SRR12175233" "SRR12175234"
                "SRR12175235" "SRR327342" "ERP001775" "ERR174310" "SRR1284073");

# SRR3190692: long read -> 11 GB
#
# ==============================================================================
# DOWNLOAD READS:
#
if [[ "$DOWNLOAD" -eq "0" ]];
  then
  for file in "${DATASET[@]}"
    do
    fastq-dump --bzip2 $file
    bunzip2 $file.fastq.bz2
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
    # RAM = 9GB
    (time ./JARVIS2.sh --level $LEVEL --block 24MB --threads 8 --input $file.fq ) 2> Report_JARVIS2_$file
    (time spring -c -i $file.fq -o $file.spring ) 2> Report_SPRING_$file
    #
    # RAM = 8GB
    (time fqz_comp -n2 -q3 -s8+ -e -b < $file.fq > $file.fqz ) 2> Report_SPRING_$file
    done
  fi
#
# ==============================================================================
#
