#!/bin/bash

if [ $# -lt 3 ];then
    echo "Need 3 parameters! r1 r2  index.fa "
    exit
fi

r1=$1
r2=$2
index=$3

python modify_fq.py -r1 ${r2} -o ${r2}.trimed.fq 

# e 0.15 for the 8 bp index, which allow 1 bp mismatch
cutadapt  -e 0.15 --no-indels -a file:${index} \
-o {name}_L001_R2_001.fq.gz \
-p {name}_L001_R1_001.fq.gz \
${r2}.trimed.fq ${r1} > ${r2}_demutiplex_log 

rm -f  ${r2}.trimed.fq
