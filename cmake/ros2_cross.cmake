# Copyright (c) 2022, Acceleration Robotics
# Author: Víctor Mayoral Vilches <victor@accelerationrobotics.com>
#
# Install ROS 2 and related dependencies inside of the sysroot 
#  for simplified cross-compilation flows

message(STATUS "Preparing sysroot for ROS 2 cross-compilation")
set(CUSTOMIZESHSCRIPT ${FIRMWARE_DIR}/sysroots/bin/customize.sh)
set(PATCH ${FIRMWARE_DIR}/patches/customize.patch)
set(SYSROOTPATH ${FIRMWARE_DIR}/sysroots/aarch64-xilinx-linux)

# apply patch
run("${TESTFIRMWARE} patch ${CUSTOMIZESHSCRIPT} ${PATCH}")

# install ROS 2, LTTng and net-tools inside of the sysroot
run("${TESTFIRMWARE} sudo ${CUSTOMIZESHSCRIPT} ${SYSROOTPATH} jammy http://packages.ros.org/ros2/ubuntu '' net-tools > /dev/null")

message(STATUS "Sysroot cooked for cross-compilation.")
