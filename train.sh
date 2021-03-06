TOTAL_NUM_UPDATES=10000
#was 10000
WARMUP_UPDATES=500      
LR=3e-05
MAX_TOKENS=256
#MAX_TOKENS was 1024 but had to decrease it because of memory limitations
UPDATE_FREQ=32
#UPDATE_FREQ was but had to increase it because of memory limitations
BART_PATH=bart.large/model.pt

CUDA_VISIBLE_DEVICES=0,1,2,3,4,5 fairseq-train preprocess_data/raw-bin \
    --restore-file $BART_PATH \
    --max-tokens $MAX_TOKENS \
    --task translation \
    --source-lang source --target-lang target \
    --truncate-source \
    --layernorm-embedding \
    --share-all-embeddings \
    --share-decoder-input-output-embed \
    --reset-optimizer --reset-dataloader --reset-meters \
    --required-batch-size-multiple 1 \
    --arch bart_large \
    --criterion label_smoothed_cross_entropy \
    --label-smoothing 0.1 \
    --dropout 0.1 --attention-dropout 0.1 \
    --weight-decay 0.01 --optimizer adam --adam-betas "(0.9, 0.999)" --adam-eps 1e-08 \
    --clip-norm 0.1 \
    --lr-scheduler polynomial_decay --lr $LR --total-num-update $TOTAL_NUM_UPDATES --warmup-updates $WARMUP_UPDATES \
    --fp16 --memory-efficient-fp16 --update-freq $UPDATE_FREQ \
    --skip-invalid-size-inputs-valid-test \
    --find-unused-parameters \
    --ddp-backend=no_c10d \
    --disable-validation \
    --valid-subset train \
    --log-format simple --no-epoch-checkpoints
