#!/bin/bash

echo "Activating ROS..."
source /opt/ros/kinetic/setup.bash

#ROS ext pkg
export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:/home/$USER/mocap/mocap_ws/src
echo "...done."

echo "Setting up PYTHONPATH."
export PYTHONPATH=/home/$USER/opencv-3.1.0/build/lib/python3:/home/$USER/mocap/mocap_ws/src:$PYTHONPATH

echo "Setup ROS_HOSTNAME."
export ROS_HOSTNAME=$HOSTNAME.local
export MOCAP_ROOT=$HOME/mocap
export DSO_PATH=$MOCAP_ROOT/software/dso

echo "Building machines file..."
make -C  $MOCAP_ROOT
echo "...done"
echo "Activating development."
source $MOCAP_ROOT/mocap_ws/devel/setup.bash

# TODO: check that the time is >= 2015

# TODO: run a python script that checks all libraries are installed

exec "$@" #Passes arguments. Need this for ROS remote launching to work.
