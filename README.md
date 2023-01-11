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

Run JARVIS2 using level 9:

<pre>
./JARVIS2 -v -l 9 File.seq
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

To see the meaning of the model parameters, type:
<pre>
./JARVIS2 -x
</pre>
This will output the following content:
<pre>
      -cm [NB_C]:[NB_D]:[NB_I]:[NB_G]/[NB_S]:[NB_E]:[NB_I]:[NB_A]  
      Template of a context model.                                 
      Parameters:                                                  
      [NB_C]: (integer [1;20]) order size of the regular context   
              model. Higher values use more RAM but, usually, are  
              related to a better compression score.               
      [NB_D]: (integer [1;5000]) denominator to build alpha, which 
              is a parameter estimator. Alpha is given by 1/[NB_D].
              Higher values are usually used with higher [NB_C],   
              and related to confiant bets. When [NB_D] is one,    
              the probabilities assume a Laplacian distribution.   
      [NB_I]: (integer {0,1,2}) number to define if a sub-program  
              which addresses the specific properties of DNA       
              sequences (Inverted repeats) is used or not. The     
              number 1 turns ON the sub-program using at the same  
              time the regular context model. The number 2 does    
              only contemple the invesions only (NO regular). The  
              number 0 does not contemple its use (Inverted repeats
              OFF). The use of this sub-program increases the      
              necessary time to compress but it does not affect the
              RAM.                                                 
      [NB_G]: (real [0;1)) real number to define gamma. This value 
              represents the decayment forgetting factor of the    
              regular context model in definition.                 
      [NB_S]: (integer [0;20]) maximum number of editions allowed  
              to use a substitutional tolerant model with the same 
              memory model of the regular context model with       
              order size equal to [NB_C]. The value 0 stands for   
              turning the tolerant context model off. When the     
              model is on, it pauses when the number of editions   
              is higher that [NB_C], while it is turned on when    
              a complete match of size [NB_C] is seen again. This  
              is probabilistic-algorithmic model very usefull to   
              handle the high substitutional nature of genomic     
              sequences. When [NB_S] > 0, the compressor used more 
              processing time, but uses the same RAM and, usually, 
              achieves a substantial higher compression ratio. The 
              impact of this model is usually only noticed for     
              [NB_C] >= 14.                                        
      [NB_R]: (integer {0,1}) number to define if a sub-program    
              which addresses the specific properties of DNA       
              sequences (Inverted repeats) is used or not. It is   
              similar to the [NR_I] but for tolerant models.       
      [NB_E]: (integer [1;5000]) denominator to build alpha for    
              substitutional tolerant context model. It is         
              analogous to [NB_D], however to be only used in the  
              probabilistic model for computing the statistics of  
              the substitutional tolerant context model.           
      [NB_A]: (real [0;1)) real number to define gamma. This value 
              represents the decayment forgetting factor of the    
              substitutional tolerant context model in definition. 
              Its definition and use is analogus to [NB_G].        
                                                                   
      ... (you may use several context models)                     
                                                                   
                                                                   
      -rm [NB_R]:[NB_C]:[NB_A]:[NB_B]:[NB_L]:[NB_G]:[NB_I]:[NB_W]:[NB_Y]
      Template of a repeat model.                                  
      Parameters:                                                  
      [NB_R]: (integer [1;10000] maximum number of repeat models   
              for the class. On very repetive sequences the RAM    
              increases along with this value, however it also     
              improves the compression capability.                 
      [NB_C]: (integer [1;20]) order size of the repeat context    
              model. Higher values use more RAM but, usually, are  
              related to a better compression score.               
      [NB_A]: (real (0;1]) alpha is a real value, which is a       
              parameter estimator. Higher values are usually used  
              in lower [NB_C]. When [NB_A] is one, the             
              probabilities assume a Laplacian distribution.       
      [NB_B]: (real (0;1]) beta is a real value, which is a        
              parameter for discarding or maintaining a certain    
              repeat model.                                        
      [NB_L]: (integer (1;20]) a limit threshold to play with      
              [NB_B]. It accepts or not a certain repeat model.    
      [NB_G]: (real [0;1)) real number to define gamma. This value 
              represents the decayment forgetting factor of the    
              regular context model in definition.                 
      [NB_I]: (integer {0,1,2}) number to define if a sub-program  
              which addresses the specific properties of DNA       
              sequences (Inverted repeats) is used or not. The     
              number 1 turns ON the sub-program using at the same  
              time the regular context model. The number 0 does    
              not contemple its use (Inverted repeats OFF). The    
              number 2 uses exclusively Inverted repeats. The      
              use of this sub-program increases the necessary time 
              to compress but it does not affect the RAM.          
      [NB_W]: (real (0;1)) initial weight for the repeat class.    
      [NB_Y]: (integer {0}, [50;*]) repeat cache size. This will   
              use a cache of entries while hashing. Value '0' will 
              use the whole sequence length. 
</pre>


#### Compression of FASTA data ####

Preparing JARVIS2 for FASTA:
<pre>
chmod +x *.sh
./JARVIS2.sh --install
</pre>

Compression:
<pre>
./JARVIS2.sh --threads 8 --fasta --block 10MB --input sample.fa
</pre>

Decompression:
<pre>
./JARVIS2.sh --decompress --fasta --threads 4 --input sample.fa.tar
</pre>

#### Compression of FASTQ data ####

Preparing JARVIS2 for FASTQ:
<pre>
chmod +x *.sh
./JARVIS2.sh --install
</pre>

Compression:
<pre>
./JARVIS2.sh --threads 8 --fastq --block 40MB --input sample.fq
</pre>

Decompression:
<pre>
./JARVIS2.sh --decompress --fastq --threads 4 --input sample.fq.tar
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


