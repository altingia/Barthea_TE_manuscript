#!/bin/bash
 grep -v "Parent"   ../bar.genome.fa.mod.EDTA.TEanno.gff3|grep -v "#" |awk '{print $3}'|sort |uniq -c 

grep -v "Parent" ../bar.genome.fa.mod.EDTA.TEanno.gff3 |grep -E "Copia" > bar.Copia.gff3  # get the copia copies sequences
 wc -l bar.Copia.gff3   # count the copia copies
awk '{sum+=($5-$4+1);}END{print sum;}' bar.Copia.gff3 > bar.Copia_len0 # sum the total length of copia copies

grep -v "Parent" ../bar.genome.fa.mod.EDTA.TEanno.gff3|grep -E "Gypsy" > bar.Gypsy.gff3 # get count the Gypsy copies sequences
wc -l bar.Gypsy.gff3 #count the Gypsy copies
awk '{sum+=($5-$4+1);}END{print sum;}' bar.Gypsy.gff3 > bar.Gypsy_len0 # sum the total length of Gypsy copies

grep -v "Parent" ../bar.genome.fa.mod.EDTA.TEanno.gff3|grep -E "LTR/unknown" > bar.LTRUnknown.gff3 #summary the LTR/unknown copies
wc -l bar.LTRUnknown.gff3

perl extract.pl chrlst.txt ../bar.genome.fa bar.LTRUnknown.gff3 bar.LTRUnknown.fa

python /disk/wuei/software/biosoft/DeepTE/DeepTE.py -d  /disk/wuei/software/biosoft/DeepTE/working_LTRUnknown_dir_update -o  /disk/wuei/software/biosoft/DeepTE/output_bar_LTRunknown_update -i bar_LTRUnknown.fa -sp P -m_dir /disk/wuei/software/biosoft/DeepTE/Plants_model/ -fam ClassI
 awk '{print $2}'   /disk/wuei/software/biosoft/DeepTE/output_bar_LTRunknown_update/opt_DeepTE.txt|sort |uniq -c

 grep "Copia" /disk/wuei/software/biosoft/DeepTE/output_bar_LTRunknown_update/opt_DeepTE.txt|awk -F"_" '{sum+=($5-$4+1);}END{print sum;}' #total length of identified Copia copies
 grep "Gypsy" /disk/wuei/software/biosoft/DeepTE/output_bar_LTRunknown_update/opt_DeepTE.txt|awk -F"_" '{sum+=($5-$4+1);}END{print sum;}' #total length of identified Gypsy copies

grep -E "ClassI_nLTR_LINE_L1" bar_LTR_unknown_opt_DeepTE.txt|awk -F"_" '{sum+=($5-$4+1);}END{print sum;}'
grep -E "ClassI_nLTR_LINE_L1" bar_LTR_unknown_opt_DeepTE.txt|wc -l
grep -E "ClassI_nLTR_LINE_I" bar_LTR_unknown_opt_DeepTE.txt|wc -l
grep -E "ClassI_nLTR_LINE_I" bar_LTR_unknown_opt_DeepTE.txt|awk -F"_" '{sum+=($5-$4+1);}END{print sum;}'
grep -E "ClassI_nLTR_PLE" bar_LTR_unknown_opt_DeepTE.txt|wc -l 
grep -E "ClassI_nLTR_PLE" bar_LTR_unknown_opt_DeepTE.txt|awk -F"_" '{sum+=($5-$4+1);}END{print sum;}'
grep -E "ClassI_nLTR_SINE_tRNA" bar_LTR_unknown_opt_DeepTE.txt|wc -l
grep -E "ClassI_nLTR_SINE_tRNA" bar_LTR_unknown_opt_DeepTE.txt|awk -F"_" '{sum+=($5-$4+1);}END{print sum;}'
grep -E "ClassI_nLTR_SINE_tRNA" bar_LTR_unknown_opt_DeepTE.txt|wc -l
grep -E "ClassI_nLTR_SINE_tRNA" bar_LTR_unknown_opt_DeepTE.txt|awk -F"_" '{sum+=($5-$4+1);}END{print sum;}'
grep -E "ClassI_nLTR_LINE_I" bar_LTR_unknown_opt_DeepTE.txt|awk -F"_" '{sum+=($5-$4+1);}END{print sum;}'
