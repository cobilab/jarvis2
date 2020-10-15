<p align="center"><img src="imgs/logo.png" 
alt="JARVIS2" width="300" border="0" /></p>
<p align="center"><b>High reference-free compression of genomic data</b></p>

## INSTALLATION ##

<pre>
git clone https://github.com/cobilab/jarvis2.git
cd jarvis2/src/
make
</pre>

## EXECUTION

### Run JARVIS

Run JARVIS2 using level 4:

<pre>
./JARVIS2 -v -l 4 File.seq
</pre>

## PARAMETERS

To see the possible options type
<pre>
./JARVIS2
</pre>
or
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
                                                                   
COPYRIGHT                                                          
      Copyright (C) 2014-2021, IEETA, University of Aveiro.        
      This is a Free software, under GPLv3. You may redistribute   
      copies of it under the terms of the GNU - General Public     
      License v3 <http://www.gnu.org/licenses/gpl.html>. There     
      is NOT ANY WARRANTY, to the extent permitted by law. 

```


If you are not interested in setting the template for each model, then use the levels mode. To see the possible levels type:
<pre>
./JARVIS2 -s
</pre>

## CITATION ##

On using this software/method please cite:

In progress...

## ISSUES ##

For any issue let us know at [issues link](https://github.com/cobilab/jarvis2/issues).

## LICENSE ##

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](LICENSE)

For more information:
<pre>http://www.gnu.org/licenses/gpl-3.0.html</pre>

                                                    

