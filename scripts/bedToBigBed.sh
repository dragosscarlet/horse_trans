#!/bin/sh

if [ $# -lt 2 ]
then
printf "\nUsage bedToBigBed.sh [BED file] [genome chrom sizes]\n"
exit 0
fi

targetAss="$1"
chrom_sizes="$2"


module load ucscUtils/262   # UCSC_kent_commands
n=$(ls $targetAss | wc -l)
if [ -f $targetAss ]; then
  filename=${targetAss%.bed}
  tail -n +2 $targetAss | sort -k1,1 -k2,2n > ${filename}_sorted.bed
  bedToBigBed ${filename}_sorted.bed $chrom_sizes ${filename}.BigBed
else
  printf "\nNo The target GFF was not found"; exit 0;
fi