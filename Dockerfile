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
