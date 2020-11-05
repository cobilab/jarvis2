#!/bin/bash
#
HELP=0;
ABOUT=0;
DECOMPRESS=0;
INSTALL=0;
BLOCK="24MB";
THREADS="8";
#
################################################################################
#
SHOW_MENU () {
  echo " -------------------------------------------------------";
  echo "                                                        ";
  echo " JARVIS2, v1.0 - DNA Extension {A, C, G, T} only        ";
  echo "                                                        ";
  echo " Program options ---------------------------------------";
  echo "                                                        ";
  echo " -h, --help                   Show this,                ";
  echo " -a, --about                  Show program information, ";
  echo " -c, --install                Install/compile programs, ";
  echo "                                                        ";
  echo " -b <INT>, --block <INT>      Block size to be splitted,";
  echo " -t <INT>, --threads <INT>    Number of JARVIS2 threads,";
  echo "                                                        ";
  echo " -d, --decompress             Decompression mode,       ";
  echo "                                                        ";
  echo " Input options -----------------------------------------";
  echo "                                                        ";
  echo " -i <FILE>, --input <FILE>    Input DNA filename.       ";
  echo "                                                        ";
  echo " Example -----------------------------------------------";
  echo "                                                        ";
  echo " ./JARVIS2.sh --block 10MB -t 8 -i sample.seq           ";
  echo " ./JARVIS2.sh --decompress -t 4 -i sample.seq.tar       ";
  echo "                                                        ";
  echo " -------------------------------------------------------";
  }
#
################################################################################
#
CHECK_INPUT () {
  FILE=$1
  if [ -f "$FILE" ];
    then
    echo "Input filename: $FILE"
    else
    echo -e "\e[31mERROR: input file not found!\e[0m";
    SHOW_MENU;
    exit;
    fi
  }
#
################################################################################
#
Program_installed () {
  if ! [ -x "$(command -v $1)" ];
    then
    echo -e "\e[41mERROR\e[49m: $1 is not installed." >&2;
    echo -e "\e[42mTIP\e[49m: Try: ./JARVIS2_FASTA.sh --install" >&2;
    exit 1;
    fi
  }
#
################################################################################
#
SHOW_HEADER () {
  echo "                                                        ";
  echo " [JARVIS2 :: DNA Extension]                             ";
  echo "                                                        ";
  echo " Release year: 2021,                                    ";
  echo " Version: 1.0                                           ";
  echo " Author: D. Pratas                                      ";
  echo " Language: Bash / C                                     ";
  echo " License: GPL v3                                        ";
  echo "                                                        ";
  }
#
################################################################################
#
if [[ "$#" -lt 1 ]];
  then
  HELP=1;
  fi
#
POSITIONAL=();
#
while [[ $# -gt 0 ]]
  do
  i="$1";
  case $i in
    -h|--help|?)
      HELP=1;
      shift
    ;;
    -a|--about|--version)
      ABOUT=1;
      shift
    ;;
    -c|--install|--compile)
      INSTALL=1;
      shift
    ;;
    -d|--decompress|--uncompress|--decompression)
      DECOMPRESS=1;
      shift
    ;;
    -b|--block)
      BLOCK="$2";
      shift 2;
    ;;
    -t|--threads)
      THREADS="$2";
      shift 2;
    ;;
    -i|--input)
      INPUT="$2";
      shift 2;
    ;;
    -*) # unknown option with small
    echo "Invalid arg ($1)!";
    echo "For help, try: ./JARVIS2.sh -h"
    exit 1;
    ;;
  esac
  done
#
set -- "${POSITIONAL[@]}" # restore positional parameters
#
################################################################################
#
if [[ "$HELP" -eq "1" ]];
  then
  SHOW_MENU;
  exit;
  fi
#
################################################################################
#
if [[ "$ABOUT" -eq "1" ]];
  then
  SHOW_HEADER;
  exit;
  fi
#
################################################################################
#
if [[ "$INSTALL" -eq "1" ]];
  then
  echo "Running installation ...";
  make
  echo "Done!"; 
  exit;
  fi
#
################################################################################
#
if [[ "$DECOMPRESS" -eq "0" ]];
  then
  # COMPRESSION
  #
  CHECK_INPUT "$INPUT";
  #
  Program_installed "./JARVIS2";
  #
  echo "Block size: $BLOCK";
  echo "Number of threads: $THREADS";
  echo "Compressing data ...";
  #
  ./SplitDNA.sh "$INPUT" "$BLOCK" "$THREADS" &
  wait
  #
  echo "Done!";
  ls -lah $INPUT.tar | awk '{ print "TOTAL:\t"$5; }'
  #
  rm -f DNA.JV2.tar .rep_out_enc
  #
  echo "Compressed file: $INPUT.tar";
  #
  else 
  # DECOMPRESSION:
  # 
  # Make sure file exits else die
  CHECK_INPUT "$INPUT";
  #
  Program_installed "./JARVIS2";
  #
  echo "Decompressing data ...";
  ./MergeDNA.sh "$INPUT" "$THREADS" &
  wait
  echo "Done!";
  echo "Decompressed file: $INPUT.out";
  #
  fi
#
################################################################################
#
