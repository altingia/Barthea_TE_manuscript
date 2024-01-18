#!/usr/bin/perl -w
use strict;
use warnings;

die "USAGE:\n $0 <id> <in> <out>" unless (@ARGV==3);

open(ID,"<$ARGV[0]") or die "$!";
open(IN,"<$ARGV[1]") or die "$!";
open(OUT, ">$ARGV[2]") or die "$!";

my %superfamily;
while(<ID>){
    chomp $_;
    my @line=split/ /,$_;
    my $superfamily = pop @line;
    my $line=join "_",@line;
       $superfamily{$line}=$superfamily;
       @line=();
}

while(<IN>){
      chomp $_;
      if(/>(.*)/){
              my @items=split/_/,$1;
              my $items=$1;
                 pop @items;
              my $name=join "_",@items;
              if(exists $superfamily{$name}){
              print OUT ">$items\t$superfamily{$name}\n";
          }
     }
     else{
              print OUT "$_\n";
     }
}     

close IN;
close OUT;
close ID;

