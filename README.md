# acceleration_firmware_kr260

| Board | Picture | Description |
|------------|-------|-------------|
| [Kria KR260 Robotics Starter Kit](https://www.xilinx.com/products/som/kria/kr260-robotics-starter-kit.html) | ![](https://www.xilinx.com/content/dam/xilinx/imgs/products/som/kr260-angel-1.png) | The Kria™ KR260 is built for robotics and industrial applications, complete with high performance interfaces and native ROS 2 support for ease of development by roboticists and software developers.  |


This repository provides AMD/Xilinx's firmware artifacts for the KR260 board using Ubuntu 22.04 meant to accelerate ROS 2 robotic applications.

<ins>**NOTE on Ubuntu 22.04 integration**</ins>: *Ubuntu 22.04 sysroot is provided by Canonical and AMD at their own terms as available at https://ubuntu.com/download/amd-xilinx. Refer to this resource for more information. This repository leverages the resulting artifacts "as they are" and enables ROS 2 build flows while integrating hardware acceleration through Vitis and Vivado tools.*. 

## Use this ROS 2 package

### Fetch from sources
To fetch it from sources, proceed as follows to include the Ubuntu 22.04 resources:

```bash
git clone https://github.com/ros-acceleration/acceleration_firmware_kr260
wget https://people.canonical.com/~platform/images/xilinx/kria-ubuntu-22.04/iot-limerick-kria-classic-desktop-2204-x06-20220614-78-sysroot.tar.xz -P acceleration_firmware_kr260/firmware/  # will take a few seconds
```

### Fetch using VCS
When leveraging `vcs`, just use one of the official release links, which should include the Ubuntu 22.04 resources. E.g. include the following in your `.repos` file:

```bash
repositories:
  firmware/acceleration_firmware_kr260:
    type: zip
    url: https://github.com/ros-acceleration/acceleration_firmware_kr260/releases/download/v1.0.0/acceleration_firmware_kr260.zip
```

## Hardware Acceleration capabilities

According to [REP-2008's proposal](https://github.com/ros-infrastructure/rep/pull/324).

| Capability | KRS `alpha`[^1] | KRS `beta`[^2] | KRS `1.0`[^3] (*Ubuntu 22.04*) |
|------------|-------------|------------|-------------|
| **`1.` Kernel Levels** |  |  |   |
| [`1.i` level I kernels](https://ros.org/reps/rep-2008.html#i) | ✓ | ✓ | ✓ |
| [`1.ii` level II kernels](https://ros.org/reps/rep-2008.html#ii) | :warning: (see [this](https://github.com/Lien182/ReconROS)) | ✓ ([`acceleration_examples` (graph acceleration)](https://github.com/ros-acceleration/acceleration_examples/tree/main/graphs/perception/perception_2nodes), [`ReconROS`](https://github.com/Lien182/ReconROS)) | ✓ ([`acceleration_examples` (graph acceleration)](https://github.com/ros-acceleration/acceleration_examples/tree/main/graphs), [`ReconROS`](https://github.com/Lien182/ReconROS)) |
| [`1.iii` level III kernels](https://ros.org/reps/rep-2008.html#iii) |  |  |  |
| **`2.` Build System** | | | |
| [`2.i` ament extensions](https://ros.org/reps/rep-2008.html#id13) | ✓ | ✓ | ✓ |
| [`2.ii` `ament_acceleration` support](https://ros.org/reps/rep-2008.html#id14) | | ✓ | ✓ |
| **`3`. Build Tools** | | | |
| [`3.i` hardware emulation (`hw_emu`) ](https://ros.org/reps/rep-2008.html#id15) |  |  |  |
| [`3.ii` hardware emulation (`sw_emu`)](https://ros.org/reps/rep-2008.html#id16) | :warning: |  |  |
| [`3.iii` image tooling](https://ros.org/reps/rep-2008.html#id17) | ✓ | ✓ |  |
| [`3.iv` Linux kernel ](https://ros.org/reps/rep-2008.html#iv) | ✓ | ✓ | ✓ |
| [`3.iv.a` modern Linux kernel](https://ros.org/reps/rep-2008.html#iv-a) | ✓ | ✓ | ✓ |
| [`3.iv.b` LTS Linux kernel](https://ros.org/reps/rep-2008.html#iv-b) | | ✓ | ✓ |
| [`3.v` hypervisor ](https://ros.org/reps/rep-2008.html#v) | ✓ |  |  |
| [`3.v.a` no control domain VMs](https://ros.org/reps/rep-2008.html#v-a) | ✓ |  |  |
| [`3.v.b` guest VMs in disk](https://ros.org/reps/rep-2008.html#v-b) | ✓ |  |  |
| [`3.v.c` control domain in disk](https://ros.org/reps/rep-2008.html#v-c) | ✓  |  |  |
| [`3.v.d` no control domain VMs in disk](https://ros.org/reps/rep-2008.html#v-d) | | | |
| [`3.vi` network booting ](https://ros.org/reps/rep-2008.html#vi) | |  |  |
| [`3.vi.a` boot artifacts ](https://ros.org/reps/rep-2008.html#vi-a) | |  |  |
| [`3.vi.b` rootfs ](https://ros.org/reps/rep-2008.html#vi-b) | |  |  |
| [`3.vi.c` multi-network boot](https://ros.org/reps/rep-2008.html#vi-c) | |  |  |
| [`3.vi.d` secure network booting](https://ros.org/reps/rep-2008.html#vi-d) | |  |  |
| [`3.vi.e` save in disk network boot](https://ros.org/reps/rep-2008.html#vi-e) | |  |  |
| **`4.` Benchmarking** | | | |
| [`4.i` kernel benchmarking](https://ros.org/reps/rep-2008.html#id18) | ✓ | ✓ | ✓ |
| [`4.ii` ROS 2 acceleration benchmarking](https://ros.org/reps/rep-2008.html#id19) | | ✓ | ✓ |
| **`5.` Documentation** | |  |  |
| [`5.i` in-code documentation](https://ros.org/reps/rep-2008.html#id20) | ✓ | ✓ | ✓ |
| **`6.` Testing and CI** | |  |  |
| [`6.i` `acceleration_examples` ](https://ros.org/reps/rep-2008.html#id21) | ✓ | ✓ | ✓ |


[^1]: Aligns with Vitis 2020.2 release.
[^2]: Aligns with Vitis 2021.2 release.
[^3]: Aligns with Vitis 2022.1 release.

### Quality Declaration

No quality is claimed according to [REP-2004](https://www.ros.org/reps/rep-2004.html). This package should only be used in workstations to produced valid firmware for the targeted hardware.

