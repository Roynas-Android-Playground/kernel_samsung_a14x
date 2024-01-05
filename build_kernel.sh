#!/bin/bash
set -e

[ ! -e "toolchain" ] && echo "Make toolchain avaliable at $(pwd)/toolchain" && exit

export KBUILD_BUILD_USER=Royna
export KBUILD_BUILD_HOST=GrassLand
export DEPMOD=depmod
export PLATFORM_VERSION=14
export DTC_FLAGS="-@"

PATH=$PWD/toolchain/bin:$PATH
COMMON_FLAGS="O=out ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- LLVM=1 -j$(nproc)"
rm -rf out

make $COMMON_FLAGS exynos850-a14nsxx_defconfig
cp out/.config arch/arm64/configs/exynos850-a14nsxx_defconfig
make O=out $COMMON_FLAGS
