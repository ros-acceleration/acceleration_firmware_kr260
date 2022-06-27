# Copyright (c) 2022, Acceleration Robotics
# Author: Víctor Mayoral Vilches <victor@accelerationrobotics.com>
#
# Deploy Ubuntu sysroot

message(STATUS "Deploying sysroot")
set(TARGET_SYSROOT_DIR ${FIRMWARE_DIR}/sysroots/aarch64-xilinx-linux)

# extract sysroot and scripts
run("${TESTFIRMWARE} tar -xf ${FIRMWARE_DIR}/iot-limerick-kria-classic-desktop-2204-x04-20220517-68-sysroot.tar.xz -C ${FIRMWARE_DIR}")

message(STATUS "Ubuntu sysroot deployed.")
