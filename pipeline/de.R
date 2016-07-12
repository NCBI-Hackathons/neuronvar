#biocLite("edgeR", "locfit")
require(edgeR)

# edgeR Quick Start
utrcounts <- read.delim("featureCounts.out.txt")
cdscounts <- read.delim("featureCounts.CDS.out.txt")

utrx <- utrcounts[names(utrcounts)[-(1:6)]]
cdsx <- cdscounts[names(cdscounts)[-(1:6)]]

overallcounts <- colSums(utrx) / colSums(cdsx)

fcounts <- utrcounts

x <- fcounts[names(fcounts)[-(1:6)]]
rownames(x) <- paste0(fcounts$Geneid, "__", seq_along(fcounts$Geneid))
group <- factor(c(1,1,1,1,1,2,2,2,2,2)) # ax=1 bod=2
y <- DGEList(counts=x,group=group)
y <- calcNormFactors(y)
design <- model.matrix(~group)
y <- estimateDisp(y,design)
fit <- glmQLFit(y,design)
qlf <- glmQLFTest(fit,coef=2)
topTags(qlf)
