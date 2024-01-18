#!/usr/bin/perl -w
use strict;
use warnings;

die "USAGE:\n $0 <IN> <OU>" unless (@ARGV==2);

open(IN, "<$ARGV[0]") or die "$!";
open(OUT,">$ARGV[1]") or die "$!";

$/="# Query: ";
while(<IN>){
    chomp $_;
    if(/# 0 hits found/){
          next;
    }
   else{
        my @lines=split/\n/,$_; 
        my $name=shift @lines;
           shift @lines;
           shift @lines;
        my @item_name;
        my @item_blast;
           map {
                 my @domains=split/\t/,$_;
                 my $name1=shift @domains;
                 my @names=split/,/,$name1;
                 my $name2=join ",",($names[0],$names[1]);
                    push @item_name,$name2;
                 my $domain=join "\t", @domains;
                    push @item_blast,$domain;
                    @names=();
                    @domains=();
                }@lines;
        my $item_name=join '|',@item_name;
        my $item_blast=join '|',@item_blast;
             print OUT "$name\*\*\*$item_name\*\*\*$item_blast\n";
           @item_name=();
           @item_blast=();
           @lines;
           
   } 
}
$/="\n";
close IN;
close OUT;
         
                                  
