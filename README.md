# neuronvar
## RNA Isoform Variability in Neurons and other cell types -- NCBI-assisted Boston Genomics Hackathon and ISMB Hackathons

### Dependencies

#### Mandatory

sra toolkit.  [Downloadable]( http://www.ncbi.nlm.nih.gov/Traces/sra/?view=software) for your operating system!

magicBLAST  Download from here: ftp://ftp.ncbi.nlm.nih.gov/blast/executables/magicblast/

Hisat2 Download from here: ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.4-Linux_x86_64.zip

#### Useful

command line BLAST.  [Downloadable](ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/) for your operating system!

a detailed manual is available [here](http://www.ncbi.nlm.nih.gov/books/NBK279690/)

---

Instructions for using Amazon / Docker Image

$TOOLKIT is the path to the SRA toolkit

$BLAST is the path to command line BLAST tools

---

## Sample use case for this set of scripts

### Characterization of 3'UTR diversity in axons vs soma (neuron cell bodies) of Mus musculus motor neurons
    1) COMPARE ratio of 3'UTR to CDS reads in axon vs soma for all transcripts
    2) Calculate per gene relative expression of 3'UTR isoforms in axons vs soma 

Downloaded transcript info for mouse transcriptome from ENSEMBL biomart

Also downloadable from NCBI using the <link> <edirect>
 
#### Steps in this analysis:

1) Remove "Sequence unavailable" entries from fasta files
    - cat 3utr.fa | sed ':begin;$!N;s/\nSequence unavailable/Sequence unavailable/;tbegin;P;D' | grep -v Sequence > 3utr_v2.fa
    - grep -v -E '^$' 3utr_v2.fa > 3utr_v3.fa

2) Obtain SRA accessions (and metadata -- from SRA Run Selector)
  e.g. Axonal compartment vs cellbody compartment RNA (n=5 per compartment)

Example accession list

SRR1814075 
SRR1814076 
SRR1814077 
SRR1814078 
SRR1814079 
SRR1814080 
SRR1814081 
SRR1814074 
SRR1814073 
SRR1814072

3) Blast searches can be performed using the following script:     

blastn_vdb_wrap.pl
    
4) This script will count alignments by parsing SAM files:

samgrepscript.sh

5) Count files can be annotated using:

nameQueries.pl
