#!/usr/bin/perl -w
use strict;
use warnings;

die "USAGE:\n $0 <TE expression> <distances> <out>" unless (@ARGV==3);
open(TEX, "<$ARGV[0]") or die "$!";
my $dis = $ARGV[1];
open(OUT, ">$ARGV[2]") or die "$!";

#TE_homo_10034:TE_00000002:Unknown       0       0       3       1       1
while(<TEX>){
	  chomp $_;
	  my $line=$_;
	  my @line=split/\t/,$line;
	  my ($TE_id,$TE_class)=(split/\:/,$line[0])[0,2];
	     shift @line;
	  my $TE_id1=join '',($TE_id,"\t");
	     print "$TE_id1\n";
          my $s1 = " grep -E $TE_id1 bar.gff6 |head -n 1 > out1";
	     system($s1);
	     open(FH1,"<out1") or die "$!";
	      while(<FH1>){
		         chomp $_;
			 #chr02   EDTA    11361328        11362533        10217   +       .       TE_homo_10034   TE_00000002     Unknown
			 my  ($chr,$TE_end) = (split/\t/,$_)[0,3];
			 my  $hi = $TE_end + $dis; #default:5000
			 #grep -E "chr02" bar.gene.gff3|awk '{if(($2>11362533) && ($2<11367533)){print $0}}'
			 my $chr1=join '',($chr,"\t");
			 my $s2 = "grep -E $chr1 bar.gene.gff3 > temp";
			    system($s2);
			    open(FH2,"<temp") or die "$!";
			    while(<FH2>){
				   chomp $_;
				   my ($gene_s,$gene_name)=(split/\t/,$_)[1,3];
				   #  print "$gene_s\t$TE_end\t$hi\t$gene_name\n";
				      if(($gene_s > $TE_end)&&($gene_s < $hi)){
				           print "$gene_s\t$TE_end\t$hi\n";
				       	      my $out = join "\t",($gene_name,$TE_class,$TE_id,@line);
					     print OUT "$out\n";
					     last;
		                     }
	                   }     
                	   close FH2;
           }
	   close FH1; 
	   @line=();
    }
    close TEX;
    close OUT;
