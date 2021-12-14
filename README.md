# Ros Workshop 2022

## Instructor & Contact Info
| Nombre | Correo | Github |
| ---- | ----- | ------ |
| José Cisneros | [joseacisnerosm@gmail.com](mailto:joseacisnerosm@gmail.com) | [@Josecisneros001](https://github.com/Josecisneros001) |

## Requirements

* Ubuntu System (any Distro)
* Docker
    * Follow up the installation tutorial: https://docs.docker.com/engine/install/ubuntu/
* Nvidia Support Installation (Optional, Rviz & Gazebo could also run with Intel Integrated Graphics Card):
    ```bash
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID) && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

    sudo apt-get update

    sudo apt-get install -y nvidia-docker2

    sudo systemctl restart docker
    ```

    [Reference](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)

* Github Repository
    ```bash
    # Cloning with HTTP
    git clone https://github.com/RoBorregos/ros-workshop-2022.git

    # Cloning with SSH
    git clone git@github.com:RoBorregos/ros-workshop-2022.git

    # Moving into the repo
    cd ros-workshop-2022
    ```
## Setup

Build Docker Image and create Docker Container every time there is a change to the Dockerfile.

1-.
```bash
    sudo make ros.build
```

2-. Give Executable Permissions if necessary
```bash
chmod +x ./run_scripts/*
```
3-.
* Create with Nvidia Support
```bash
    sudo make ros.nvidia.create
```

* Create with Intel Support
```bash
    sudo make ros.intel.create
```

* Create without gpu (Rviz & Gazebo will not work)
```bash
    sudo make ros.create
```

## Run
1-.
* Run container and fire up a shell
```bash
    sudo make ros.up
    sudo make ros.shell
```

## Stop

* Stop container
```bash
    sudo make ros.down
```

## Helpful Commands
* Insided the container:
    - Use several terminals with _terminator_
        ```bash
            terminator -u
        ```
* Outside the container:
    - Show a list of all existing containers.
    ```bash
        sudo make list
    ```

    - Show a list of all running containers.
    ```bash
        sudo make listUp
    ```

> See Makefile to discover other useful commands to manipulate Docker Containers.
