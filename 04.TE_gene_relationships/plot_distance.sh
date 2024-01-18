#!/bin/bash
##summary of five categoires of TE 
grep -E "5-overlap" bar_TE_gene_relationship.txt|wc -l # 760
grep -E "3-overlap" bar_TE_gene_relationship.txt|wc -l # 630
grep -E  "downstream" bar_TE_gene_relationship.txt |wc -l # 26434
grep -E "upstream"  bar_TE_gene_relationship.txt |wc -l # 29282
awk '{if($(NF-1)==0){print $0}}'  bar_TE_gene_relationship.txt |wc -l #6592
awk 'BEGIN{FS="\t";OFS="\t"}{if($(NF-2) eq "0"){print $1,$2,$3,$4,$5,$6,$7,$8,$(NF-2),$NF}}' bar_TE_gene_relationship.txt|grep -v "overlap" |grep -E "CDS" |grep -v "intron" |grep -v "," |sort -n -k 1,2 > Nested_single_CDS.txt​ #  43
awk 'BEGIN{FS="\t";OFS="\t"}{if($(NF-2) eq "0"){print $1,$2,$3,$4,$5,$6,$7,$8,$(NF-2),$NF}}' bar_TE_gene_relationship.txt|grep -v "overlap" |grep -v "CDS" |grep -E "intron" |grep -v "," |sort -n -k 1,2 > Nested_single_intron.txt​ # 5626
awk 'BEGIN{FS="\t";OFS="\t"}{if($(NF-2) eq "0"){print $1,$2,$3,$4,$5,$6,$7,$8,$(NF-2),$NF}}' bar_TE_gene_relationship.txt|grep -v "overlap" |grep -v "CDS" |grep -E "5UTR" |grep -v "," |sort -n -k 1,2 > Nested_single_5UTR.txt​ # 446
awk 'BEGIN{FS="\t";OFS="\t"}{if($(NF-2) eq "0"){print $1,$2,$3,$4,$5,$6,$7,$8,$(NF-2),$NF}}' bar_TE_gene_relationship.txt|grep -v "overlap" |grep -v "CDS" |grep -E "3UTR" |grep -v "," |sort -n -k 1,2 > Nested_single_3UTR.txt #398
awk 'BEGIN{FS="\t";OFS="\t"}{if($(NF-2) eq "0"){print $1,$2,$3,$4,$5,$6,$7,$8,$9,$(NF-2),$NF}}' bar_TE_gene_relationship.txt|grep -v "overlap" |grep -v "UTR" |grep -E "," |sort -n -k 1,2 > Nested_multi.txt #50

## summary of downstream
grep -E  "downstream"  bar_TE_gene_relationship.txt|grep -E "Gypsy" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> Gypsy_downstream.txt  #8959
grep -E  "downstream"  bar_TE_gene_relationship.txt|grep -E "Copia" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> Copia_downstream.txt  #3307
grep -E  "downstream"  bar_TE_gene_relationship.txt|grep -E "helitron" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> helitron_downstream.txt  #3639
grep -E  "downstream"  bar_TE_gene_relationship.txt|grep -E "TIR" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> TIRs_downstream.txt  #7780
grep -E  "downstream"  bar_TE_gene_relationship.txt|awk '{print $2}' |sort |uniq -c
    919 CACTA_TIR_transposon
   3307 Copia_LTR_retrotransposon
   8959 Gypsy_LTR_retrotransposon
    313 hAT_TIR_transposon
   3639 helitron
   2624 LTR_retrotransposon          ##need to classified
   6254 Mutator_TIR_transposon
    253 PIF_Harbinger_TIR_transposon
    125 repeat_region                  ##need to be classified
     41 Tc1_Mariner_TIR_transposon

