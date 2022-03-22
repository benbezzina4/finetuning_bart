for LANG in source target
do
  python3 -m multiprocessing_bpe_encoder \
  --encoder-json encoder.json \
  --vocab-bpe vocab.bpe \
  --inputs "raw/train.$LANG" \
  --outputs "raw/train.bpe.$LANG" \
  --workers 60 \
  --keep-empty;
done
