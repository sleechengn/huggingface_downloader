import os
import sys
import huggingface_hub as hf

def download(id):
    split_part = id.split("/")
    root_path = "--".join(split_part)
    if not os.path.exists(root_path):
        os.makedirs(root_path)
    if len(sys.argv)>2 :
        file = sys.argv[2]
        url = f"https://huggingface.co/{id}/resolve/main/{file}?download=true"
        file_path = f"{root_path}/{file}"
        aria2_filepath = f"{file_path}.aria2"
        if os.path.exists(aria2_filepath):
            os.remove(aria2_filepath)
            os.remove(file_path)
            os.system(f"aria2c -x 10 -j 10 \"{url}\" -o \"{file_path}\"")
        elif not os.path.exists(file_path):
            print(f"download {url} to {file_path}")
            os.system(f"aria2c -x 10 -j 10 \"{url}\" -o \"{file_path}\"")
        else:
            print(f"exists {file_path}")
    else:
        list = hf.list_repo_files(repo_id=id)
        for file in list:
            url = f"https://huggingface.co/{id}/resolve/main/{file}?download=true"
            url = url.replace(" ","%20")
            file_path = f"{root_path}/{file}"
            aria2_filepath = f"{file_path}.aria2"
            if os.path.exists(aria2_filepath):
                os.remove(aria2_filepath)
                os.remove(file_path)
                os.system(f"aria2c -x 10 -j 10 \"{url}\" -o \"{file_path}\"")
            elif not os.path.exists(file_path):
                print(f"download {url} to {file_path}")
                os.system(f"aria2c -x 10 -j 10 \"{url}\" -o \"{file_path}\"")
            else:
                print(f"exists {file_path}")
        hf.snapshot_download(repo_id=id,local_dir=root_path)

def main():
    if len(sys.argv) > 1 :
        download(sys.argv[1])
    else:
        print(f"command:\n<hf_id> [optional filename]")

if __name__ == "__main__":
    main()