grep -E  "downstream"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |wc -l #2624
grep -E  "downstream"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l  #817 
grep -E  "downstream"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l  #1680
grep -E  "downstream"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l  #127
grep -E  "downstream"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|wc -l #125
grep -E  "downstream"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Copia" |wc -l #36
grep -E  "downstream"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Copia" |wc -l #89
## summary of upstream
grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "Gypsy" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> Gypsy_upstream.txt  #9547
grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "Copia" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> Copia_upstream.txt  #3571
grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "helitron" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> helitron_upstream.txt  #4131
grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "TIR" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> TIRs_upstream.txt  #9078
grep -E  "upstream"  bar_TE_gene_relationship.txt|awk '{print $2}' |sort |uniq -c
1130 CACTA_TIR_transposon
   3571 Copia_LTR_retrotransposon
   9547 Gypsy_LTR_retrotransposon
    412 hAT_TIR_transposon
   4131 helitron
   2812 LTR_retrotransposon                ##need to classified  
   7224 Mutator_TIR_transposon
    257 PIF_Harbinger_TIR_transposon
    143 repeat_region                     ##need to classified
     55 Tc1_Mariner_TIR_transposon

grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |wc -l #2812
grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l  #934 
grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l  #1773
grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l  #105
grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|wc -l #143
grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Copia" |wc -l #64
grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Gypsy" |wc -l #79
grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "nLTR" |wc -l  #0
## summary of 5-overlap
grep -E  "5-overlap"  bar_TE_gene_relationship.txt|grep -E "Gypsy" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> Gypsy_5-overlap.txt  #205
grep -E  "5-overlap"  bar_TE_gene_relationship.txt|grep -E "Copia" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> Copia_5-overlap.txt  #60
grep -E  "5-overlap"  bar_TE_gene_relationship.txt|grep -E "helitron" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> helitron_5-overlap.txt  #159
grep -E  "5-overlap"  bar_TE_gene_relationship.txt|grep -E "TIR" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> TIRs_5-overlap.txt  #281
grep -E  "5-overlap"  bar_TE_gene_relationship.txt|awk '{print $2}' |sort |uniq -c
62 CACTA_TIR_transposon
     60 Copia_LTR_retrotransposon
    205 Gypsy_LTR_retrotransposon
     17 hAT_TIR_transposon
    159 helitron
     40 LTR_retrotransposon                  ##need to classified  
    173 Mutator_TIR_transposon
     21 PIF_Harbinger_TIR_transposon
     15 repeat_region                           ##need to classified  
      8 Tc1_Mariner_TIR_transposon


grep -E  "5-overlap"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |wc -l #40
grep -E  "5-overlap"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l  #7
grep -E  "5-overlap"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l  #31
grep -E  "5-overlap"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l  #2
grep -E  "5-overlap"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|wc -l #15
grep -E  "5-overlap"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Copia" |wc -l #4
grep -E  "5-overlap"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Gypsy" |wc -l #10
grep -E  "5-overlap"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "nLTR" |wc -l #1
## summary of 3-overlap
grep -E  "3-overlap"  bar_TE_gene_relationship.txt|grep -E "Gypsy" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> Gypsy_3-overlap.txt  #207
grep -E  "3-overlap"  bar_TE_gene_relationship.txt|grep -E "Copia" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> Copia_3-overlap.txt  #46
grep -E  "3-overlap"  bar_TE_gene_relationship.txt|grep -E "helitron" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> helitron_3-overlap.txt  #111
grep -E  "3-overlap"  bar_TE_gene_relationship.txt|grep -E "TIR" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> TIRs_3-overlap.txt  #209
grep -E  "3-overlap"  bar_TE_gene_relationship.txt|awk '{print $2}' |sort |uniq -c
41 CACTA_TIR_transposon
     46 Copia_LTR_retrotransposon
    207 Gypsy_LTR_retrotransposon
     10 hAT_TIR_transposon
    111 helitron
     38 LTR_retrotransposon                    ##need to classified  
    141 Mutator_TIR_transposon
     10 PIF_Harbinger_TIR_transposon
     19 repeat_region                           ##need to classified  
      7 Tc1_Mariner_TIR_transposon


grep -E  "3-overlap"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |wc -l #38
grep -E  "3-overlap"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l  #14
grep -E  "3-overlap"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l  #24
grep -E  "3-overlap"  bar_TE_gene_relationship.txt|grep -E "LTR_retrotransposon" |grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l  #0
grep -E  "3-overlap"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|wc -l #19
grep -E  "3-overlap"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Copia" |wc -l #1
grep -E  "3-overlap"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Gypsy" |wc -l #18
grep -E  "3-overlap"  bar_TE_gene_relationship.txt|grep -E "repeat_region" |awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "nLTR" |wc -l #0




