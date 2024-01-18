#!/usr/bin/perl -w
use strict;
use warnings;

#cd00304.smp  RT
#cd01648.smp  RT
#pfam00078.smp    RT
#pfam07727.smp    RT
#pfam13966.smp    RT
#cd01644.smp  RT
#cd01709.smp  RT

die "USAGE:\n $0  <seqs> <domains.txt><RT.fasta>" unless (@ARGV==3);

open(SEQ,"<$ARGV[0]") or die "$!";
open(DOM,"<$ARGV[1]") or die "$!";
open(OUT,">$ARGV[2]") or die "$!";

my %domain=(
          'cd00304' => 'RT_like',
	  'cd01647' => 'RT_LTR',
	  'cd01650' => 'RT_nLTR_like',
	  'cd01709' => 'RT_like_1',
	  'pfam00078' => 'RVT_1',
	  'pfam07727' => 'RVT_2',
          'pfam13456' => 'RVT_3'); 
my %fa;
my $seq;
my $name;
while(<SEQ>){
   chomp $_;
   if(/>(.*)/){
      $name=$1;
      $seq=();
   }
   else{
      $seq.=$_;
      $fa{$name}=$seq;
  }
}
close SEQ;

while(<DOM>){
 my @lines=split/\*\*\*/,$_;
 my @domains=split/\|/,$lines[1];
 my @blast=split/\|/,$lines[2];
    map { 
           my $domain=(split/,/,$domains[$_])[0];
              if(exists $domain{$domain}){
                 my ($evalue,$start,$end)=split/\t/, $blast[$_];
                 my ($domain_size,$domain_aa)=getorf($fa{$lines[0]},$start,$end);
                 my $domain_name=join "_",($lines[0],$domain);
                    if($domain_size >49){
                          print OUT ">$domain_name\n$domain_aa\n";
                    }
             }
        }0..$#domains;
     @lines=();
     @domains=();
     @blast=();
}
close DOM;

sub getorf {
     my ($seq,$start,$end)=@_;
     my $seq_domain;
        if($start < $end){
               $seq_domain=substr($seq,$start-1,$end-$start+1);
        }
        else{
               $seq_domain=substr($seq,$end-1,$start-$end+1);
        }
        open (OUT1,">domain.fa") or die "$!";
        print OUT1 ">1\n$seq_domain\n";
        close OUT1;
     my $orf1 = "./ORFfinder -s 1 -in domain.fa -out orf1.fa";
     my $orf2 = "./ORFfinder -s 2 -in domain.fa -out orf2.fa";
     my $cat= "cat orf1.fa orf2.fa > orf.fa";
        system($orf1);
        system($orf2);
        system($cat);
	unlink("orf1.fa");
        unlink("orf2.fa");
        open(IN2,"<orf.fa") or die "$!";
        my %fa1;
        my $seq1;
        my $name1;
        while(<IN2>){
            chomp $_;
            if(/>(.*)/){
                $name1=(split/ /,$1)[0];
                $seq1=();
            }
            else{
                 $seq1.=$_;
                 $fa1{$name1}=$seq1;
            }
       }
       close IN2;
       unlink("orf.fa");
       unlink("domain.fa");
     my $maxSize=0;
     my $maxSeq;
     my $size=0;
    
       foreach my $key (sort keys %fa1){
                $size = length($fa1{$key});
                if($size > $maxSize){
                  $maxSize = $size;
                  $maxSeq = $fa1{$key};
                }
       }
        %fa1=();
        return $maxSize, $maxSeq;
   }
