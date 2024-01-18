#!/usr/bin/perl -w
#use strict;
#use warnings;
die "USAGE:\n $0  <gff_old> <gff_intron>" unless (@ARGV==2);
open (IN, "<$ARGV[0]") or die "$!";
open (OUT,">$ARGV[1]") or die "$!";
#chr01   .       gene    4870    7709    0.05    +       .       ID=Barthea00001;Augustus_transcriptSupport_percentage=0;Augustus_intronSupport=0/1;Source=augustus00001;Integrity=complete;
#chr01   .       mRNA    4870    7709    0.05    +       .       ID=Barthea00001.t1;Parent=Barthea00001;IntronSupport=0/1;Integrity=complete;
#chr01   .       exon    4870    5460    .       +       .       ID=Barthea00001.t1.exon1;Parent=Barthea00001.t1;
#chr01   .       CDS     4870    5460    0.87    +       0       ID=Barthea00001.t1.CDS1;Parent=Barthea00001.t1;
#chr01   .       exon    7455    7709    .       +       .       ID=Barthea00001.t1.exon2;Parent=Barthea00001.t1;
#chr01   .       CDS     7455    7709    0.05    +       0       ID=Barthea00001.t1.CDS2;Parent=Barthea00001.t1;
##case 2 
#chr01	.	gene	6727790	6734596	1	-	.	ID=Barthea01757;augustus_transcriptSupport_percentage=100;augustus_intronSupport=2/2;source=augustus01803;integrity=complete;
#chr01	.	mRNA	6727790	6734596	1	-	.	ID=Barthea01757.t1;Parent=Barthea01757;itronSupport=2/2;integrity=complete;
#chr01	.	five_prime_UTR	6729266	6734596	.	-	.	ID=Barthea01757.t1.5UTR1;Parent=Barthea01757.t1;
#chr01	.	exon	6729266	6734596	.	-	.	ID=Barthea01757.t1.exon1;Parent=Barthea01757.t1;
#chr01	.	intron	6734597	6728975	.	+	.	ID=Barthea01757.t1.intron1;Parent=Barthea01757.t1
#chr01	.	five_prime_UTR	6729109	6729118	.	-	.	ID=Barthea01757.t1.5UTR2;Parent=Barthea01757.t1;
#chr01	.	exon	6728976	6729118	.	-	.	ID=Barthea01757.t1.exon2;Parent=Barthea01757.t1;
#chr01	.	intron	6729119	6728582	.	+	.	ID=Barthea01757.t1.intron2;Parent=Barthea01757.t1
#chr01	.	CDS	6728976	6729108	1	-	0	ID=Barthea01757.t1.CDS1;Parent=Barthea01757.t1;
#chr01	.	exon	6728583	6728871	.	-	.	ID=Barthea01757.t1.exon3;Parent=Barthea01757.t1;
#chr01	.	intron	6728872	6727789	.	+	.	ID=Barthea01757.t1.intron3;Parent=Barthea01757.t1
#chr01	.	CDS	6728583	6728871	1	-	2	ID=Barthea01757.t1.CDS2;Parent=Barthea01757.t1;
#chr01	.	CDS	6728196	6728499	1	-	1	ID=Barthea01757.t1.CDS3;Parent=Barthea01757.t1;
#chr01	.	three_prime_UTR	6727790	6728195	.	-	.	ID=Barthea01757.t1.3UTR1;Parent=Barthea01757.t1;
#chr01	.	exon	6727790	6728499	.	-	.	ID=Barthea01757.t1.exon4;Parent=Barthea01757.t1;

my @gene;
while(<IN>){
    chomp $_;
    if(/gene/){
       if(@gene){
        my @exons;my $cordinate; my $parent;my $chr;my $j=0;my %p;
           map{
                if(/exon/){
                   my @line=split/\t/,$_;
                      push @exons,($line[3],$line[4]);
                      $parent=(split/[;=]/,$line[8])[1];
                      $parent=~s/\.exon[1-9]+//;
                      $chr=$line[0];
		      $cordinate=$line[6];
                      $p{$line[3]}=$j;
                }
                     $j++;
           } @gene;
           
           if($#exons>1){
                for(my $i = 0,my $n=0;$i<=$#exons-2;$i=$i+2,$n++){
                        my $k=$n+1;
                        my $record;
                           if($cordinate eq "+"){ 
                              $record=join "\t",($chr,".","intron",$exons[$i+1]+1,$exons[$i+2]-1,".","+",".","ID=$parent.intron$k;Parent=$parent");
                           }
                           if($cordinate eq "-"){
                              $record=join "\t",($chr,".","intron",$exons[$i+3]+1,$exons[$i]-1,".","-",".","ID=$parent.intron$k;Parent=$parent");
                           }  
                          splice @gene,$p{$exons[$i]}+$n+1,0,$record;
               }
           }
            %p=();
            @exons=();   
           my $gene1=join "\n",@gene;
             print OUT "$gene1\n";
            @gene=();
       }
       print OUT "$_\n";
  }
  else{
         push @gene,$_;
 }
}
    close OUT;
    close IN; 
     
