#!/bin/bash

# Build the bootloader.
docker build --force-rm=true --rm=true --tag="cubox-uboot" third_party/u-boot
mkdir -p build/
docker create --name="cubox-uboot-src" cubox-uboot
docker cp cubox-uboot-src:/root/u-boot/u-boot.img build/
docker cp cubox-uboot-src:/root/u-boot/SPL build/
docker rm cubox-uboot-src

# Flashing commands.
# sudo dd if=build/SPL of=/dev/disk2 bs=1k seek=1
# sudo dd if=build/u-boot.img of=/dev/disk2 bs=1k seek=42
