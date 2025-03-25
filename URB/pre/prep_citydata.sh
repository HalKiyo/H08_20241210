#!/bin/bash
###########################################################
#to   restore original filenames from temporal filenames
#by   2024/12/10, kajiyama, modified by hanasaki
###########################################################
#  Setting (Edit here)
###########################################################
converted_extension="=bk5"
original_extension=".bk5"
###########################################################
#  Input (Edit here according to your H08 direcotory path)
###########################################################
DIRPWD=`pwd`
DIRH08="/mnt/d/work/H08_20241210/"
DIRORG="/mnt/d/work/H08_20241210/URB/org/gdrive20241205/bangkok/"
###########################################################
#  Job (restore files)
###########################################################
cd "$DIRORG"

for file in $(find . -name "*${converted_extension}"); do

    file=$(echo "$file"     | sed "s|^.\/||")
    new_file=$(echo "$file" | sed 's/-/\//g')
    save_file=${DIRH08}${new_file}

    # 保存先directoryを取得
    save_dir=$(dirname "$save_file")
    
    # directoryが存在しない場合は作成
    if [ ! -d "$save_dir" ]; then
        echo "Creating directory: $save_dir"
        mkdir -p "$save_dir"
    fi

    # ファイルをリネームして移動
    mv "${DIRORG}${file}" "${save_file//$converted_extension/$original_extension}"
done

for filepath in $(find "$DIRH08" -type f -name "*${original_extension}"); do
    filename="$(basename "$filepath")"
    
    # Determine new filename based on prefix
    if [[ "$filename" == city_* ]]; then
        # Files with special prefixes -> rename to GPW_____00000000 + converted extension
        newname="GPW_____00000000${original_extension}"
        mv "$filepath" "$(dirname "$filepath")/$newname"
        echo "Renaming $(dirname "$filepath")/$filename to $newname"
        # Update filepath to point to the renamed file for further processing
    fi

done

cd "$DIRPWD"
