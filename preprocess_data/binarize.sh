fairseq-preprocess \
  --source-lang "source" \
  --target-lang "target" \
  --trainpref "raw/train.bpe" \
  --destdir "raw-bin/" \
  --workers 60 \
  --srcdict dict.txt \
  --tgtdict dict.txt;
