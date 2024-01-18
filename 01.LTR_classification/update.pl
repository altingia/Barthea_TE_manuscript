#!usr/bin/perl -w
#use strict;
#use warnings;
#ClassI_LTR_Copia
#ClassI_LTR_Gypsy
#ClassI_nLTR_LINE_I
#ClassI_nLTR_LINE_L1
#ClassI_nLTR_PLE
#ClassI_nLTR_SINE_tRNA
#chr01_LINE_element_4586517_4586698	ClassI_nLTR_LINE_L1
#
die "USAGE:\n $0 <update_info> <old gff> <update gff>" unless (@ARGV==3);

open(UPDATE, "<$ARGV[0]") or die "$!";
open(GFF,"<$ARGV[1]") or die "$!";
open(OUT,">$ARGV[2]") or die "$!";

my %anno;
while(<UPDATE>){
      chomp $_;
          my ($name,$anno)=split/\t/,$_;
          my @items=split/_/,$anno; 
             shift @items;
          my $class = shift @items;
          my $items=join "_", @items;
          my $anno1=join "/",($class,$items);
             $anno{$name}=$anno1;
             @$items=();
}
close UPDATE;

while(<GFF>){
      chomp $_;
         if(!/#/){
      my $record=$_;
      my @items=split/\t/,$record;
      my $name=join "_",($items[0],$items[2],$items[3],$items[4]);
         if(exists $anno{$name}){
                      $record=~s/Classification=(.*);Sequence/Classification=$anno{$name};Sequence/g;
                      print OUT "$record\n";
         }
         else{
              print OUT "$record\n";
         }
         @items=();
}
}
close GFF;
close OUT;
