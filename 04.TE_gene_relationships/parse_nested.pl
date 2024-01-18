#!/usr/bin/perl -w

use warnings;
use strict;
die "USAGE:\n $0 < transposon file> <statistic_output_file> " unless (@ARGV==2);

#sort the genome annotation file, and delete CDS,gene,mRNA features
# chr01	Gypsy_LTR_retrotransposon	31468931	31469183	TE_homo_4441	chr01	mRNA	31468624	31469581	Barthea07716.t1	0	embeded
# grep -v "gene\|mRNA\|CDS" bar_genome_intron.gff3 > bar_genome_intron1.gff3
#awk 'BEGIN{FS="[\t\.]";OFS="\t"}{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10"."$11,$13,$14}' bar_helitron_gene_relationship1.txt > bar_helitron_gene_relationship2.txt

##chr01	.	exon	4870	5460	.	+	.	ID=Barthea00001.t1.exon1;Parent=Barthea00001.t1;
##chr01	.	intron	5461	7454	.	+	.	ID=Barthea00001.t1.intron1;Parent=Barthea00001.t1
##chr01	.	exon	7455	7709	.	+	.	ID=Barthea00001.t1.exon2;Parent=Barthea00001.t1;

open (TE, "$ARGV[0]") or die "$!";
open (OUT, ">$ARGV[1]") or die "$!";
while(<TE>){
   chomp $_;
   if(/Nested/){
         my @TE = split/\t/,$_;
         my $start = $TE[2];
         my $end = $TE[3];
         my $gene = "grep -E '$TE[9]' ./bar_genome_introns_reduced.gff3 > bar_$TE[9].gff3";
            system($gene);
            open (GENE,"< bar_$TE[9].gff3") or die "$!";
            
            my $cord;
            my @pos=();
            my @tmp;
            while(<GENE>){
              chomp $_;
              my @record = split/\t/,$_;
              my $feature= (split/[\.;]/,$record[8])[2];
                 $cord = $record[6];
              my $tmp = join "_",($feature,$record[3],$record[4]);
                 push @tmp,$tmp;
            }
            close GENE;
            unlink("bar_$TE[9].gff3");
            if($cord eq "-"){
                 @pos = reverse @tmp;
            }
            else{
                 map { 
                       push @pos, $_;
                 }@tmp;
            }
            @tmp =();
            my %pos;
            my @cord;
            my %dist;
           
               map{
                   my ($feature,$start,$end)=split/_/,$_;
                      push @cord,($start,$end);
                      $pos{$start} = $feature;
                      $pos{$end} = $feature;
             }@pos;
                ##insert the two cooridnates of TEs into the arrays of gene feature cooridnates and sort them
               push @cord,($start,$end);
            my @cord_new = sort { $a <=> $b } @cord;
               @cord=();
            my $i=0;
            my $j=0;
            my %cord;
               map {
                     
                     if($_==$start){
                        my $up_cord1;
                        my $down_cord1;
                           $up_cord1 = $pos{$cord_new[$i-1]};
                           $dist{$up_cord1}=$start - $cord_new[$i-1]+1;
                           $cord{$up_cord1}=1;
                       }
                        $i++;
                 }@cord_new;
                 map {
                       if($_==$end){
                        my $up_cord2;
                        my $down_cord2;
                              $down_cord2 = $pos{$cord_new[$j+1]};
                              $dist{$down_cord2}=$cord_new[$j+1]-$end + 1;
                              $cord{$down_cord2}=1;
                         }
                              $j++;     
               }@cord_new;
                @cord_new=();
                %pos=();
            
             my @nested;
                for my $key (keys %cord){
                       my $temp = join ':',($key,$dist{$key});  
                          push @nested,$temp;
                 }           
             my $nested = join ",",@nested;
                pop @TE;
                push @TE, $nested;
                my $out = join "\t",@TE;
                print OUT "$out\n";
                @TE=();
                %cord=();
                %dist=();
                @nested=();
        }
        else{
        print OUT "$_\n";
        }
 }
 close TE;
 close OUT;
