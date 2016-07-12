# reference file setup
mkdir ~/ref
cd ~/ref
wget ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_mouse/release_M9/gencode.vM9.annotation.gtf.gz
gunzip < gencode.vM9.annotation.gtf.gz > gencode.vM9.annotation.gtf
mkdir star
cd star
STAR --runThreadN $(nproc) \
	--runMode genomeGenerate \
	--genomeDir ~/ref/star \
	--genomeFastaFiles ~/ref/mm10.fa \
	--sjdbGTFfile ~/ref/gencode.vM9.annotation.gtf
