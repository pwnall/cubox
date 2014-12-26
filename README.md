# Cubox

This repository contains scripts for building an image for the
[SolidRun CuBox-i](http://www.solid-run.com/products/cubox-i-mini-computer/).

The repository imports
[SolidRun's forked repositories](https://github.com/SolidRun/) as submodules,
and distills the information in the
[SolidRun Wiki](http://www.solid-run.com/wiki/Main_Page) into executable
scripts. This approach is intended to help reduce the interation time for
building a bootable image for the CuBox-i.


## Prerequisites

The builds are done using [Docker](https://www.docker.com/). On Mac OS X,
[boot2docker](http://boot2docker.io/) is an easy way to get a Docker daemon.

The image building step uses [GNU mtools](http://www.gnu.org/software/mtools/),
which can be installed on Mac OS X using Homebrew.

```bash
brew install mtools
```

The image building step also requires the
[U-boot](http://www.denx.de/wiki/U-Boot) tools, which can also be installed
using Homebrew on Mac OS X.

```bash
brew install uboot-tools
```


## Setup

On Mac OS X, you must create a case-sensitive disk image and do all the work
inside the image. The commands below are borrowed from the
[Android build setup page](https://source.android.com/source/initializing.html#creating-a-case-sensitive-disk-image).

```bash
# One-time setup.
hdiutil create -type SPARSE -fs 'Case-sensitive Journaled HFS+' -size 8g ~/cubox.dmg

# These steps must be run on every boot, or after unmounting the image.
hdiutil attach ~/cubox.dmg -mountpoint /Volumes/cubox
cd /Volumes/cubox
```

The repository has submodules.

```bash
git clone git@github.com:pwnall/cubox.git
cd cubox
git submodule init
git submodule update
```


## Building and Deploying

```bash
./script/build_uboot.sh
./script/build_kernel.sh
./script/build_image.sh
```

The resulting image is in `build/cubox.raw`, and can be `dd`-ed to an SD card.
For example, the following commands move the image the an Android system, and
use its SD card reader to write the image to a card.

```bash
# Host command.
adb push build/cubox.raw /sdcard/Download/

# Android command.
dd bs=1048576 if=/sdcard/Download/cubox.raw \
    of=/dev/block/vold/179\:8 \
    conv=notrunc,fdatasync
```
