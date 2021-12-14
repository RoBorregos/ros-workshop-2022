# Use the existing ROS-NOETIC image
FROM osrf/ros:noetic-desktop-full

LABEL maintainer="Jose Cisneros <A01283070@itesm.mx>"

# Install SO dependencies
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    nano \
    python3-pip \
    libtool \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    --no-install-recommends terminator \
    && rm -rf /var/lib/apt/lists/*

# Install Turtlebot SO dependencies
RUN apt-get update -qq && \
    apt-get install -y \
    ros-noetic-joy ros-noetic-teleop-twist-joy \
    ros-noetic-teleop-twist-keyboard ros-noetic-laser-proc \
    ros-noetic-rgbd-launch ros-noetic-rosserial-arduino \
    ros-noetic-rosserial-python ros-noetic-rosserial-client \
    ros-noetic-rosserial-msgs ros-noetic-amcl ros-noetic-map-server \
    ros-noetic-move-base ros-noetic-urdf ros-noetic-xacro \
    ros-noetic-compressed-image-transport ros-noetic-rqt* ros-noetic-rviz \
    ros-noetic-gmapping ros-noetic-navigation ros-noetic-interactive-markers \
    ros-noetic-dynamixel-sdk \
    ros-noetic-turtlebot3-msgs \
    ros-noetic-turtlebot3

RUN apt-get update && \
    apt-get -y install libgl1-mesa-glx libgl1-mesa-dri mesa-utils && \
    rm -rf /var/lib/apt/lists/*

# Install python dependencies
COPY python_requirements.txt /
RUN pip3 install -r /python_requirements.txt

ARG REPO_WS=catkin_ws

# Init catkin workspace directoy
RUN mkdir /$REPO_WS
COPY $REPO_WS/ $REPO_WS/

# Change Workdir
WORKDIR /$REPO_WS

# catkin_make
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash;catkin_make'

# Add ROS environment variables automatically
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "[ -f /$REPO_WS/devel/setup.bash ] && source /$REPO_WS/devel/setup.bash" >> ~/.bashrc

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
