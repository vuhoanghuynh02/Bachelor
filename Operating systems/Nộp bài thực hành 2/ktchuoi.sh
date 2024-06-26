#!/bin/sh

subString=$1
folder=$2
resultFile=$3

if [ "$subString" = "" ] || [ "$folder" = "" ] || [ "$resultFile" = "" ]; then
    echo "Khong du tham so."
    exit 1
fi

if [ ! -d "./${folder}" ]; then
    echo "Thu muc ${folder} khong ton tai" > "./${resultFile}"
    exit 0
fi

count=0
for name in "./${folder}/"*
do
    if [ -f "$name" ]; then
        case "$name" in
        "./${folder}/"*${subString}*)
            count=$(($count + 1))
            ;;
        esac
    fi  
done

if [ $count = 0 ]; then
    echo "Trong thu muc ${folder} khong co tap tin nao chua chuoi ${subString}" > "./${resultFile}"
else
    echo "Trong thu muc ${folder} co $count tap tin chua chuoi ${subString}" > "./${resultFile}"
fi

exit 0