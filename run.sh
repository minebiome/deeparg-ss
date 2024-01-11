deeparg predict \
    --model LS \
    -i ./test/ORFs.fa \
    -o ./test/X \
    -d /path/to/data/ \
    --type nucl \
    --min-prob 0.8 \
    --arg-alignment-identity 30 \
    --arg-alignment-evalue 1e-10 \
    --arg-num-alignments-per-entry 1000



trimmomatic PE -phred33  \
  ./test/F.fq.gz \
  ./test/R.fq.gz \
  ./test/F.fq.gz.paired \
  ./test/F.fq.gz.unpaired \
  ./test/R.fq.gz.paired \
  ./test/R.fq.gz.unpaired \
  LEADING:3 \
  TRAILING:3 \
  SLIDINGWINDOW:4:15 \
  MINLEN:36


vsearch --fastq_mergepairs  ./test/F.fq.gz.paired \
  --reverse  ./test/R.fq.gz.paired \
  --fastaout  ./test/F.fq.gz.paired.merged \
  --fastaout_notmerged_fwd \
  ./test/F.fq.gz.paired.unmerged \
  --fastaout_notmerged_rev \
  ./test/R.fq.gz.paired.unmerged

cat  ./test/F.fq.gz.paired.merged ./test/F.fq.gz.paired.unmerged ./test/R.fq.gz.paired.unmerged > ./output/test.clean

deeparg predict \
  --type nucl \
  --model SS \
  -d ./db \
  -i ./output/test.clean \
  -o ./output/test.clean.deeparg \
  --arg-alignment-identity 80 \
  --min-prob 0.8 \
  --arg-alignment-evalue 1e-10


sort -k1,1 -k2,2n ./output/test.clean.deeparg.mapping.ARG  | bedtools merge -c 12,5 -o sum,distinct >./output/test.clean.deeparg.mapping.ARG.merged