##summary of CDS nested
awk '{print $2}' Nested_single_CDS.txt|sort |uniq -c
 3 CACTA_TIR_transposon
      2 Copia_LTR_retrotransposon
     13 Gypsy_LTR_retrotransposon
      4 helitron
      2 LTR_retrotransposon   ##need to classified
     17 Mutator_TIR_transposon
      2 PIF_Harbinger_TIR_transposon
grep -E "LTR_retrotransposon" Nested_single_CDS.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy" |wc -l #2



### summary of 5UTR
grep -E "Gypsy" Nested_single_5UTR.txt|awk -F"\t" '{print $(NF-1);}' |sort -n 1> Gypsy_5UTR.txt  #115
grep -E "Copia" Nested_single_5UTR.txt|awk -F"\t" '{print $(NF-1);}' |sort -n 1> Copia_5UTR.txt  #85
grep -E "helitron" Nested_single_5UTR.txt|awk -F"\t" '{print $(NF-1);}' |sort -n 1> helitron_5UTR.txt  #83
grep -E  "TIR" Nested_single_5UTR.txt|awk -F"\t" '{print $(NF-1);}' |sort -n 1> TIRs_5UTR.txt  #126
awk '{print $2}' Nested_single_5UTR.txt|sort |uniq -c
15 CACTA_TIR_transposon
     85 Copia_LTR_retrotransposon
    115 Gypsy_LTR_retrotransposon
     12 hAT_TIR_transposon
     83 helitron
     37 LTR_retrotransposon
     95 Mutator_TIR_transposon
      4 PIF_Harbinger_TIR_transposon
grep -E "LTR_retrotransposon" Nested_single_5UTR.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |wc -l #37
grep -E "LTR_retrotransposon" Nested_single_5UTR.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l  #10
grep -E "LTR_retrotransposon" Nested_single_5UTR.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l  #25
grep -E "LTR_retrotransposon" Nested_single_5UTR.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l  #2

### summary of 3UTR
grep -E "Gypsy" Nested_single_3UTR.txt|awk -F"\t" '{print $(NF-1);}' |sort -n 1> Gypsy_3UTR.txt  #98
grep -E "Copia" Nested_single_3UTR.txt|awk -F"\t" '{print $(NF-1);}' |sort -n 1> Copia_3UTR.txt  #49
grep -E "helitron" Nested_single_3UTR.txt|awk -F"\t" '{print $(NF-1);}' |sort -n 1> helitron_3UTR.txt  #86
grep -E  "TIR" Nested_single_3UTR.txt|awk -F"\t" '{print $(NF-1);}' |sort -n 1> TIRs_3UTR.txt  #130
awk '{print $2}' Nested_single_3UTR.txt|sort |uniq -c
17 CACTA_TIR_transposon
     49 Copia_LTR_retrotransposon
     98 Gypsy_LTR_retrotransposon
      8 hAT_TIR_transposon
     86 helitron
     34 LTR_retrotransposon  ##need to classified
     97 Mutator_TIR_transposon
      7 PIF_Harbinger_TIR_transposon
      1 repeat_region   ##need to classified
      1 Tc1_Mariner_TIR_transposon
grep -E "LTR_retrotransposon" Nested_single_3UTR.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |wc -l #34
grep -E "LTR_retrotransposon" Nested_single_3UTR.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l  #11
grep -E "LTR_retrotransposon" Nested_single_3UTR.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l  #22
grep -E "LTR_retrotransposon" Nested_single_3UTR.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l  #1
grep -E "repeat_region" Nested_single_3UTR.txt|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|wc -l #1
grep -E "repeat_region" Nested_single_3UTR.txt|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Copia" |wc -l #1

