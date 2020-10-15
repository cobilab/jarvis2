<p align="center"><img src="imgs/logo.png" 
alt="JARVIS2" width="300" border="0" /></p>
<p align="center"><b>High reference-free compression of genomic data</b></p>

### Installation ###

<pre>
git clone https://github.com/cobilab/jarvis2.git
cd jarvis2/src/
make
</pre>

### Execution ###

#### Run JARVIS2 ####

Run JARVIS2 using level 4:

<pre>
./JARVIS2 -v -l 4 File.seq
</pre>

### Parameters ###

To see the possible options type
<pre>
./JARVIS2 -h
</pre>

This will print the following options:
```

SYNOPSIS                                                           
      ./JARVIS2 [OPTION]... [FILE]                                 
                                                                   
SAMPLE                                                             
      Run Compression   -> ./JARVIS2 -v -l 4 sequence.txt          
      Run Decompression -> ./JARVIS2 -v -d sequence.txt.jc         
                                                                   
DESCRIPTION                                                        
      Lossless compression and decompression of genomic            
      sequences for efficient storage and analysis purposes.       
      Measure an upper bound of the sequence complexity.           
                                                                   
      -h,  --help                                                  
           Usage guide (help menu).                                
                                                                   
      -a,  --version                                               
           Display program and version information.                
                                                                   
      -x,  --explanation                                           
           Explanation of the context and repeat models.           
                                                                   
      -f,  --force                                                 
           Force mode. Overwrites old files.                       
                                                                   
      -v,  --verbose                                               
           Verbose mode (more information).                        
                                                                   
      -d,  --decompress                                            
           Decompression mode.                                     
                                                                   
      -e,  --estimate                                              
           It creates a file with the extension ".iae" with the  
           respective information content. If the file is FASTA or 
           FASTQ it will only use the "ACGT" (genomic) sequence. 
                                                                   
      -s,  --show-levels                                           
           Show pre-computed compression levels (configured).      
                                                                   
      -l [NUMBER],  --level [NUMBER]                               
           Compression level (integer).                            
           Default level: 4.                                      
           It defines compressibility in balance with computational
           resources (RAM & time). Use -s for levels perception.   
                                                                   
      -hs [NUMBER],  --hidden-size [NUMBER]                        
           Hidden size of the neural network (integer).            
           Default value: 40.                                      
                                                                   
      -lr [DOUBLE],  --learning-rate [DOUBLE]                      
           Neural Network leaning rate (double).                   
           Default value: 0.030.                                   
                                                                   
      [FILE]                                                       
           Input sequence filename (to compress) -- MANDATORY.     
           File to compress is the last argument.                  
                                                                   
```


To see the possible levels (automatic choosen compression parameters), type:
<pre>
./JARVIS2 -s
</pre>

#### Compression of FASTA data ####

Preparing FASTA compression setup:
<pre>
cd FASTA/
chmod +x *.sh
</pre>

Compression:
</pre>
./JARVIS2_FASTA_COMPRESS.sh file.fa
</pre>

Decompression:
<pre>
./JARVIS2_FASTA_DECOMPRESS.sh file.fa.tar
</pre>

#### Compressioon of FASTQ data ####

Preparing FASTQ compression setup:
<pre>
cd FASTQ/
chmod +x *.sh
</pre>

Compression:
</pre>
./JARVIS2_FASTQ_COMPRESS.sh file.fastq
</pre>

Decompression:
<pre>
./JARVIS2_FASTQ_DECOMPRESS.sh file.fastq.tar
</pre>

### Citation ###

<pre>
In progress...
</pre>

#### Issues ###

For any issue let us know at [issues link](https://github.com/cobilab/jarvis2/issues).

### License ###

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](LICENSE)

For more information:
<pre>http://www.gnu.org/licenses/gpl-3.0.html</pre>

                                                    

