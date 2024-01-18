#!/usr/bin/perl -w
use strict;
use warnings;

die "USAGE:\n $0 <update_res> <original gff> <update_gff>" unless (@ARGV==3);
open(RES,"<$ARGV[0]") or die "$!";
open(GFF,"<$ARGV[1]") or die "$!";
open(OUT, ">$ARGV[2]") or die "$!";

my %id;
while(<RES>){
  chomp $_;
  my ($id,$name)=split/\t/,$_;
     $id{$id}=$name;
 }
 close RES;

 while(<GFF>){
  chomp $_;
  my @items=split/\t/,$_;
  my $name=join '_',@items[0..3];
     print "$name\n";
    if(exists $id{$name}){
      print OUT "$items[0]\t$id{$name}\t$items[2]\t$items[3]\t$items[4]\t$items[5]\t$items[6]\t$items[7]\t$items[8]\t$items[9]\t$items[10]\n";
   }
   else{
      print OUT "$items[0]\t$items[1]\t$items[2]\t$items[3]\t$items[4]\t$items[5]\t$items[6]\t$items[7]\t$items[8]\t$items[9]\t$items[10]\n"
   
      }
    @items=();
 }
 close GFF;
 close OUT;
