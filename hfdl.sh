#!/usr/bin/env bash

if ! command -v aria2c > /dev/null 2>&1; then
    if command -v apt > /dev/null 2>&1; then
        apt install -y aria2
    fi
fi

if [ -e "$(dirname $0)/python/bin/activate" ]; then
    . $(dirname $0)/python/bin/activate
    HF_ENDPOINT=${HF_ENDPOINT:-https://hf-mirror.com} python $(dirname $0)/hf_downloader.py $*
fi