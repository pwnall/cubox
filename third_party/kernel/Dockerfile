FROM ubuntu:14.10

# This follows the steps in the Wiki page below:
# http://www.solid-run.com/wiki/Building_the_kernel_and_u-boot_for_the_CuBox-i_and_the_HummingBoard

RUN sudo apt-get update && sudo apt-get -y dist-upgrade
RUN sudo apt-get -y install build-essential bc
RUN sudo apt-get -y install gcc-arm-linux-gnueabihf u-boot-tools lzop
ENV ARCH arm
ENV CROSS_COMPILE /usr/bin/arm-linux-gnueabihf-
RUN mkdir -p /root/kernel && mkdir -p /root/kernel-modules
COPY src /root/kernel
WORKDIR /root/kernel
RUN make imx_v7_cbi_hb_defconfig && make zImage && \
    make imx6q-cubox-i.dtb imx6dl-cubox-i.dtb && \
    make imx6dl-hummingboard.dtb imx6q-hummingboard.dtb && \
    make modules && \
    make modules_install INSTALL_MOD_PATH=/root/kernel-modules