### summary of intron
grep -E "Gypsy" Nested_single_intron.txt|awk -F"\t" '{print $(NF-1);}' |sort -n 1> Gypsy_intron.txt  #1170
grep -E "Copia" Nested_single_intron.txt|awk -F"\t" '{print $(NF-1);}' |sort -n 1> Copia_intron.txt  #460
grep -E "helitron" Nested_single_intron.txt|awk -F"\t" '{print $(NF-1);}' |sort -n 1> helitron_intron.txt  #1254
grep -E  "TIR" Nested_single_intron.txt|awk -F"\t" '{print $(NF-1);}' |sort -n 1> TIRs_intron.txt  #2391
awk '{print $2}' Nested_single_intron.txt|sort |uniq -c
635 CACTA_TIR_transposon
    460 Copia_LTR_retrotransposon
   1170 Gypsy_LTR_retrotransposon
    198 hAT_TIR_transposon
   1254 helitron
    313 LTR_retrotransposon     ##need to classified
   1419 Mutator_TIR_transposon
    123 PIF_Harbinger_TIR_transposon
     38 repeat_region      ##need to classified
     16 Tc1_Mariner_TIR_transposon
grep -E "LTR_retrotransposon" Nested_single_intron.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |wc -l #313
grep -E "LTR_retrotransposon" Nested_single_intron.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l  #101
grep -E "LTR_retrotransposon" Nested_single_intron.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l  #194
grep -E "LTR_retrotransposon" Nested_single_intron.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l  #18
grep -E "repeat_region" Nested_single_intron.txt|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|wc -l #38
grep -E "repeat_region" Nested_single_intron.txt|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Copia" |wc -l #14
grep -E "repeat_region" Nested_single_intron.txt|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Gypsy" |wc -l #24

awk '{print $2}'  Nested_multi.txt|sort |uniq -c 
      5 CACTA_TIR_transposon
      7 Copia_LTR_retrotransposon
      6 Gypsy_LTR_retrotransposon
      1 hAT_TIR_transposon
     19 helitron
      2 LTR_retrotransposon
      7 Mutator_TIR_transposon
      3 PIF_Harbinger_TIR_transposon
grep -E "LTR_retrotransposon" Nested_multi.txt|grep -v "Gypsy\|Copia"|awk '{print $5";"}'|xargs -n 1 -I {} grep -E {} ./bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l#1







































grep -E  "downstream"  bar_TE_gene_relationship.txt|grep -E "Gypsy" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> Gypsy_downstream.txt
grep -E  "upstream"  bar_TE_gene_relationship.txt|grep -E "Gypsy" |awk -F"\t" '{print $(NF-1);}' |sort -n 1> Gypsy_upstream.txt
awk 'BEGIN{FS="\t";OFS="\t"}{if($(NF-2) eq "0"){print $1,$2,$5,$(NF-2),$NF}}' bar_TE_gene_relationship.txt|grep -v "overlap" |grep -E "exon" |grep -v "intron" |grep -v "," |sort -n -k 1,2 > Nested_single_exon.txt
awk 'BEGIN{FS="\t";OFS="\t"}{if($(NF-2) eq "0"){print $1,$2,$5,$(NF-2),$NF}}' bar_TE_gene_relationship.txt|grep -v "overlap" |grep -E "intron" |grep -v "exon" |grep -v "," |sort -n -k 1,2 > Nested_single_intron.txt
awk 'BEGIN{FS="\t";OFS="\t"}{if($(NF-2) eq "0"){print $1,$2,$5,$(NF-2),$NF}}'  bar_TE_gene_relationship.txt|grep -v "overlap" |grep -v "UTR" |grep -E "," |sort -n -k 1,2 > Nested_multi.txt
#LTR-unclassified in total
grep -E "LTR_retrotransposon"  Nested_single_exon.txt |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $4";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |wc -l
#LTR-unclassified
grep -E "LTR_retrotransposon"  Nested_single_exon.txt |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $4";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Copia\|Gypsy"
#The catogories of TEs nested in the single exon
awk '{print $2}' Nested_single_exon.txt |sort |uniq -c

