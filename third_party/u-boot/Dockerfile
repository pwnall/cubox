FROM ubuntu:14.10

# This follows the steps in the Wiki page below:
# http://www.solid-run.com/wiki/Building_the_kernel_and_u-boot_for_the_CuBox-i_and_the_HummingBoard

RUN sudo apt-get update && sudo apt-get -y dist-upgrade
RUN sudo apt-get -y install build-essential
RUN sudo apt-get -y install gcc-arm-linux-gnueabihf u-boot-tools lzop
ENV ARCH arm
ENV CROSS_COMPILE /usr/bin/arm-linux-gnueabihf-
RUN sudo mkdir -p /root/u-boot
COPY src /root/u-boot
WORKDIR /root/u-boot
RUN make mx6_cubox-i_config && make
