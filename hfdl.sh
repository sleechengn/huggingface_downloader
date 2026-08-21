#!/usr/bin/env bash

WORK_PATH=$(realpath $(pwd))
SCRIPT_PATH=$(realpath $(dirname $0))

if ! command -v aria2c > /dev/null 2>&1; then
    if command -v apt > /dev/null 2>&1; then
        apt install -y aria2
    fi
fi

if [ -e "$WORK_PATH/python/bin/activate" ]; then
    . $WORK_PATH/python/bin/activate
    HF_ENDPOINT=${HF_ENDPOINT:-https://hf-mirror.com} python $SCRIPT_PATH/hf_downloader.py $*
fi