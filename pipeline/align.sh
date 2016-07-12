#!/bin/bash
# generates bams from the accessions list in the parent directory

for ACC in $(cat ../accessions.txt) ; do
	if [[ ! -f $ACC.fastq ]] ; then
		fastq-dump $ACC
	fi
	if [[ ! -f ${ACC}Aligned.out.sam ]] ; then
		STAR \
			--runThreadN $(nproc) \
			--genomeDir ~/ref/star \
			--readFilesIn ~/axonalTranscripts/alignment/$ACC.fastq \
			--outFileNamePrefix $ACC
	fi
done
featureCounts \
	-a ~/ref/gencode.vM9.annotation.gtf \
	-o featureCounts.out \
	--primary \
	-t UTR \
	-f \
	*Aligned.out.sam
	
featureCounts \
	-a ~/ref/gencode.vM9.annotation.gtf \
	-o featureCounts.CDS.out \
	--primary \
	-t CDS \
	*Aligned.out.sam


