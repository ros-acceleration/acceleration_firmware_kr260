# Copyright (c) 2022, Acceleration Robotics
# Author: Víctor Mayoral Vilches <victor@accelerationrobotics.com>
#

# message("Adding COLCON_IGNORE to firmware")  # debug
set(CMD "${TESTFIRMWARE} touch ${FIRMWARE_DIR}/COLCON_IGNORE")
execute_process(COMMAND bash -c ${CMD})
