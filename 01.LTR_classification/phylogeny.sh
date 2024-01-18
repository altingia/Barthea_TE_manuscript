#!/bin/bash
ehttps://cme.h-its.org/exelixis/web/software/raxml/hands_on.html
awk '{if(/>/){print ">" ++sum;}else{print $0;}}' bar_LTR_Copia_RT_domains.fa > copia_name.fa
cat copia_name.fa Ty1_copia.fa > bar_LTR_Copia_RT_domains_outgroup.fa
awk '{if(/>/){print ">" ++sum;}else{print $0;}}' bar_LTR_Gypsy_RT_domains.fa > gypsy_name.fa
cat gypsy_name.fa Ty3_gypsy.fa > bar_LTR_Gypsy_RT_domains_outgroup.fa
rm -rf *_name.fa


mafft --thread 15  --maxiterate 1000 --localpair bar_LTR_Copia_RT_domains_outgroup.fa > bar_LTR_Copia_RT_domains_outgroup_aln.fa
mafft --thread 15  --maxiterate 1000 --localpair bar_LTR_Gypsy_RT_domains_outgroup.fa > bar_LTR_Gypsy_RT_domains_outgroup_aln.faq
java -jar /disk/wuei/software/ALTER/alter-lib/target/ALTER-1.3.4-jar-with-dependencies.jar -i ./bar_LTR_Copia_RT_domains_outgroup_aln.fa -ia -io Linux -o ./bar_LTR_Copia_RT_domains_outgroup.phy -of PHYLIP -op Jmodeltest -oo Linux -os
java -jar /disk/wuei/software/ALTER/alter-lib/target/ALTER-1.3.4-jar-with-dependencies.jar -i ./bar_LTR_Gypsy_RT_domains_outgroup_aln.fa -ia -io Linux -o ./bar_LTR_Gypsy_RT_domains_outgroup.phy -of PHYLIP -op Jmodeltest -oo Linux -os
modeltest-ng -d aa -i ./bar_LTR_Copia_RT_domains_outgroup.phy -t ml -o bar_LTR_Copia_RT_domains_outgroup_modeltest.out
modeltest-ng -d aa -i ./bar_LTR_Gypsy_RT_domains_outgroup.phy -t ml -o bar_LTR_Gypsy_RT_domains_outgroup_modeltest.out
java -jar /disk/wuei/software/ALTER/alter-lib/target/ALTER-1.3.4-jar-with-dependencies.jar -i ./bar_LTR_Copia_RT_domains_outgroup_aln.fa -ia -io Linux -o ./bar_LTR_Copia_RT_domains_outgroup.phy -of PHYLIP -op raxml -oo Linux -os
/home/wuei/anaconda2/pkgs/raxml-8.2.12-h516909a_2/bin/raxmlHPC-PTHREADS -s ./bar_LTR_Copia_RT_domains_outgroup.phy -m PROTGAMMAJTT -n bar_Copia_RT -p 12345 -T 15 
java -jar /disk/wuei/software/ALTER/alter-lib/target/ALTER-1.3.4-jar-with-dependencies.jar -i ./bar_LTR_Gypsy_RT_domains_outgroup_aln.fa -ia -io Linux -o ./bar_LTR_Gypsy_RT_domains_outgroup.phy -of PHYLIP -op raxml -oo Linux -os
/home/wuei/anaconda2/pkgs/raxml-8.2.12-h516909a_2/bin/raxmlHPC-PTHREADS -s ./bar_LTR_Gypsy_RT_domains_outgroup.phy -m PROTGAMMAJTT -n bar_Gypsy_RT -p 12345 -T 15 
