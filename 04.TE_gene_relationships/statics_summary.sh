grep embeded bar_copia_gene_relationship.txt |awk print |awk -F"[ .]" {print grep embeded bar_copia_gene_relationship.txt |awk 0 |awk -F"[ .]" {print ,} |sort |uniq -c
grep -E "nonoverlap" bar_copia_gene_relationship.txt |awk '{print $11}' |sort -nk 1 > copia_overall_disatance.txt
grep -E "nonoverlap" bar_copia_gene_relationship.txt |grep "upstream" |awk {print 1} |sort -nk 1 > copia_upstream_disatance.txt
grep -E "nonoverlap" bar_copia_gene_relationship.txt |grep "downstream" |awk {print $11} |sort -nk 1 > copia_downstream_disatance.txt
grep -E "overlapped" bar_copia_gene_relationship.txt |grep -v stream |grep 5-overlapped|wc -l
grep -E "overlapped" bar_copia_gene_relationship.txt |grep -v stream |grep 3-overlapped|wc -l
