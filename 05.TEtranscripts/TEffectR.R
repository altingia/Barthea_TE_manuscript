setwd("/media/wuei/Edisk1/Projects/Barthea/Transposable_elements/05_TEtranscripts")
library(devtools)

devtools::install_github("karakulahg/TEffectR")
install.packages("dplyr")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("GenomicRanges",force=TRUE)
BiocManager::install("biomaRt",force=TRUE)
BiocManager::install("edgeR",force=TRUE)
library(stringr)
library(biomaRt)
library(biomartr)
library(dplyr)
library(Rsamtools)
library(edgeR)
library(rlist)
library(limma)
library(TEffectR)
gene.annot<-read.table("gene.anno", header= T, stringsAsFactors = F)
gene.counts<-read.table("gene.count", header= T, row.names=1, stringsAsFactors = F)
sum.repeat.counts<-read.table("sum.repeat.counts", header= T, stringsAsFactors = F)
covariates <- data.frame("Color" = c(rep("W",2), rep("R",3)))
prefix<-"SampleRun"

# apply linear modeling function of TEffectR
lm <-TEffectR::apply_lm(gene.annotation = gene.annot,
                       gene.counts = gene.counts,
                       repeat.counts = sum.repeat.counts,
                       covariates = covariates,
                       prefix = prefix)
head(lm)









