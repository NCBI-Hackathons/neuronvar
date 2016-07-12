require(edgeR)

# edgeR Quick Start
fcounts <- read.delim("featureCounts.out.txt")
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
