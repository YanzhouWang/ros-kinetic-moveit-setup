#!/bin/bash
#ROS+MoveIt+basic dependencies installation

echo "Beginning ROS Installation"

echo -e "\e[1m \e[34m >>> Beginning ROS Kinetic Installation \e[21m \e[39m"
echo -e "\e[34m >>> Setting up sources.list and keys... \e[39m"

  sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
  sudo apt-key adv --keyserver hkp://pool.sks-keyservers.net --recv-key 0xB01FA116

echo -e "\e[34m >>> ...done\e[39m"

  sudo apt-get update

echo -e "\e[34m >>> Beginning ros-kinetic-desktop-full installation...\e[39m"

  sudo apt-get --yes install ros-kinetic-desktop-full 

echo -e "\e[34m >>> Setting up rosdep\e[39m"

  sudo rosdep init
  rosdep update

echo -e "\e[34m >>> Setting up environment \e[39m"

  echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
  source ~/.bashrc

echo -e "\e[34m >>> Setting up rosinstall \e[39m"

  sudo apt-get --yes install python-rosinstall

echo -e "\e[1m \e[34m >>> Installing Git \e[21m \e[39m"

  sudo apt-get --yes install git

echo -e "\e[1m \e[34m >>> Installing MoveIt! \e[21m \e[39m"
  sudo apt-get --yes install ros-kinetic-moveit


echo -e "\e[1m \e[34m >>> Configuring workspace \e[21m \e[39m"

USERNAME=$1
EMAIL=$2

if [ "$USERNAME" != "" ] || [ "$EMAIL" != "" ];
then
  source /opt/ros/kinetic/setup.bash
  echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
  rosdep update

  mkdir -p ~/ros_ws/src
	
  cd ~/ros_ws/src  && catkin_init_workspace
  cd ~/ros_ws && catkin_make

  git config --global user.name "$USERNAME"
  git config --global user.email "$EMAIL"

echo "source ~/ros_ws/devel/setup.bash" >> ~/.bashrc
  source ~/.bashrc

  cd ~/ros_ws && catkin_make
  cd ~/ros_ws && catkin_make install


  echo "alias cs_create_pkg='~/ros_ws/src/learning_ros_external_pkgs_kinetic/cs_create_pkg.py'" >> ~/.bashrc
  echo "source ~/ros_ws/devel/setup.bash" >> ~/.bashrc
  echo "export ROS_WORKSPACE='$HOME/ros_ws'" >> ~/.bashrc
  # echo "export ROS_IP=`ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`" >> ~/.bashrc



else
  echo "USAGE: ./setup_workspace_learning_ros your_github_username your_email@email.com"

fi

echo "[!!!] NB: You must still manually add your ROS_IP to your ~/.bashrc.  Do this by checking your IP with hostname -I or ifconfig and then adding export ROS_IP='x.x.x.x' to your ~/.bashrc."
  source ~/.bashrc
