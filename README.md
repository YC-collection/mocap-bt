# mocap-bt
meta package for project mocap

git clone https://github.com/mocapNCTU/mocap-bt.git mocap

with the folder name "mocap" under ~/ 

ubuntu16.04 ROS kinetic 

##Installation

Building
========

`cd ~/mocap`
`source install_software.sh`

it will install ROS Kinetic, Apriltags-cpp, Pangolin, dso, LCM, drake motion planning library etc
if you prefer manual install it. 
Just install 3 main library Pangolin, dso for GUI

### Building apriltags-cpp
```
    cd $HOME/mocap/software/apriltags-cpp
    mkdir build
    cd build
    cmake .. -DCMAKE_BUILD_TYPE=Release
    make
    sudo make install
```


### Building Pangolin
```
    sudo apt-get install libglew-dev
    sudo apt-get install libsuitesparse-dev
    cd $HOME/mocap/software/Pangolin
    mkdir build                                                                                                                      
    cd build
    cmake ..
    make -j
```

### Building dso
```
    cd $HOME/mocap/software/dso
    sudo apt-get install zlib1g-dev
    cd dso/thirdparty
    tar -zxvf libzip-1.1.1.tar.gz
    cd libzip-1.1.1/
    ./configure
    make
    sudo make install

    cd $HOME/mocap/software/dso
    cd dso 
    mkdir build
    cd build
    cmake ..
    make -j
```

### Usage

Try launch apriltags detection without RVIZ msgs overhead

T1:`roslaunch img_capture img_capture.launch`


Try GUI base on Pangolin and dso

#Demo videos

[![mocap-gui](https://github.com/mocapNCTU/mocap-bt/blob/master/software/mocap-gui.png)](https://www.youtube.com/watch?v=JL7ras7Z7Tc)

Open 2 terminal shows like this, you can utilize byobu tool.
don't forget your /dev/video0 or /dev/video1 avalaible in usb_cam-test.launch

T1: `roslaunch usb_cam usb_cam-test.launch`

T2: `rosrun dso_ros dso_live image:=/usb_cam/image_raw calib=/PATH_TO/dso_ros/camera.txt gamma=/PATH_TO/src/dso_ros/pcalib.txt vignette=/PATH_TO/src/dso_ros/vignette.png`

for example

`rosrun dso_ros dso_live image:=/usb_cam/image_raw calib=/home/rapyuta/dso_ws/src/dso_ros/camera.txt gamma=/home/rapyuta/dso_ws/src/dso_ros/pcalib.txt vignette=/home/rapyuta/dso_ws/src/dso_ros/vignette.png`

Habonbon!
