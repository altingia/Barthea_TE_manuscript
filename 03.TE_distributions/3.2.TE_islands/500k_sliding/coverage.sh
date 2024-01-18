#!/bin/bash
#rawbase=/disk/wuei/data/Barthea/EDTA_Bba2/re_classification/gff3_update
#base=$rawbase/analyses/visualizeTEislands

#bedtools makewindows -b bar.genome.bed -w 100000 |bedtools sort > windows/100kwinsliding.bed
bedtools makewindows -b 100k/bar.genome.bed -w 500000 -s 100000 |bedtools sort > windows/500kwinsliding.bed
sortBed -i bar_TIR.gff | gff2bed  |bedmap --echo --bases-uniq-f windows/500kwinsliding.bed - |tr "|" "\t" > 500k_sliding/TIR.windows.coverage.bed 
sortBed -i bar_Helitron.gff | gff2bed  |bedmap --echo --bases-uniq-f windows/500kwinsliding.bed - |tr "|" "\t" > 500k_sliding/Helitrion.windows.coverage.bed 
sortBed -i bar_nonLTR.gff | gff2bed  |bedmap --echo --bases-uniq-f windows/500kwinsliding.bed - |tr "|" "\t" > 500k_sliding/nonLTR.windows.coverage.bed 
sortBed -i bar.Copia.gff | gff2bed  |bedmap --echo --bases-uniq-f windows/500kwinsliding.bed - |tr "|" "\t" > 500k_sliding/Copia.windows.coverage.bed 
sortBed -i bar_TE.gff3 | gff2bed  |bedmap --echo --bases-uniq-f windows/500kwinsliding.bed - |tr "|" "\t" > 500k_sliding/TE.windows.coverage.bed 
sortBed -i bar_gene_exon.gff3 | gff2bed  |bedmap --echo --bases-uniq-f windows/500kwinsliding.bed - |tr "|" "\t" > 500k_sliding/Gene.windows.coverage.bed
bedtools intersect -wao -a bar_TEisland.bed -b ../../../out.gff3 |awk '{if($6=="gene"){print $0}}' |perl -pe 's/.*ID=(.*?);.*/$1/g' > TEisland.genes.lst
grep -f TEisland.genes.lst -A 1 /disk/wuei/software/kobas-docker/barthea_TEislands/out.pep.fasta > TEisland.genes.fa

annotate.py -i TEisland.genes.fa -s ath -o barthea_TEislands -n 30
identify.py -f  barthea_TEislands_500ksliding -b barthea_all -d K/G -o TEislands_enriched_500ksliding.out 
