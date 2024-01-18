library(ggplot2)



##GO富集图
go = read.table("Nested_multi1.ID3_kobas1.result",header=TRUE,sep="\t",check.names = FALSE)
go = go[1:20,]##绘制top30 term

g = ggplot(go,aes(-1*log10(PValue),Term))+geom_point(aes(size=gene_number,color=-1*log10(Qvalue)))
g = g+scale_color_gradient(low="blue",high ="red")
g = g+labs(size="Genes",x="-log10(Pvalue)",y="GO term",title="GO enrichment")
ggsave("Nested_multi1.ID3_kobas1.result_GO.pdf", width=8, height=6)
