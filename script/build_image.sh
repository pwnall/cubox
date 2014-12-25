#!/bin/bash
#
# Build the image file.

# 1 sector = 512 bytes
FAT_SECTORS=32768
# size in bytes
IMAGE_SIZE=50331648

# Create the disk image.
mkdir -p build
rm -f build/cubox.raw
dd of=build/cubox.raw bs=1 seek=$IMAGE_SIZE count=0

# Create the partition table and a FAT filesystem.
# This makes it easy to edit the bootloader parameters on any system.
echo "drive x: file=\"$PWD/build/cubox.raw\" blocksize=512 fat_bits=16 partition=1" > \
    build/mtoolsrc
MTOOLSRC=build/mtoolsrc mpartition -I -s 63 -h 255 x:
MTOOLSRC=build/mtoolsrc mpartition -c -s 63 -h 255 -b 2048 -l $FAT_SECTORS \
    -f x:
MTOOLS_SKIP_CHECK=1 MTOOLSRC=build/mtoolsrc mformat -h 255 -s 63 -N 12345678 \
    -T $FAT_SECTORS -I 0 -v uboot x:

# Write an initial bootloader configuration.
MTOOLS_SKIP_CHECK=1 MTOOLSRC=build/mtoolsrc mmd x:boot
MTOOLS_SKIP_CHECK=1 MTOOLSRC=build/mtoolsrc mcopy boot/uEnv.txt x:uEnv.txt

# Write the bootloader (SPL+U-boot) to the image.
dd if=build/SPL of=build/cubox.raw bs=1024 seek=1 conv=notrunc
dd if=build/u-boot.img of=build/cubox.raw bs=1024 seek=42 conv=notrunc
