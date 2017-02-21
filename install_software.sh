#/bin/bash
# Peter KT Yu, 2015


function ask {
    echo $1        # add this line
    read -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        return 1;
    else
        exit
        echo "Abort.."
    fi
}

if [ "$#" == 0 ] || [ "$1" == "APT" ]; then
    echo "Install useful packages from apt-get"
    sudo apt-get update
    sudo apt-get --yes install git gitk git-gui geany geany-plugins vim terminator meshlab recordmydesktop meld sagasu openssh-server retext filezilla vlc ipython mesa-utils bmon libyaml-0-2
    sudo apt-get --yes install hardinfo cpufrequtils   # for speedup cpu
        
    sudo apt-get --yes install kcachegrind kcachegrind-converters
    sudo apt-get --yes install build-essential cmake debhelper freeglut3-dev gtk-doc-tools libboost-filesystem-dev libboost-iostreams-dev libboost-program-options-dev libboost-random-dev libboost-regex-dev libboost-signals-dev libboost-system-dev libboost-thread-dev libcurl4-openssl-dev libfreeimage-dev libglew-dev libgtkmm-2.4-dev libltdl-dev libgsl0-dev libportmidi-dev libprotobuf-dev libprotoc-dev libqt4-dev libqwt-dev libtar-dev libtbb-dev libtinyxml-dev libxml2-dev ncurses-dev pkg-config protobuf-compiler python-matplotlib libvtk5.8 libvtk5-dev libvtk5-qt4-dev libqhull-dev python-pygame doxygen mercurial libglib2.0-dev openjdk-6-jdk python-dev gfortran f2c libf2c2-dev spacenavd libspnav-dev python-numpy python-scipy python-vtk python-pip libgmp3-dev libblas-dev liblapack-dev libv4l-dev subversion libxmu-dev libusb-1.0-0-dev python-pymodbus graphviz curl libwww-perl libterm-readkey-perl g++-4.4

    sudo apt-get --yes install libopenal-dev # for drake converting wrl file
    sudo apt-get --yes install libgl1-mesa-dev  # for libbot libGL.so
    # sudo apt-get --yes install virtualbox
    sudo apt-get --yes install compizconfig-settings-manager
    sudo apt-get --yes install libudev-dev  # for realsense
    sudo apt-get --yes install libopencv-*  
    sudo apt-get --yes install libcgal-qt5-dev libcgal-dev  # for pr apriltags
    #sudo pip install --upgrade scipy
    sudo pip install chan 
    sudo pip install openpyxl
    sudo pip install sklearn
    sudo pip install plyfile
    sudo pip install tabulate
    sudo pip install ipdb
    sudo pip install pyprof2calltree
    sudo pip install tabulate
    sudo easy_install pycollada
    sudo apt-get --yes install byacc flex
    sudo apt-get --yes install kazam
fi

if [ "$#" == 0 ] || [ "$1" == "ARDUINO" ]; then
    cd ~/Downloads/
    wget -O arduino-1.6.11-linux64.tar.xz -P ~/Downloads http://web.mit.edu/peterkty/www/shared/arduino/arduino-1.6.11-linux64.tar.xz  
    mkdir -p $HOME/software
    tar -xvf ~/Downloads/arduino-1.6.11-linux64.tar.xz -C $HOME/software
    cd $HOME/software/arduino-1.6.11
    ./install.sh
    sudo ln -s $HOME/software/arduino-1.6.11/arduino /usr/local/bin/arduino
    sudo usermod -aG dialout robot
    echo 'ARDUINO install done'
fi

if [ "$#" == 0 ] || [ "$1" == "LCM" ]; then
  # install LCM
  wget -P ~/Downloads -q https://github.com/lcm-proj/lcm/releases/download/v1.3.1/lcm-1.3.1.zip
  mkdir -p $HOME/software
  unzip -o ~/Downloads/lcm-1.3.1.zip -d $HOME/software
  
  cd $HOME/software/lcm-1.3.1
  ./bootstrap.sh
  ./configure
  make
  sudo make install
fi

if [ "$#" == 0 ] || [ "$1" == "LIBBOT" ]; then
  mkdir -p $HOME/software
  cd $HOME/software
  git clone https://github.com/mit212/libbot.git
  cd libbot
  make -j
  sudo cp -r ../build/* /usr/local/  # some weird situation for VM ware
  sudo cp -r build/* /usr/local/
fi


if [ "$#" == 0 ] || [ "$1" == "ROSK" ]; then
    echo "Install ROS Kinetic"
    
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116
    sudo apt-get update
    sudo apt-get --yes install ros-kinetic-desktop-full
    sudo rosdep init
    rosdep update
    sudo apt-get --yes install python-rosinstall
    source /opt/ros/kinetic/setup.bash
    
    sudo apt-get --yes install ros-kinetic-moveit-full
    sudo apt-get --yes install ros-kinetic-pcl-ros
    sudo apt-get --yes install ros-kinetic-joy
    sudo apt-get --yes install ros-kinetic-perception  # for cv_bridge
fi

if [ "$#" == 0 ] || [ "$1" == "APRILTAGCPP" ]; then
    cd $HOME/mocap/software/apriltags-cpp
    mkdir build
    cd build
    cmake .. -DCMAKE_BUILD_TYPE=Release
    make
    sudo make install
fi


if [ "$#" == 0 ] || [ "$1" == "PANGOLIN" ]; then
    echo "Install Pangolin"
    cd $HOME/mocap/software/Pangolin
    mkdir build
    cd build
    cmake ..
    make -j
fi

if [ "$#" == 0 ] || [ "$1" == "DSO" ]; then
    echo "Install dso"
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
    echo "Habonbon!!! everyone is happy :)"
fi
