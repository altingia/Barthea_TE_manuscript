#https://genviz.org/module-04-expression/0004/02/01/DifferentialExpression/
#https://master.bioconductor.org/packages/release/workflows/vignettes/rnaseqGene/inst/doc/rnaseqGene.html#exploratory-analysis-and-visualization
#setwd("D:\\Projects\\Barthea\\Transposable_elements\\05_TEtranscripts")
setwd("C:\\Users\\wuei\\Projects\\Transposable_elements\\05_TEtranscripts")
getwd()
list.files(dir)
rm(list=ls())
writeLines('PATH="C:\\rtools40\\usr\\bin;${PATH}"', con = "~/.Renviron")
Sys.which("make")
installed.packages()[, c("Package", "LibPath")]

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2",force=TRUE)
install.packages("devtools")
install.packages("ggplot2")
BiocManager::install("GenomeInfoDbData",force=TRUE)
BiocManager::install("pheatmap")
BiocManager::install("vsn")
library(devtools)
library(DESeq2)
library(ggplot2)
library(viridis)
library(scales)
library("pheatmap")
library("vsn")
library("RColorBrewer")
library("dplyr")
#grep -v "Parent" bar_sorted_ehz_vs_stj.cntTable| perl -ne 'chomp $_;{if(/STJ/){print "$_\n";} else{ my @lines=split/\t/,$_; my $num = 0;map{if($_==0){$num++;}}@lines;if($num < 5){my $lines=join "\t",@lines; print "$lines\n";} @lines=();}}' > bar_sorted_ehz_vs_stj_filtered.cntTable
data <- read.table("temp6",header=T,row.names=1)
tail(data)
groups <- factor(c(rep("TGroup",2),rep("CGroup",3)))
min_read <- 1
data <- data[apply(data,1,function(x){max(x)}) > min_read,]
sampleInfo <- data.frame(groups,row.names=colnames(data))
suppressPackageStartupMessages(library(DESeq2))
dds <- DESeqDataSetFromMatrix(countData = data, colData = sampleInfo, design = ~ groups)
nrow(dds)
keep <- rowSums(counts(dds) >= 10) >= 2
dds <- dds[keep,]
nrow(dds)

head(dds,30)
dds$groups = relevel(dds$groups,ref="CGroup")
dds <- estimateSizeFactors(dds)
vsd <- vst(dds)
colData(vsd)
rld <- rlog(dds, blind = FALSE)
head(assay(rld), 7)

df <- bind_rows(
  as_tibble(log2(counts(dds, normalized=TRUE)[, 1:2]+1)) %>%
    mutate(transformation = "log2(x + 1)"),
  as_tibble(assay(vsd)[, 1:2]) %>% mutate(transformation = "vst"),
  as_tibble(assay(rld)[, 1:2]) %>% mutate(transformation = "rlog"))
head(df)
colnames(df)[1:2] <- c("x", "y")  

lvls <- c("log2(x + 1)", "vst", "rlog")
df$transformation <- factor(df$transformation, levels=lvls)

ggplot(df, aes(x = x, y = y)) + geom_hex(bins = 80) +
  coord_fixed() + facet_grid( . ~ transformation)  

sampleDists <- dist(t(assay(dds)))
sampleDists

sampleDistMatrix <- as.matrix( sampleDists )
#rownames(sampleDistMatrix) <- paste( rld$dex, rld$cell )
#colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(10, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows = sampleDists,
         clustering_distance_cols = sampleDists,
         col = colors)

dds <- DESeq(dds)
nrow(dds)
deseq2Results <- results(dds,independentFiltering=F)
tail(deseq2Results)
write.table(deseq2Results, file="bar_sorted_ehz_vs_tjs_analysis.txt", sep="\t",quote=F)
resSig <- deseq2Results[(!is.na(deseq2Results$padj) & (deseq2Results$padj < 0.050000) &(abs(deseq2Results$log2FoldChange)>2)), ]
write.table(resSig, file="bar_sorted_ehz_vs_tjs_sigdiff.txt",sep="\t", quote=F)
plotMA(dds)

deseq2ResDF <- as.data.frame(deseq2Results)
tail(deseq2ResDF)
deseq2ResDF$Significance <- ifelse((deseq2ResDF$padj < 0.050000) &(abs(deseq2ResDF$log2FoldChange)>2), "Significant", NA)
write.table(deseq2ResDF,file="bar_sorted_ehz_vs_tjs_sigdiff2.txt",sep="\t", quote=F)
tempp<-read.csv("bar_sorted_ehz_vs_tjs_sigdiff3.txt",header=T,sep="\t")
head(tempp)
cols <- c("Gene" = "blue",  "TE" = "yellow","not_sig" = "grey50")
ggplot(tempp, aes(baseMean, log2FoldChange, colour=Significance)) + 
  geom_point(size=1) + scale_y_continuous(limits=c(-12, 12), oob=squish) +
  scale_x_log10() + geom_hline(yintercept = 2, colour="tomato1", size=1) +
  geom_hline(yintercept = -2, colour="tomato1", size=1)+
  labs(x="Mean of normalized counts", y="log2(fold change)") +
  scale_colour_manual(name="q-value", values=cols) +
  theme_bw()
