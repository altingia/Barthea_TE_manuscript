#!/usr/bin/perl -w
use strict;
use warnings;
die "USAGE:\n $0 <transposon file><genome_coordinated gff3> <statistic_output_file> " unless (@ARGV==3);

open (TE, "$ARGV[0]") or die "$!";
my $genome_gff=$ARGV[1];
open (OUT, ">$ARGV[2]") or die "$!";
while(<TE>){
          chomp $_;
         my ($chr,$feature,$start,$end,$id)=(split/[\t;]/,$_)[0,2,3,4,8];
         my $subgenome = "grep -E $chr  $genome_gff > bar_$chr.gff3";
            system($subgenome);
         my ($chr1,$feature1,$start1,$end1,$id1,$d1);
         my ($chr2,$feature2,$start2,$end2,$id2,$d2);
         my ($chr3,$feature3,$start3,$end3,$id3); my $d3=1;
         my ($chr4,$feature4,$start4,$end4,$id4,$d4);
         my ($chr5,$feature5,$start5,$end5,$id5,$d5);
         my $case1 = "gawk  '{if(\$5<$start){print \$0;}}' bar_$chr.gff3 | tail -n 1 >hit_nonoverlap_downstream";
            system($case1);
            open (RES1,"<hit_nonoverlap_downstream") or die "$!";
            my $res1;
            while(<RES1>){
               chomp $_;
               $res1=$_;
            }
            if(-s "hit_nonoverlap_downstream"){
                  ($chr1,$feature1,$start1,$end1,$id1)=(split/[\t;]/,$res1)[0,2,3,4,8];
                  $d1 = int($start)-int($end1);
            }
            unlink("hit_nonoverlap_downstream");
         my $case2 = "awk '{if((\$5>$start)&&(\$5<$end)&&(\$4<$start)){print \$0};}' bar_$chr.gff3 |tail -n 1 >hit_3overlap";
            system($case2);
            open (RES2, "<hit_3overlap") or die "$!";
            my $res2;
            while(<RES2>){
               chomp $_;
               $res2=$_;
            }
            if(-s "hit_3overlap"){
               ($chr2,$feature2,$start2,$end2,$id2)=(split/[\t;]/,$res2)[0,2,3,4,8];
               $d2 = $end2-$start;
            }
             unlink("hit_3overlap");
         my $case3 = "awk '{if((\$5>=$end)&&(\$4<$start)){print \$0};}' bar_$chr.gff3|tail -n 1 >hit_embeded";
            system($case3);
            open (RES3, "<hit_embeded") or die "$!";
            my $res3;
            while(<RES3>){
               chomp $_;
               $res3=$_;
            }
            if(-s "hit_embeded"){
	       ($chr3,$feature3,$start3,$end3,$id3)=(split/[\t;]/,$res3)[0,2,3,4,8];
               $d3 = 0;
            }
            unlink("hit_embeded");
         my $case4 = "awk '{if((\$4<=$end)&&(\$4>$start)&&(\$5>=$end)){print \$0};}' bar_$chr.gff3|head -n 1 >hit_5overlap";
            system($case4);
            open (RES4, "<hit_5overlap") or die "$!";
            my $res4;
            while(<RES4>){
               chomp $_;
               $res4=$_;
            }
            if(-s "hit_5overlap"){
	       ($chr4,$feature4,$start4,$end4,$id4)=(split/[\t;]/,$res4)[0,2,3,4,8];
               $d4 = $end-$start4;
            }
            unlink("hit_5overlap");
         my $case5 = "awk '{if(\$4>$end){print \$0}}' bar_$chr.gff3|head -n 1 > hit_nonoverlap_upstream";
            system($case5);
            open (RES5, "< hit_nonoverlap_upstream") or die "$!";
            my $res5;
            while(<RES5>){
              chomp $_;
               $res5=$_;
            }
            if(-s "hit_nonoverlap_upstream"){
	       ($chr5,$feature5,$start5,$end5,$id5)=(split/[\t;]/,$res5)[0,2,3,4,8];
               $d5 = $start5-$end;
            }
            unlink("hit_nonoverlap_upstream");
            unlink("bar_$chr.gff3");
            if($d3==0){
               print OUT "$chr\t$feature\t$start\t$end\t$id\t$chr3\t$feature3\t$start3\t$end3\t$id3\t$d3\tembeded\n";
            }
            elsif((defined($d2)>defined($d4))&&(defined($d2)!=0)&&(defined($d4)!=0)||(defined $d2)&&(!(defined($d4)))){
               print OUT "$chr\t$feature\t$start\t$end\t$id\t$chr2\t$feature2\t$start2\t$end2\t$id2\t$d2\t3-overlapped\n";
            }
            elsif((defined($d4)>defined($d2))&&(defined($d2)!=0)&&(defined($d4)!=0)||(defined $d4) &&(!(defined($d2)))){
               print OUT "$chr\t$feature\t$start\t$end\t$id\t$chr4\t$feature4\t$start4\t$end4\t$id4\t$d4\t5-overlapped\n";
            }
            elsif($d1<$d5){
               print OUT "$chr\t$feature\t$start\t$end\t$id\t$chr1\t$feature1\t$start1\t$end1\t$id1\t$d1\tnonoverlap_downstream\n";
            }
            elsif($d5 < $d1){
              print OUT "$chr\t$feature\t$start\t$end\t$id\t$chr5\t$feature5\t$start5\t$end5\t$id5\t$d5\tnonoverlapped_upstream\n";
            }

}
 close TE;
 close OUT;
 close RES1;
 close RES2;
 close RES3;
 close RES4;
 close RES5;
