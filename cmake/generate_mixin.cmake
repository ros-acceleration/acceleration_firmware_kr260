# Copyright (c) 2022, Acceleration Robotics
# Author: Víctor Mayoral Vilches <victor@accelerationrobotics.com>
#
# generate and add mixins at build-time to further simplify embedded flows
#
# NOTE: this logic is specific to KR260

message(STATUS "Creating mixins for the overlay ROS 2 workspace")

set(TEMPLATE_MIXIN "${CMAKE_BINARY_DIR}/kr260.mixin.template")
set(TEMPLATE_YAML "${CMAKE_BINARY_DIR}/index.yaml.template")
set(MIXIN_DIR "${FIRMWARE_DIR}/mixin")
set(MIXIN "${MIXIN_DIR}/kr260.mixin")
set(INDEX_YAML "${MIXIN_DIR}/index.yaml")

# arguments
# - ARG1_*: firmware directory, resulting toolchain should be here
# - ARG2_*: vitis directory, refer to "xilinx_vitis" package for details
# - ARG3_*: root of the install directory
set(ARG1_FIRMWARE_DIR ${FIRMWARE_DIR})

if(DEFINED ENV{XILINX_VITIS})
    set(ARG2_VITIS_DIR $ENV{XILINX_VITIS})
else()  # assume using "xilinx_vitis" package
  set(ARG2_VITIS_DIR ${FIRMWARE_DIR}/../vitis)
endif()

set(ARG3_INSTALL_DIR ${CMAKE_INSTALL_PREFIX})
message(STATUS "ARG1_FIRMWARE_DIR: " ${ARG1_FIRMWARE_DIR})
message(STATUS "ARG2_VITIS_DIR: " ${ARG2_VITIS_DIR})
message(STATUS "ARG3_INSTALL_DIR: " ${ARG3_INSTALL_DIR})

# deploy in firmware
run("${TESTFIRMWARE} mkdir -p ${MIXIN_DIR}")
run("${TESTFIRMWARE} mv ${TEMPLATE_MIXIN} ${MIXIN}")
run("${TESTFIRMWARE} mv ${TEMPLATE_YAML} ${INDEX_YAML}")
# replace placeholders
set(SEDEXP_ARG1 "s:ARG1_FIRMWARE_DIR:${ARG1_FIRMWARE_DIR}:g")
set(SEDEXP_ARG2 "s:ARG2_VITIS_DIR:${ARG2_VITIS_DIR}:g")
set(SEDEXP_ARG3 "s:ARG3_INSTALL_DIR:${ARG3_INSTALL_DIR}:g")
run("${TESTFIRMWARE} sed -i ${SEDEXP_ARG1} ${MIXIN}")
run("${TESTFIRMWARE} sed -i ${SEDEXP_ARG2} ${MIXIN}")
run("${TESTFIRMWARE} sed -i ${SEDEXP_ARG3} ${MIXIN}")

# enable mixins
set(REDIRECT_STDERR_STR "2> /dev/null")
run("${TESTFIRMWARE} colcon mixin remove kr260 2> /dev/null")  # clean up prior stuff
set(ADD_MIXIN_PATH "file://${FIRMWARE_DIR}/mixin/index.yaml")
run("${TESTFIRMWARE} colcon mixin add kr260 ${ADD_MIXIN_PATH}")
run("${TESTFIRMWARE} colcon mixin update kr260")
