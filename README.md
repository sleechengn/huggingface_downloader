# huggingface_downloader

Huggingface model download tool, use aria2c method to download, you must install python and aria2, the installation method is to download from the aria2 website and add the path environment variable

install aria2

```sh
    apt install -y aria2
    apt install -y python3 python3-pip
    pip install huggingface_hub
```

Usage:

python downloader.py <huggingface_id> [file]

