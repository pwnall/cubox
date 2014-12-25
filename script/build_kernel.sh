#!/bin/bash
#
# Build the Linux kernel.

docker build --force-rm=true --rm=true --tag="cubox-kernel" third_party/kernel
mkdir -p build/boot
docker create --name="cubox-kernel-src" cubox-kernel
docker cp cubox-kernel-src:/root/kernel/arch/arm/boot/zImage build/boot
docker cp cubox-kernel-src:/root/kernel/arch/arm/boot/dts/imx6dl-cubox-i.dtb \
    build/boot
docker cp cubox-kernel-src:/root/kernel/arch/arm/boot/dts/imx6q-cubox-i.dtb \
    build/boot
docker cp \
    cubox-kernel-src:/root/kernel/arch/arm/boot/dts/imx6dl-hummingboard.dtb \
    build/boot
docker cp \
    cubox-kernel-src:/root/kernel/arch/arm/boot/dts/imx6q-hummingboard.dtb \
    build/boot
docker cp cubox-kernel-src:/root/kernel-modules/lib/firmware build/lib
docker cp cubox-kernel-src:/root/kernel-modules/lib/modules build/lib

docker rm cubox-kernel-src
