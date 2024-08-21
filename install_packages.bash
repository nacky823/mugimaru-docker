#!/bin/bash -e
# SPDX-FileCopyrightText: 2024 nacky823 youjiyongmu4@gmail.com
# SPDX-License-Identifier: Apache-2.0

## Installation of Autoware Universe
mkdir -p $HOME/autoware_ws/src/{core/external,universe/external}

cd $HOME/autoware_ws/src/core
git clone -b main https://github.com/autowarefoundation/autoware.core.git
cd autoware.core
git checkout 99891401473b5740e640f5a0cc0412c0984b8e0b
git checkout -b mugimaru-2024/main
cd ..
git clone -b main https://github.com/autowarefoundation/autoware_adapi_msgs.git
cd autoware_adapi_msgs
git checkout ece03990f2285be372298e4bfec74a1f4ac3450e
git checkout -b mugimaru-2024/main
cd ..
git clone -b main https://github.com/autowarefoundation/autoware_common.git
cd autoware_common
git checkout 0f061427d3ae1f5b2e480e8fa0de85c48423d446
git checkout -b mugimaru-2024/main
cd ..
git clone -b main https://github.com/autowarefoundation/autoware_msgs.git
cd autoware_msgs
git checkout 62f341d97515c81236a9a6700f02ca4e8df02304
git checkout -b mugimaru-2024/main

cd $HOME/autoware_ws/src/core/external
git clone -b tier4/main https://github.com/tier4/autoware_auto_msgs.git
cd autoware_auto_msgs
git checkout 1e8b6d234e2690c9da386f006bb60835cdccddfd
git checkout -b mugimaru-2024/tier4/main

cd $HOME/autoware_ws/src/universe
git clone -b mugimaru-2024/main https://github.com/nacky823/autoware.universe.git

cd $HOME/autoware_ws/src/universe/external
git clone -b autoware-main https://github.com/MapIV/eagleye.git
cd eagleye
git checkout 30bae75dace6d9bfed0d67d51d6eec5928932509
git checkout -b mugimaru-2024/autoware-main
cd ..
git clone -b ros2 https://github.com/MapIV/llh_converter.git
cd llh_converter
git checkout 07ad112b4f6b83eccd3a5f777bbe40ff01c67382
git checkout -b mugimaru-2024/ros2
cd ..
git clone -b main https://github.com/MORAI-Autonomous/MORAI-ROS2_morai_msgs.git
mv MORAI-ROS2_morai_msgs morai_msgs && cd morai_msgs
git checkout 860aaadea5dcaabd5a2272c244eea51265363740
git checkout -b mugimaru-2024/main
cd ..
git clone -b tier4/main https://github.com/tier4/muSSP.git
cd muSSP
git checkout c79e98fd5e658f4f90c06d93472faa977bc873b9
git checkout -b mugimaru-2024/tier4/main
cd ..
git clone -b tier4/main https://github.com/tier4/ndt_omp.git
cd ndt_omp
git checkout 9a0877ac99cf873d9e984e4f1c485e537503fb7f
git checkout -b mugimaru-2024/tier4/main
cd ..
git clone -b tier4/main https://github.com/tier4/pointcloud_to_laserscan.git
cd pointcloud_to_laserscan
git checkout 948a4fca35dcb03c6c8fbfa610a686f7c919fe0b
git checkout -b mugimaru-2024/tier4/main
cd ..
git clone -b ros2-v0.1.0 https://github.com/MapIV/rtklib_ros_bridge.git
cd rtklib_ros_bridge
git checkout ef094407bba4f475a8032972e0c60cbb939b51b8
git checkout -b mugimaru-2024/ros2-v0.1.0
cd ..
git clone -b tier4/universe https://github.com/tier4/tier4_ad_api_adaptor.git
cd tier4_ad_api_adaptor
git checkout a58468edcdaf8698153c85e93fe23807edcb8187
git checkout -b mugimaru-2024/tier4/universe
cd ..
git clone -b tier4/universe https://github.com/tier4/tier4_autoware_msgs.git
cd tier4_autoware_msgs
git checkout e87d06563fba3f29e805140d61faef9badaefadd
git checkout -b mugimaru-2024/tier4/universe

cd $HOME/autoware_ws
rosdep update
sudo apt-get update
rosdep install -r -y --from-paths src --ignore-src --rosdistro humble
colcon build --symlink-install --packages-up-to \
    ekf_localizer \
    gyro_odometer \
    map_loader \
    ndt_scan_matcher \
    pointcloud_preprocessor \
    --cmake-args -DCMAKE_BUILD_TYPE=Release

## Installation of Raspicat-related
mkdir -p $HOME/raspicat_ws/src && cd $HOME/raspicat_ws/src
git clone -b ros2 https://github.com/rt-net/raspicat_ros.git
git clone -b mugimaru-2024/ros2 https://github.com/nacky823/raspicat_description.git
git clone -b ros2 https://github.com/rt-net/raspicat_sim.git
./raspicat_sim/raspicat_gazebo/scripts/download_gazebo_models.sh
cd $HOME/raspicat_ws
rosdep update
sudo apt-get update
rosdep install -r -y --from-paths src --ignore-src --rosdistro humble
colcon build --symlink-install

## Installation of Mugimaru-related
mkdir -p $HOME/mugimaru_ws/src && cd $HOME/mugimaru_ws/src
git clone -b mugimaru-2024/main https://github.com/nacky823/ros2_odometry_twist_converter.git
git clone -b master https://github.com/nacky823/mugimaru_navigation2.git
git clone -b master https://github.com/nacky823/mugimaru_launcher.git
cd $HOME/mugimaru_ws
rosdep update
sudo apt-get update
rosdep install -r -y --from-paths src --ignore-src --rosdistro humble
colcon build --symlink-install

## Installation of Livox driver
mkdir -p $HOME/livox_ws/src && cd $HOME/livox_ws/src
git clone -b feat/mugimaru-config https://github.com/CIT-Autonomous-Robot-Lab/livox_ros_driver2.git
cd $HOME/livox_ws
rosdep update
sudo apt-get update
rosdep install -r -y --from-paths src --ignore-src --rosdistro humble
cd $HOME/livox_ws/src/livox_ros_driver2 && ./build.sh humble

echo "source $HOME/autoware_ws/install/setup.bash" >> $HOME/.bashrc
echo "source $HOME/raspicat_ws/install/setup.bash" >> $HOME/.bashrc
echo "source $HOME/mugimaru_ws/install/setup.bash" >> $HOME/.bashrc
echo "source $HOME/livox_ws/install/setup.bash" >> $HOME/.bashrc
echo "" >> $HOME/.bashrc