#summary the cateogories of TE nested in the single exon
awk '{print $2}' Nested_single_intron.txt |sort |uniq -c
#	635 CACTA_TIR_transposon
#    460 Copia_LTR_retrotransposon
#   1170 Gypsy_LTR_retrotransposon
#    198 hAT_TIR_transposon
#   1250 helitron
#    313 LTR_retrotransposon
#   1411 Mutator_TIR_transposon
#    123 PIF_Harbinger_TIR_transposon
#     38 repeat_region
#     16 Tc1_Mariner_TIR_transposon
grep -E "LTR_retrotransposon"  Nested_single_intron.txt |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $4";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |wc -l
#LTR-unclassified Copia
grep -E "LTR_retrotransposon"  Nested_single_intron.txt |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $4";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l  #101  
#LTR-unclassified Gypsy
grep -E "LTR_retrotransposon"  Nested_single_intron.txt |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $4";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l  #194
#LTR-unclassified nLTR
grep -E "LTR_retrotransposon"  Nested_single_intron.txt |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $4";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l   #18
grep -E "repeat_region" Nested_single_intron.txt |awk '{print $3";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |wc -l
grep -E "repeat_region" Nested_single_intron.txt|wc -l  #38
grep -E "repeat_region" Nested_single_intron.txt |awk '{print $3";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Copia" |wc -l  #14
grep -E "repeat_region" Nested_single_intron.txt |awk '{print $3";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Gypsy" |wc -l  #24

#summary the categories of TE nested in single utr
awk '{print $2}' Nested_single_utr.txt|sort |uniq -c
#	  3 CACTA_TIR_transposon
#     25 Copia_LTR_retrotransposon
#     30 Gypsy_LTR_retrotransposon
#     2 hAT_TIR_transposon
#     22 helitron
#    15 LTR_retrotransposon
#     28 Mutator_TIR_transposon
#      2 PIF_Harbinger_TIR_transposon
#     1 repeat_region

awk 'BEGIN{FS="\t";OFS="\t"}{if($(NF-2) eq "0"){print $1,$2,$5,$(NF-2),$NF}}'  bar_TE_gene_relationship.txt|grep -v "overlap" |grep -E "UTR" |grep -v "," |sort -n -k 1,2|grep -E "Copia" |wc -l  #

grep -E "LTR_retrotransposon"  Nested_single_utr.txt |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $4";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l #8
grep -E "LTR_retrotransposon"  Nested_single_utr.txt |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $4";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l #7
grep -E "repeat_region" Nested_single_utr.txt |awk '{print $3";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |wc -l #1

###summary of the categories of TE nested in multi utrs/exons/introns
awk '{print $2}' Nested_multi1.txt|sort |uniq -c
     97 CACTA_TIR_transposon
     32 Copia_LTR_retrotransposon
    157 Gypsy_LTR_retrotransposon
     22 hAT_TIR_transposon
    298 helitron
     46 LTR_retrotransposon
    169 Mutator_TIR_transposon
     36 PIF_Harbinger_TIR_transposon
     15 repeat_region
      8 Tc1_Mariner_TIR_transposon

grep -E "LTR_retrotransposon"  Nested_multi1.txt |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $4";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l #17
grep -E "LTR_retrotransposon"  Nested_multi1.txt |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $4";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l #23
grep -E "LTR_retrotransposon"  Nested_multi1.txt |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $4";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l #6
grep -E "repeat_region" Nested_multi1.txt |awk '{print $3";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Copia"|wc -l  # 4
grep -E "repeat_region" Nested_multi1.txt |awk '{print $3";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Gypsy"|wc -l  # 11

###summary of the categories of TE downstream the genes
grep -E "downstream"  bar_TE_gene_relationship.txt|awk '{print $2}' |sort |uniq -c
    798 CACTA_TIR_transposon
   3032 Copia_LTR_retrotransposon
   8309 Gypsy_LTR_retrotransposon
    265 hAT_TIR_transposon
   3082 helitron
   2420 LTR_retrotransposon
   5527 Mutator_TIR_transposon
    218 PIF_Harbinger_TIR_transposon
    105 repeat_region
     34 Tc1_Mariner_TIR_transposon
grep -E "LTR_retrotransposon"  bar_TE_gene_relationship.txt |grep -E "downstream" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l #740
grep -E "LTR_retrotransposon"  bar_TE_gene_relationship.txt |grep -E "downstream" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l #1557
grep -E "LTR_retrotransposon"  bar_TE_gene_relationship.txt |grep -E "downstream" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l #123
grep -E "repeat_region"  bar_TE_gene_relationship.txt |grep -E "downstream" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}'|xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Copia" |wc -l #33
grep -E "repeat_region"  bar_TE_gene_relationship.txt |grep -E "downstream" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Gypsy" |wc -l #72


