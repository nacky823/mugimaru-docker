# mugimaru-docker

## Installation
+ Build command
    ```
    docker build --build-arg USERNAME=$USER \
    --build-arg UID_AND_GID=$(id -u $USER) \
    -t mugimaru:latest .
    ```
+ Run command
    ```
    docker run -it --rm --gpus all \
    --privileged \
    --net=host \
    --ipc=host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --mount type=bind,source=/dev,target=/dev \
    --mount type=bind,source=/home/$USER/.ssh,target=/home/$USER/.ssh \
    --runtime=nvidia \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -v /var/run/NetworkManager:/var/run/NetworkManager \
    mugimaru:latest
    ```
+ Run a script in a container
    ```
    ./install_packages.bash
    ```