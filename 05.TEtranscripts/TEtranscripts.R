#https://genviz.org/module-04-expression/0004/02/01/DifferentialExpression/
setwd("C:\\Users\\wuei\\Projects\\Transposable_elements\\05_TEtranscripts")
getwd()
rm(list=ls())
writeLines('PATH="C:\\rtools40\\usr\\bin;${PATH}"', con = "~/.Renviron")
Sys.which("make")
installed.packages()[, c("Package", "LibPath")]

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2",force=TRUE)
install.packages("devtools")
install.packages("ggplot2")
BiocManager::install("GenomeInfoDbData")
BiocManager::install("scales")
library(devtools)
library(DESeq2)
library(ggplot2)
library(viridis)
library(scales)
#grep -v "Parent" bar_sorted_ehz_vs_stj.cntTable| perl -ne 'chomp $_;{if(/STJ/){print "$_\n";} else{ my @lines=split/\t/,$_; my $num = 0;map{if($_==0){$num++;}}@lines;if($num < 5){my $lines=join "\t",@lines; print "$lines\n";} @lines=();}}' > bar_sorted_ehz_vs_stj_filtered.cntTable
data <- read.table("bar_sorted_ehz_vs_stj_filtered.cntTable",header=T,row.names=1)
groups <- factor(c(rep("TGroup",2),rep("CGroup",3)))
min_read <- 1
data <- data[apply(data,1,function(x){max(x)}) > min_read,]
sampleInfo <- data.frame(groups,row.names=colnames(data))
suppressPackageStartupMessages(library(DESeq2))
dds <- DESeqDataSetFromMatrix(countData = data, colData = sampleInfo, design = ~ groups)
dds$groups = relevel(dds$groups,ref="CGroup")
dds <- DESeq(dds)
deseq2Results <- results(dds,independentFiltering=F)
write.table(deseq2Results, file="bar_sorted_test_gene_TE_analysis.txt", sep="\t",quote=F)
resSig <- deseq2Results[(!is.na(deseq2Results$padj) & (deseq2Results$padj < 0.050000) &         (abs(deseq2Results$log2FoldChange)> 0.000000)), ]

write.table(resSig, file="bar_sorted_test_sigdiff_gene_TE.txt",sep="\t", quote=F)
?plotMA()
plotMA(dds)

deseq2ResDF <- as.data.frame(deseq2Results)
head(deseq2ResDF)
deseq2ResDF$significant <- ifelse(deseq2ResDF$padj < 0.050000, "Significant", NA)

ggplot(deseq2ResDF, aes(baseMean, log2FoldChange, colour=significant)) + 
  geom_point(size=1) + scale_y_continuous(limits=c(-3, 3), oob=squish) +
  scale_x_log10() + geom_hline(yintercept = 0, colour="tomato1", size=2) +
  labs(x="mean of normalized counts", y="log fold change") +
  scale_colour_manual(name="q-value", values=("Significant"="red"), na.value="grey50") +
  theme_bw()

ggplot(deseq2ResDF, aes(baseMean, log2FoldChange, colour=padj)) + 
  geom_point(size=1) + scale_y_continuous(limits=c(-3, 3), oob=squish) +
  scale_x_log10() + geom_hline(yintercept = 0, colour="darkorchid4", size=1, linetype="longdash") +
  labs(x="mean of normalized counts", y="log fold change") + scale_colour_viridis(direction=-1, trans='sqrt') + 
  theme_bw() + geom_density_2d(colour="black", size=2)











