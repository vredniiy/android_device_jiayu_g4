#!/bin/sh
cd ../../..
export TARGET_PRODUCT=full_g4
make -j16 recoveryimage
rm -r out/target/product/g4/recovery/root
mkdir out/target/product/g4/recovery/root
cp out/target/product/g4/ramdisk-recovery.cpio out/target/product/g4/recovery/root/ramdisk-recovery.cpio
cd out/target/product/g4/recovery/root
cpio -i -F ramdisk-recovery.cpio
rm ramdisk-recovery.cpio
cd ../../../../../../
./device/jiayu/g4/repack-MT65xx.pl -recovery device/jiayu/g4/kernel out/target/product/g4/recovery/root/ out/target/product/g4/recovery.img
