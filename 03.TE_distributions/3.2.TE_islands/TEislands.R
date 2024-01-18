TEislandSize<-15.34
TEislandGene<-1919
geneCount<-46430
genomeSize<-235.03
LDRgenesObs<-geneCount-TEislandGene
TEgenesExp<-geneCount*(TEislandSize/genomeSize)
LDRgenesExp<-geneCount*(1-TEislandSize/genomeSize)
ft<-fisher.test(matrix(c(TEislandGene,LDRgenesObs , TEgenesExp, LDRgenesExp), 2, 2))
print(ft)

source("https://bioconductor.org/biocLite.R")
BioC("biocUpgrade")
BiocManager::install("GO.db")
BiocManager::install("topGO")

install.packages("tidyr")
install.packages("dplyr")
library("topGO")
library("GO.db")
library("dplyr")
library("tidyr")
getwd()
functionalAnnotation<-read.csv("interpro.tsv",sep="\t",header=F)
head(functionalAnnotation)
GO<-subset(functionalAnnotation,V14!="",select=c(V1,V14),sep="\t")
head(GO)
colnames(GO)<-c("id","GOid")
GO$id<-gsub("-mRNA.*","",GO$id)
GO$GOid<-gsub("\\|",",",GO$GOid)
library(plyr)
all<-ddply(GO, .(id), summarize,
           GOid=paste(unique(GOid),collapse=","))
head(all)
scoID2go<-list()
for(i in 1:length(all$id)){
  scoID2go[[i]]<-unlist(strsplit(as.character(all$GOid[i]),","))
  names(scoID2go)[i]<-as.character(all$id[i])
}
scoNames.all<-names(scoID2go)
#restrict gene space to all SCOs orthologs
scoNames<-scoNames.all
scoNames <- factor(scoNames)
names(scoNames) <- scoNames

TEislandGenes<-read.csv("TEisland.genes.lst",header=FALSE)
OfInterest<-unlist(subset(all,id %in% TEislandGenes$V1,id))
scoList <- factor(as.integer(scoNames %in% OfInterest))
table(scoList)
names(scoList) <- scoNames
TEisSet<-subset(all,id %in% OfInterest)

GOdata_MF <- new("topGOdata", ontology = "MF", allGenes = scoList, annot = annFUN.gene2GO, gene2GO = scoID2go)
GOdata_BP <- new("topGOdata", ontology = "BP", allGenes = scoList, annot = annFUN.gene2GO, gene2GO = scoID2go)
GOdata_CC <- new("topGOdata", ontology = "CC", allGenes = scoList, annot = annFUN.gene2GO, gene2GO = scoID2go)

resultFis_MF 	<- runTest(GOdata_MF, algorithm = "parentchild", statistic = "fisher")
table_MF <- GenTable(GOdata_MF, parentChild = resultFis_MF, orderBy = "parentChild", ranksOf = "parentChild", topNodes = 53)

resultFis_BP <- runTest(GOdata_BP, algorithm = "parentchild", statistic = "fisher")
table_BP <- GenTable(GOdata_BP, parentChild = resultFis_BP, orderBy = "parentChild", ranksOf = "parentChild", topNodes = 57)

resultFis_CC <- runTest(GOdata_CC, algorithm = "parentchild", statistic = "fisher")
table_CC <- GenTable(GOdata_CC, parentChild = resultFis_CC, orderBy = "parentChild", ranksOf = "parentChild", topNodes = 11)

MF <- subset(table_MF, parentChild < 0.1)
BP <- subset(table_BP, parentChild < 0.1)
CC <- subset(table_CC, parentChild < 0.1)

MF$ontology<-"MF"
BP$ontology<-"BP"
CC$ontology<-"CC"

res<-rbind(MF,BP) %>% rbind(.,CC)
outfile<-"TEisland.GOenrichment.tsv"
outfile2<-"TEisland.GOenrichment.REVIGOready.tsv"
write.table(res,outfile,quote=F,sep="\t",row.names = F)
cat("# GO enrichment of genes located in TE islands\n",file=outfile)
write.table(res, outfile,append=TRUE, quote=F,sep="\t",row.names=F)
write.table(subset(res,parentChild<0.05,select=c(GO.ID,parentChild)), outfile2,quote=F,sep="\t",row.names=F)
