#!/usr/bin/env bash

WORK_PATH=$(realpath $(pwd))
SCRIPT_PATH=$(realpath $(dirname $0))
echo "WORK      PATH:$WORK_PATH"
echo "SCRIPT    PATH:$SCRIPT_PATH"
if ! command -v aria2c > /dev/null 2>&1; then
    if command -v apt > /dev/null 2>&1; then
        apt install -y aria2
    fi
fi

if [ -e "$WORK_PATH/python/bin/activate" ]; then
    . $WORK_PATH/python/bin/activate
    HF_ENDPOINT=${HF_ENDPOINT:-https://hf-mirror.com} python $SCRIPT_PATH/hf_downloader.py $*
else
    if [ ! -e "$WORK_PATH/uv-x86_64-unknown-linux-gnu/uv" ]; then
        DOWNLOAD=$(curl -s https://api.github.com/repos/astral-sh/uv/releases/latest | grep browser_download_url |grep linux|grep x86_64|grep gnu|grep -v sha256| cut -d'"' -f4)
	    aria2c -x 10 -j 10 -k 1M "$DOWNLOAD" -o "${WORK_PATH}/uv.tar.gz"
        tar -zxvf ${WORK_PATH}/uv.tar.gz
        rm -rf ${WORK_PATH}/uv.tar.gz
        chmod +x ${WORK_PATH}/uv-x86_64-unknown-linux-gnu/uv
        ${WORK_PATH}/uv-x86_64-unknown-linux-gnu/uv venv --python 3.14 ${WORK_PATH}/python
        . $WORK_PATH/python/bin/activate
        ${WORK_PATH}/uv-x86_64-unknown-linux-gnu/uv pip install pip
        python -m pip install huggingface_hub
        HF_ENDPOINT=${HF_ENDPOINT:-https://hf-mirror.com} python $SCRIPT_PATH/hf_downloader.py $*
    else
        ${WORK_PATH}/uv-x86_64-unknown-linux-gnu/uv venv --python 3.14 ${WORK_PATH}/python
        . $WORK_PATH/python/bin/activate
        ${WORK_PATH}/uv-x86_64-unknown-linux-gnu/uv pip install pip
        python -m pip install huggingface_hub
        HF_ENDPOINT=${HF_ENDPOINT:-https://hf-mirror.com} python $SCRIPT_PATH/hf_downloader.py $*
    fi

fi