import os
import sys

def download(url:str):
    print(f"download: {url}")
    main_url = url.split("?")[0]
    if main_url.endswith("/"):
        print(f"the main_url has not contain filename")
        if len(sys.argv) > 2:
            file_name = sys.argv[2]
            os.system(f"aria2c -x 10 -j 10 -k 1M \"{url}\" -o \"{file_name}\"")
        else:
            print("please input out filepath:")
            file_name = input()
            os.system(f"aria2c -x 10 -j 10 -k 1M \"{url}\" -o \"{file_name}\"")
    else:
        if len(sys.argv) > 2:
            file_name = sys.argv[2]
            os.system(f"aria2c -x 10 -j 10 -k 1M \"{url}\" -o \"{file_name}\"")
        else:
            parts = main_url.split("/")
            main_name = parts[len(parts)-1]
            print(f"use default name {main_name}")
            file_name = main_name
            os.system(f"aria2c -x 10 -j 10 -k 1M \"{url}\" -o \"{file_name}\"")


def main():
    if len(sys.argv) > 1 :
        download(sys.argv[1])
    else:
        print(f"command:\n<url> [optional filename]")

if __name__ == "__main__":
    main()