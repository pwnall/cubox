#!/bin/bash
#
# Build the U-boot bootloader.

docker build --force-rm=true --rm=true --tag="cubox-uboot" third_party/u-boot
mkdir -p build/
docker create --name="cubox-uboot-src" cubox-uboot
docker cp cubox-uboot-src:/root/u-boot/u-boot.img build/
docker cp cubox-uboot-src:/root/u-boot/SPL build/
docker rm cubox-uboot-src