grep -E "upstream"  bar_TE_gene_relationship.txt|awk '{print $2}' |sort |uniq -c
   1158 CACTA_TIR_transposon
   3805 Copia_LTR_retrotransposon
   9993 Gypsy_LTR_retrotransposon
    440 hAT_TIR_transposon
   4406 helitron
   2966 LTR_retrotransposon
   7736 Mutator_TIR_transposon
    258 PIF_Harbinger_TIR_transposon
    151 repeat_region
     55 Tc1_Mariner_TIR_transposon	 
grep -E "LTR_retrotransposon"  bar_TE_gene_relationship.txt |grep -E "upstream" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l #991
grep -E "LTR_retrotransposon"  bar_TE_gene_relationship.txt |grep -E "upstream" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l #1872
grep -E "LTR_retrotransposon"  bar_TE_gene_relationship.txt |grep -E "upstream" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l #103
grep -E "repeat_region"  bar_TE_gene_relationship.txt |grep -E "upstream" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}'|xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3|grep -v "Parent" |grep -E "Copia" |wc -l #64
grep -E "repeat_region"  bar_TE_gene_relationship.txt |grep -E "upstream" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Gypsy"|wc -l #87
###summary of the categories of TE 5'-overlap with the nearest gene
grep -E "5-overlap"  bar_TE_gene_relationship.txt|awk '{print $2}' |sort |uniq -c
     55 CACTA_TIR_transposon
     56 Copia_LTR_retrotransposon
    197 Gypsy_LTR_retrotransposon
     16 hAT_TIR_transposon
    125 helitron
     37 LTR_retrotransposon
    161 Mutator_TIR_transposon
     18 PIF_Harbinger_TIR_transposon
     13 repeat_region
      5 Tc1_Mariner_TIR_transposon
grep -E "LTR_retrotransposon"  bar_TE_gene_relationship.txt |grep -E "5-overlap" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l # 7
grep -E "LTR_retrotransposon"  bar_TE_gene_relationship.txt |grep -E "5-overlap" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l # 28
grep -E "LTR_retrotransposon"  bar_TE_gene_relationship.txt |grep -E "5-overlap" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l #2
grep -E "repeat_region"  bar_TE_gene_relationship.txt |grep -E "5-overlap" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Copia"|wc -l #3
grep -E "repeat_region"  bar_TE_gene_relationship.txt |grep -E "5-overlap" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Gypsy"|wc -l #9
grep -E "repeat_region"  bar_TE_gene_relationship.txt |grep -E "5-overlap" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "nLTR"|wc -l #1

###summary of the categories of TE 3'-overlap with the nearest gene
grep -E "3-overlap"  bar_TE_gene_relationship.txt|awk '{print $2}' |sort |uniq -c
     45 CACTA_TIR_transposon
     46 Copia_LTR_retrotransposon
    209 Gypsy_LTR_retrotransposon
     10 hAT_TIR_transposon
    119 helitron
     38 LTR_retrotransposon
    145 Mutator_TIR_transposon
     11 PIF_Harbinger_TIR_transposon
     18 repeat_region
      7 Tc1_Mariner_TIR_transposon
grep -E "LTR_retrotransposon"  bar_TE_gene_relationship.txt |grep -E "3-overlap" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Copia"|wc -l # 14
grep -E "LTR_retrotransposon"  bar_TE_gene_relationship.txt |grep -E "3-overlap" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "Gypsy"|wc -l # 24
grep -E "LTR_retrotransposon"  bar_TE_gene_relationship.txt |grep -E "3-overlap" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -E "nLTR"|wc -l #0
grep -E "repeat_region"  bar_TE_gene_relationship.txt |grep -E "3-overlap" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Copia"|wc -l #1
grep -E "repeat_region"  bar_TE_gene_relationship.txt |grep -E "3-overlap" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Gypsy"|wc -l #17
grep -E "repeat_region"  bar_TE_gene_relationship.txt |grep -E "3-overlap" |grep -v "Gypsy\|Copia" |sort |uniq -c|awk '{print $6";"}' |xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "nLTR"|wc -l #0

