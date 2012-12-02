#!/bin/sh

UNAME=`uname`
if [ "$UNAME" = "Linux" ]; then
	size=$(stat -c%s "${T_OBJ}/kernel/kernel.bin")
elif [ "$UNAME" = "FreeBSD" ]; then
	size=$(stat -f %z "${T_OBJ}/kernel/kernel.bin")
else
	echo "Unsupported platform!"
	exit 1
fi

kern_sect_size=$(echo "(( $size + 511 ) / 512)" | bc)
mkdir -p ${T_OBJ}/bootloader/*
rm -f ${T_OBJ}/bootloader/*
echo $kern_sect_size > ${T_OBJ}/bootloader/kern-sect_size
