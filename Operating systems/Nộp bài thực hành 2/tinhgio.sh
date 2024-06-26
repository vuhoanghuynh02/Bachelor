#!/bin/sh

gioBD=$1
phutBD=$2
phutLV=$3
resultFile=$4

if [ "$gioBD" = "" ] || [ "$phutBD" = "" ] || [ "$phutLV" = "" ] || [ "$resultFile" = "" ]; then
    echo "Khong du tham so."
    exit 1
fi

if [ "$gioBD" -ge 24 ]; then
    echo "Gio khong hop le"
    exit 0
fi

if [ "$phutBD" -ge 60 ]; then
    echo "Phut khong hop le"
    exit 0
fi

if [ "$phutLV" -gt 480 ]; then
    echo "Thoi gian lam viec khong hop le"
    exit 0
fi

phutKT=$(($phutBD + $phutLV))
gioKT=$(($gioBD + $phutKT / 60))
phutKT=$(($phutKT - $phutKT / 60 * 60))
gioKT=$(($gioKT - $gioKT / 24 * 24))

echo "${gioKT} ${phutKT}" > "./${resultFile}"

exit 0