-#!/usr/bin/perl -w
use strict;
use warnings;
die "USAGE:\n $0 < transposon file> <statistic_output_file> " unless (@ARGV==2);

#sort the genome annotation file, and delete CDS,gene,mRNA features
# chr01	Gypsy_LTR_retrotransposon	31468931	31469183	TE_homo_4441	chr01	mRNA	31468624	31469581	Barthea07716.t1	0	embeded
# grep -E "gene\|mRNA\|CDS" bar_genome_intron.gff3 > bar_genome_intron1.gff3
##chr01	.	exon	4870	5460	.	+	.	ID=Barthea00001.t1.exon1;Parent=Barthea00001.t1;
##chr01	.	intron	5461	7454	.	+	.	ID=Barthea00001.t1.intron1;Parent=Barthea00001.t1
##chr01	.	exon	7455	7709	.	+	.	ID=Barthea00001.t1.exon2;Parent=Barthea00001.t1;

open (TE, "$ARGV[0]") or die "$!";
open (OUT, ">$ARGV[1]") or die "$!";
while(<TE>){
            chomp $_;
         my @TE = split/\t/,$_;
         my $size = $TE[3]-$TE[2]+1;
         my $gene = "grep -E $TE[9] ./bar_genome_introns1.gff3 > bar_$TE[9].gff3";
            system($gene);
            open (GENE,"< bar_$TE[9].gff3") or die "$!";
            
            my $cord;
            my @pos;
            my @tmp;
            while(<GENE>){
              chomp $_;
              my @record = split/\t/,$_;
              my $feature= (split/\./,$record[8])[2];
                 $cord = $record[6];
              my $tmp = join '_',($feature,$record[3..4]);
                 push @pos,$pos;
            }
            close GENE;
            if($cord eq "-"){
                 @pos = reverse @tmp;
             }
            else{
                 @pos = @tmp;
            }
            @tmp =();
            my %pos;
            my @cord;
            my @dist;
            map{
                  my ($feature,$start,$end)=split/_/,$_;
                     push @cord,($start,$end);
                     $pos{$start} = $feature;
                     $pos{$end} = $feature;
                     
                }@pos;
                ##insert the two cooridnates of TEs into the arrays of gene feature cooridnates and sort them
               push @cord,($TE[2],$TE[3]);
            my @cord_new = sort { $a <=> $b } @cord;
               @cord=();
            my $i=0;
            my ($up_cord1,$down_cord1,$up_cord2,$down_cord2);
            
               map {
                     
                     if($_==$start){
                        if($i==0){
                           $up_cord1 = $pos{$cord_new[0]};
                           $cord_new[0]==$cord_new[1];
                           $down_cord1 = $pos{$cord_new[2]};
                           $dist{$down_cord1}=$cord_new[2]-$scord_new[1]+1;
                        }
                        else{
                           $up_cord1 = $pos{$cord_new[$i-1]};
                           $down_cord1 =$pos{$cord_new[$i+1]};
                           $dist{$down_cord1}=$cord_new[$i+1]-$start+1;
                        }
                     }
                     if($_==$end){
                        if($i==$#cord_new){
                           $up_cord2 = $pos{$#cord_new-1};
                           $down_cord2 = $pos{$#cord_new};
                           
                         }
                        else{
                           $up_cord2 = $pos($cord_new[$i-1]);
                           $down_cord2 =$pos($cord_new[$i+1]);
                           $dist{$down_cord1}=$end-$scord_new[$i-1]+1;
                        }
                      }
                    $i++;     
               }@cord_new;
                @cord_new=();
                %pos=();
             my %cord;
                $cord{$up_cord1}=1;
                $cord{$down_cord1}=1;
                $cord{$up_cord2}=1;
                $cord{$down_cord2}=1;
             my $nested;
                for my $key (keys %cord){
                    my $temp = join ',',($key,$dist{$key});  
                       push @nested,$temp;
                 }           
             my $nested = join ',',@nested;
                pop @TE;
                push @TE, $nested;
                my $out = join '\t',@TE;
                print OUT "$out\n";
                @TE=();
                %cord=();
                %dist=();
 }
 close TE;
 close OUT;
                  
               
             
               
                  
            
            
            
            
            
            
            
            
           
