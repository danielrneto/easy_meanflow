#!/bin/bash

# export PYTORCH_ENABLE_FUNC_IMPL=1 && \
# export PYTORCH_DDP_NO_REBUILD_BUCKETS=1 && \
# export TORCH_NCCL_IB_TIMEOUT=23 && \
# export NCCL_TIMEOUT=3600 && \
# export SETUPTOOLS_USE_DISTUTILS=local && \
# export CUDA_VISIBLE_DEVICES=0 && \

# torchrun --standalone --nproc_per_node=6 train_mf.py \
#     --detach_tgt=1 \
#     --outdir=logs/mf/MF00 \
#     --data=./data/cifar10-32x32.zip \
#     --cond=0 --arch=ddpmpp --lr 1e-3 --batch 384 \
    # --resume /home/william/easy_meanflow/logs/mf/MF00/00002-cifar10-32x32-uncond-ddpmpp-mf-gpus4-batch256-fp32/training-state-200000.pt \

python train_mf.py \
    --detach_tgt=1 \
    --outdir=logs/mf/MF00 \
    --data=./data/cifar10-32x32.zip \
    --cond=0 --arch=ddpmpp --lr 1e-3 --batch 16 \
    --fp16 true --duration 10 --tick 1 \
    --snap 1 --dump 5 
