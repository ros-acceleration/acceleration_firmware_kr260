# Copyright (c) 2022, Acceleration Robotics
# Author: Víctor Mayoral Vilches <victor@accelerationrobotics.com>
#
# Deploy Ubuntu sysroot

message(STATUS "Deploying sysroot")
set(TARGET_SYSROOT_DIR ${FIRMWARE_DIR}/sysroots/aarch64-xilinx-linux)
set(SYSROOTNAME "iot-limerick-kria-classic-desktop-2204-x06-20220614-78-sysroot.tar.xz")

# extract sysroot and scripts
run("${TESTFIRMWARE} tar -xf ${FIRMWARE_DIR}/${SYSROOTNAME} -C ${FIRMWARE_DIR}")

message(STATUS "Ubuntu sysroot deployed.")
