#!/bin/bash
grep -v "#" ../bar.genome.fa.mod.EDTA.TEanno.gff3 |awk {print } |sort |uniq -c|awk {print } > chrlst.txt
grep -v "Parent" ../bar.genome.fa.mod.EDTA.TEanno.gff3|grep -v "#"|grep -E "LTR" > bar.LTR.gff3
perl extract.pl chrlst.txt ../bar.genome.fa bar.LTR.gff3 bar.LTR.fa
#https://github.com/altingia/transposon_annotation_tools
proteinNCBICDD1000 -fastaFile bar.LTR.fa -resultFolder result
grep -v "RPSTBLASTN" result/Result001.txt |grep -v "Database" > bar_LTR1.txt
filter.pl bar_LTR1.txt bar_LTR2.txt
perl RT_extract.pl bar.LTR.fa bar_LTR2.txt bar_LTR_RT_domains.fa 
#grep -A 1 "Gypsy"  bar_LTR_RT_domains.fa|grep -v ">" |grep -v "-" |sort |uniq -c|wc -l
#grep -A 1 "Copia"  bar_LTR_RT_domains.fa|grep -v ">" |grep -v "-" |sort |uniq -c|wc -l
#grep -A 1 "_repeat_region"  bar_LTR_RT_domains.fa|grep -v ">" |grep -v "-" |sort |uniq -c|wc -l
#grep -A 1 "non_LTR"  bar_LTR_RT_domains.fa|grep -v ">" |grep -v "-" |sort |uniq -c|wc -l
#awk '{if($3=="repeat_region"){print $0}}'  ../bar.LTR.gff3|grep -v "Unknown" |awk -F"[\t;]" '{print $1,$3,$4,$5,$11}' > intact_LTR_id.txt
grep -A 1 "Copia" bar_LTR_RT_domains.fa|grep -v "-" >  copia_RT_domains1.fa
grep -A 1 "Gypsy" bar_LTR_RT_domains.fa|grep -v "-" >  gypsy_RT_domains1.fa
perl repeat_region_ltr_classification.pl intact_LTR_id.txt bar_repeat_region_LTR1.fa bar_repeat_region_LTR2.fa
grep -A 1 "Copia"  bar_repeat_region_LTR2.fa |grep -v "-" > bar_repeat_region_LTR2_copia.fa
grep -A 1 "Gypsy"  bar_repeat_region_LTR2.fa |grep -v "-" > bar_repeat_region_LTR2_gypsy.fa
