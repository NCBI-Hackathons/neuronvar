#source("https://bioconductor.org/biocLite.R")
#biocLite("biomaRt")
#biocLite("org.Hs.eg.db")
require(biomaRt)
require(org.Hs.eg.db)
require(stringr)
ensembl <- useMart("ensembl", dataset="hsapiens_gene_ensembl")
eg <- mappedkeys(org.Hs.egGO)
utr <- getSequence(id=eg, type="entrezgene", seqType="3utr", mart=ensembl)
names(utr) <- c("threeprimeutr", "entrezgene")
utr <- utr[regexpr("Sequence", utr$threeprimeutr)==-1,]
exportFASTA(utr, "utrs.fa")

library(BSgenome.Hsapiens.UCSC.hg19)
library(org.Hs.eg.db)
# load IDs, symbol and gene descriptions
refseq.id <- toTable(org.Hs.egREFSEQ)
symbol <- toTable(org.Hs.egSYMBOL)
gene.description <- toTable(org.Hs.egGENENAME)




