#!/bin/bash

wget https://nginx.org/en/CHANGES-1.24

cat CHANGES-1.24 | grep Changes | cut -d ' ' -f4 > version

file_path="./version"
total_lines=$(wc -l < "$file_path")
for ((i=total_lines; i>=1; i--))
do
    line=$(head -n $i "$file_path" | tail -n 1)
    vfile="nginx-"${line}".tar.gz"
    url="https://nginx.org/download/"${vfile}
    echo $url
    wget $url
    tar -zxvf ${vfile} --strip-components 1 -C ./nginx-change-line
    mv ${vfile} nginx-tar
    cd ./nginx-change-line
    git add .
    git commit -m "${vfile}"
    cd ..
done
