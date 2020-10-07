#!/bin/bash

## only include the last 8bp for demutiplex.
## remove the i5 and last 2bp of i7 part 

if [ $# -lt 3 ];then
    echo "Need 3 parameters! r1 r2  index.fa "
    exit
fi

r1=$1
r2=$2
index=$3

python modify_fq.py -r1 ${r2} -o ${r2}.trim_2bp.fq 

# e 0.15 for the 8 bp, which allow 1 bp mismatch
cutadapt -e 0.15 --no-indels -a file:${index} \
-o {name}_L001_R2_001.fq.gz \
-p {name}_L001_R1_001.fq.gz \
${r2}.trim_2bp.fq ${r1} > ${r2}_demutiplex_log 

rm -f  ${r2}.trim_2bp.fq
