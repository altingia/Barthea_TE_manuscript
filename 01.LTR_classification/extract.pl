#!/usr/bin/perl -w
use warnings;
use strict;
use Time::Local;
die "USAGE:\n $0 <chrlst> <fa> <gff> <extracted_fa>" unless (@ARGV==4);

open(CHR,"<$ARGV[0]") or die "$!";
open (GEO, "<$ARGV[1]") or die "$!";
open (GFF, "<$ARGV[2]") or die "$!";
open (OUT, ">$ARGV[3]") or die "$!";
my %fa;
my $start=timelocal(localtime());
while(<CHR>){
    chomp $_;
    my $chr=$_;
       $/=">";
       while(<GEO>){
          chomp $_;
          if(/$chr/){
            my @seqs=split/\n/,$_;
               shift @seqs;
            my $seq=join '', @seqs;
               $fa{$chr}=$seq;
               @seqs=()
          }
          else{
                next;
         }
     }
    seek GEO, 0, 0; 
    $/="\n";
     while(<GFF>){
              chomp $_;
           my @lines=split/\t/,$_;
           my $seqname=join '_',($lines[0],$lines[2],$lines[3],$lines[4]);
              if(exists $fa{$lines[0]}){
                   my $seqs = substr($fa{$lines[0]},$lines[3]-1,$lines[4]-$lines[3]);
                      print OUT ">$seqname\n$seqs\n";
              }
              else{
                      next;
             } 
             @lines=();
     }
     seek GFF, 0, 0;
     %fa=();
}
my $end=timelocal(localtime());
my $time=$end-$start;
   print "Time consumed for this program: $start\t$end\t$time\n";
close CHR;
close GEO;
close GFF;
close OUT; 
