#https://github.com/schraderL/CobscuriorGenome/blob/master/analyses/RepeatLandscapes/plotLandscapes.Rmd
#perl /disk/wuei/software/Parsing-RepeatMasker-Outputs/parseRM.pl -i bar.genome.fa.align -l 20,0.2 --parse --gelen 235034099 -m 0.0013 -age 0.1, 1
#setwd("/media/wuei/Edisk1/Projects/Barthea/Transposable_elements/03.TE_distributions/landscape")
setwd("C:\\Users\\wuei\\Projects\\Transposable_elements\\03.TE_distributions\\landscape")
install.packages("ggplot2","viridisLite", "dplyr", "RColorBrewer")
install.packages("Rtools")
library(ggplot2)
library(viridisLite)
library(dplyr)
library(RColorBrewer)
rm(ls=list())
color = grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]
file<-"bar.genome.fa.align.parseRM.summary.tab"
system(paste("cat ",file,"|perl -pe 's/ +/\t/g'|sed 1,4d|sed '/^$/,/*/d'|perl -pe 's/^----.*\n//g' > bar.genome.fa.summary.tmp",sep=""))
system(paste("cat ",file,"|grep 'Coverage for each repeat class and divergence (Kimura)' -A 10000|perl -pe 's/ +/\t/g' > bar.genome.fa.summary.tmp2",sep=""))
sumTab<-read.csv("bar.genome.fa.summary.tmp",sep="\t",T,stringsAsFactors = F)
cols <- colorRampPalette(brewer.pal(8,"Blues"))(9)
sumTab$Class<-as.factor(sumTab$Class)
sumTab$Kimura[is.na(as.numeric(sumTab$Kimura))]
sumTab$c2<-gsub("(.*?)/.*","\\1",sumTab$Class,perl=T)
sumTab2<-read.csv("bar.genome.fa.summary.tmp2",sep="\t",skip = 1)
sumTabMelt<-reshape2::melt(sumTab2, id.vars="Div")
sumTabMelt$Class<-gsub("(.*?)\\..*","\\1",sumTabMelt$variable,perl=T)
sumTabMelt$Class<-as.factor(sumTabMelt$Class)
sumTabMelt$Fam<-as.factor(gsub(".*\\.(.*?)","\\1",sumTabMelt$variable))
set.seed(4)
plotData<-subset(sumTabMelt,Class!="tRNA" & Class!="Unknown"&Class!="rRNA"&Class!="pararetroviurs"&Class!="Simple_repeat")
plotData$Class<-as.factor(as.character(plotData$Class))
colSel<-sample(color, length(levels(plotData$Class)))

ggplot(plotData, aes(fill=Class,x=Div,y=100*value/235034099)) + 
  ylab("% genome")+ 
  xlim(-1,50)+
  xlab("Kimura distance (%)")+
  geom_bar(position="stack", stat="identity")+
  theme_classic()+
  scale_fill_manual(values=c("DNA" = 'red',
                             "LTR" = 'yellow',
                             "LINE" = 'blue',
                             "MITE" = 'green')
    ) + theme(legend.position = "right")
 tail(sumTabMelt)
plotData2<-subset(sumTabMelt,Class==("LTR"||"LINE"))
plotData2$Fam<-as.factor(as.character(plotData2$Fam))
colSel<-sample(color, length(levels(plotData$Fam)))
cols <- colorRampPalette(brewer.pal(8,"Blues"))(9)

plotData2$Fam <- factor(plotData2$Fam, levels = c("Gypsy","Copia","unknown","LINE"))
ggplot(plotData2, aes(fill=Fam, x=Div,y=100*value/235034099)) + 
  ylab("% genome")+ 
  xlim(-1,50)+
  xlab("Kimura distance (%)")+
  geom_bar(position="stack", stat="identity")+
  theme_classic()+
  theme(legend.position = "right")+
  scale_fill_manual(values = c("Copia" = 'red',
                               "Gypsy" = 'yellow',
                               "LINE" = 'blue',
                               "unknown" = 'green'))

#Timed data set created with parseRM.pl
#```{r}
type<-"whole genome"
data<-read.csv("./bar.genome.fa.align.landscape.My.Rname.tab",sep="\t",skip=1,check.names=FALSE)
colnames(data)[4:ncol(data)]<-round(as.numeric(gsub("\\[(.*?)\\;(.*?)\\[","\\2",colnames(data)[4:ncol(data)],perl=T)),1)
dataMelt<-reshape2::melt(data, id.vars=colnames(data)[1:3])
dataclass<-read.csv("./bar.genome.fa.align.landscape.My.Rclass.tab.xls",sep="\t",skip=1,check.names=FALSE)
colnames(dataclass)[2:ncol(dataclass)]<-round(as.numeric(gsub("\\[(.*?)\\;(.*?)\\[","\\1",colnames(dataclass)[2:ncol(dataclass)],perl=T)),1)
dataMeltclass<-reshape2::melt(dataclass, id.vars=colnames(dataclass)[1:1])
datafam<-read.csv("./bar.genome.fa.align.landscape.My.Rfam.tab",sep="\t",skip=1,check.names=FALSE)
colnames(datafam)[3:ncol(datafam)]<-round(as.numeric(gsub("\\[(.*?)\\;(.*?)\\[","\\1",colnames(datafam)[3:ncol(datafam)],perl=T)),1)
dataMeltfam<-reshape2::melt(datafam, id.vars=colnames(datafam)[1:2])
plotData3<-subset(dataMeltfam, Rclass!="pararetrovirus"&Rclass!="Unknown")
head(dataMeltclass)
#```{r}
ggplot(plotData3, aes(fill=Rclass, x=as.numeric(as.character(variable)),y=100*value/235034099)) + ylab("% genome")+ xlab("MYA")+ xlim(-1,16)+
  geom_bar(position="stack", stat="identity")+theme_classic()+
  scale_fill_manual(values = c("DNA" = 'red',
                               "LTR" = 'yellow',
                               "LINE" = 'blue',
                               "MITE" = 'green'))
  +theme(legend.position = "bottom",axis.text.x = element_text(angle = -45))+ggtitle(type)

ggplot(plotData3, aes(fill=Rfam, x=as.numeric(as.character(variable)),y=100*value/235034099)) + ylab("% genome")+ xlab("MYA")+ xlim(-1,16)+
  geom_bar(position="stack", stat="identity")+theme_classic()+
  scale_fill_manual(values = c("Copia" = 'red',
                               "Gypsy" = 'yellow',
                               "unknown" = 'blue',
                               "Helitron" = 'black',
                               "DTM" = "green",
                               "DTA" = "#FDDBC7",
                               "DTC" = "#B2182B",
                               "DTH" = "#D6604D",
                               "DTT" = "#2166AC"))
+theme(legend.position = "bottom",axis.text.x = element_text(angle = -45))+ggtitle(type)