###GO enrichment analysis
###number of TEs in each intron
awk '{print $4}' Nested_single_intron.txt |awk -F"\." '{print $1"."$2;}' |sort |uniq -c|sort -nk 1 |awk '{print $2}'> Nested_single_intron.ID #2608, >1,1117 of with > 2 TEs, max:35
###number of TEs in each exon
awk '{print $4}' Nested_single_exon.txt |awk -F"\." '{print $1"."$2;}' |sort |uniq -c|sort -nk 1 |awk '{print $2}'> Nested_single_exon.ID  #336, 151 of with > 2 TEs, max:22
###number of TEs in each utr
awk '{print $4}' Nested_single_utr.txt |awk -F"\." '{print $1"."$2;}' |sort |uniq -c|sort -nk 1 |awk '{print $2}'> Nested_single_utr.ID  #46, >1, 21 of with 2TEs, max:18
###number of TEs in each multi intron/exon/utr
awk '{print $4}' Nested_multi1.txt |awk -F"\." '{print $1"."$2;}' |sort |uniq -c|sort -nk 1 |awk '{print $2}'> Nested_multi1.ID #592,>1, 151 of with 2TEs, max:10


###enrichment according TE class for nested TE
cat Nested_single_intron.txt Nested_single_exon.txt Nested_single_utr.txt Nested_multi1.txt > Nested_all.txt
##Gypsy TE annoted 
grep -E "Gypsy"  Nested_all.txt|awk '{print $4}' |awk -F"\." '{print $1"."$2;}' > Nested_Gypsy1.ID #1613
##Gypsy TE unannoted
grep -E "LTR_retrotransposon" Nested_all.txt |grep -v "Gypsy\|Copia" |awk '{print $3";"}'|xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Gypsy"|awk -F"[\t;]" '{print $9}' >Gypsy_id1  #271
sed -i 's/ID=//g' Gypsy_id1
cat Gypsy_id1|xargs -n 1 -I {} grep -E {}"\b" Nested_all.txt |awk -F"[\t\.]" '{print $4"."$5}' > Nested_Gypsy2.ID
grep -E "repeat_region" Nested_all.txt |grep -v "Gypsy\|Copia" |awk '{print $3";"}'|xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Gypsy"|awk -F"[\t;]" '{print $9}' >Gypsy_id3   #35
sed -i 's/ID=//g' Gypsy_id3
cat Gypsy_id3|xargs -n 1 -I {} grep -E {}"\b" Nested_all.txt |awk -F"[\t\.]" '{print $4"."$5}' > Nested_Gypsy4.ID #35

cat Nested_Gypsy1.ID Nested_Gypsy2.ID  Nested_Gypsy4.ID > Nested_Gypsy.ID

##Copia TE annoted 
grep -E "Copia"  Nested_all.txt|awk '{print $4}' |awk -F"\." '{print $1"."$2;}' > Nested_Copia1.ID #648
##Copia TE unannoted
grep -E "LTR_retrotransposon" Nested_all.txt |grep -v "Copia\|Copia" |awk '{print $3";"}'|xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Copia"|awk -F"[\t;]" '{print $9}' >Copia_id1  #143
sed -i 's/ID=//g' Copia_id1
cat Copia_id1|xargs -n 1 -I {} grep -E {}"\b" Nested_all.txt |awk -F"[\t\.]" '{print $4"."$5}' > Nested_Copia2.ID
grep -E "repeat_region" Nested_all.txt |grep -v "Copia\|Copia" |awk '{print $3";"}'|xargs -n 1 -I {} grep -E {} ../bar.genome.fa.mod.EDTA.TEanno.update.gff3 |grep -v "Parent" |grep -E "Copia"|awk -F"[\t;]" '{print $9}' >Copia_id3   #19
sed -i 's/ID=//g' Copia_id3
cat Copia_id3|xargs -n 1 -I {} grep -E {}"\b" Nested_all.txt |awk -F"[\t\.]" '{print $4"."$5}' > Nested_Copia4.ID #19

cat Nested_Copia1.ID Nested_Copia2.ID  Nested_Copia4.ID > Nested_Copia.ID


###TIR TE
grep -E "helitron"  Nested_all.txt|awk '{print $4}' |awk -F"\." '{print $1"."$2;}' > Nested_helitron.ID  #1761

###TIR
grep -E "TIR"  Nested_all.txt|awk '{print $4}' |awk -F"\." '{print $1"."$2;}' > Nested_TIRs.ID


