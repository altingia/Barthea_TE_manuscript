#!/usr/bin/perl -w
#use strict;
#use warnings;

die "USAGE:\n $0 <chrlst> <TE_gff> <gene_gff> <out>" unless (@ARGV==4);

open(CH,"<$ARGV[0]") or die "$!";
open(GE,"<$ARGV[1]") or die "$!";
open(TE,"<$ARGV[2]") or die "$!";
open(OUT, ">$ARGV[3]") or die "$!";

my %chr;
while(<CH>){
    chomp  $_;
   my ($chr,$size)=split/\t/,$_;
     $chr{$chr} = $size;
}
close CH;

my @ge;
while(<GE>){
    chomp $_;
    push @ge,$_;
}
close GE;

my @te;
while(<TE>){
   chomp $_;
   push @te,$_;
}
close TE;

my $win=500000;
my $inc=100000;
foreach my $key (sort keys %chr){
   my $chr_size = $chr{$key};
   my $te_cov;
   my $end;
      for(my $i=0;$i < $chr_size - $win;$i+=$inc){
	  my $gene_count=0;
          my $te_size=0;
           map {
                  my @rec = split/\t/,$_;
                     if(($rec[0] eq $key)&&($rec[3] >= $i)&&($rec[4] <= $i+$win)){
                         $gene_count++;
			}
                     @rec=();
               }@ge;
           map {
                  my @rec = split/\t/,$_;
                     if(($rec[0] eq $key)&&($rec[3] >= $i)&&($rec[4] <= $i+$win)){
                         $te_size += ($rec[4]-$rec[3])+1;
 	             }
                     @rec=();
		}@te;
             $te_cov = $te_size/$win;
             $end = $i+$win;
           print OUT "$key\t$i\t$end\t$gene_count\t$te_cov\n";
     }
        my $count=0;
        my  $size=0;
         map{
             my @rec = split/\t/,$_;
                if($rec[0] eq $key&&$rec[3]>=$end){
                 $count++;
                }
               @rec = ();
            }@ge;
         map{
            my @rec = split/\t/,$_;
               if($rec[0] eq $key && $rec[3]> $end){
                 $size+=($rec[4]-$rec[3]);
               }
               @rec=();
           }@te;
          $te_cov=$size/($chr_size-$end);
         print OUT "$key\t$end\t$chr_size\t$count\t$te_cov\n";
      
 }
close OUT;


